class StagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def create
    @project = Project.find(params[:project_id])
    stage = @project.stages.create(stage_params)
    SendStageJob.perform_later(stage)
  end

  private

  def stage_params
    params.require(:stage).permit(:name)
  end
end
