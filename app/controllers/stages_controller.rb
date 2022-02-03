class StagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  before_action :require_authorized

  def create
    @project = current_project
    @stage = @project.stages.create(stage_params)
    SendStagesJob.perform_later(@project) if @stage.save
  end

  def destroy
    @project = current_project
    @stage = current_stage
    @stage.destroy
    SendStagesJob.perform_later(@project)
  end

  def update
    @project = current_project
    @stage = current_stage
    SendStagesJob.perform_later(@project) if @stage.update(stage_params)
  end

  private

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
