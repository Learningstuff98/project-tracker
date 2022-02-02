class StagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  before_action :require_authorized

  def create
    stage = current_project.stages.create(stage_params)
    SendStagesJob.perform_later(current_project) if stage.save
  end

  def destroy
    current_stage.destroy
    SendStagesJob.perform_later(current_project)
  end

  def update
    SendStagesJob.perform_later(current_project) if current_stage.update(stage_params)
  end

  private

  def require_authorized
    render plain: 'Unauthorized', status: :unauthorized unless current_project.project_owner?(current_user)
  end

  def current_project
    @current_project ||= Project.find(params[:project_id])
  end

  def current_stage
    @current_stage ||= Stage.find(params[:id])
  end

  def stage_params
    params.require(:stage).permit(:name)
  end
end
