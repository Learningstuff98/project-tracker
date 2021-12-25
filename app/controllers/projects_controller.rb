class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def new
    @project = Project.new
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
