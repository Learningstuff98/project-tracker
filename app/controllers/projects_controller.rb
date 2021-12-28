class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.create(project_params)
    if @project.valid?
      redirect_to project_path(@project)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @project = current_project
  end

  def edit
    @project = current_project
    if current_user.id != @project.user_id
      render plain: 'Unauthorized', status: :unauthorized
    end
  end

  def update
    @project = current_project
    if current_user.id == @project.user_id
      @project.update(project_params)
      if @project.valid?
        redirect_to project_path(@project)
      else
        render :edit, status: :unprocessable_entity
      end
    else
      render plain: 'Unauthorized', status: :unauthorized
    end
  end

  def destroy
    @project = current_project
    if current_user.id == @project.user_id
      @project.destroy
      redirect_to root_path
    else
      render plain: 'Unauthorized', status: :unauthorized
    end
  end

  private

  def current_project
    @project ||= Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end

end
