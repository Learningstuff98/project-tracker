class ProjectsController < ApplicationController
  before_action :authenticate_user!

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
    render plain: 'Unauthorized', status: :unauthorized unless @project.project_owner?(current_user)
  end

  def update
    @project = current_project
    if !@project.project_owner?(current_user)
      render plain: 'Unauthorized', status: :unauthorized
    elsif @project.update(project_params)
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project = current_project
    if !@project.project_owner?(current_user)
      render plain: 'Unauthorized', status: :unauthorized
    elsif !@project.destroy
      flash[:error] = "Failed to delete project."
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def current_project
    @current_project ||= Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
