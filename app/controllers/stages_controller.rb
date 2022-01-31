class StagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def create
    @project = Project.find(params[:project_id])
    stage = @project.stages.create(stage_params)
    SendStagesJob.perform_later(@project) if stage.save
  end

  def destroy
    @stage = Stage.find(params[:id])
    project = @stage.project
    @stage.destroy
    SendStagesJob.perform_later(project)
  end

  private

  def stage_params
    params.require(:stage).permit(:name)
  end
end
