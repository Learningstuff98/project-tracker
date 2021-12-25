class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.create(project_params)
    redirect_to project_path(@project)
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
