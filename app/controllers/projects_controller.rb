class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized, only: %i[edit update destroy]

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.create(project_params)
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
    @project = current_project
  end

  def edit
    @project = current_project
  end

  def update
    @project = current_project
    if @project.update(project_params)
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project = current_project
    flash[:error] = "Failed to delete project." unless @project.destroy
    redirect_to root_path
  end

  private

  def require_authorized
    @project = current_project
    render plain: 'Unauthorized', status: :unauthorized unless @project.project_owner?(current_user)
  end

  def current_project
    @current_project ||= Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
