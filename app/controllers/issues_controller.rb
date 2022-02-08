class IssuesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[destroy]
  before_action :authenticate_user!
  before_action :require_authorized, only: %i[new create destroy]

  def new
    @project = current_project
    @stage = current_stage
    @issue = Issue.new
  end

  def create
    @project = current_project
    @stage = current_stage
    @issue = @stage.issues.create(issue_params)
    if @issue.save
      SendIssuesJob.perform_later(@project)
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
    @issue = current_issue
  end

  def destroy
    @project = current_project
    @issue = current_issue
    SendIssuesJob.perform_later(@project) if @issue.destroy
  end

  private

  def current_issue
    @current_issue ||= Issue.find(params[:id])
  end

  def current_project
    @current_project ||= Project.find(params[:project_id])
  end

  def current_stage
    @current_stage ||= Stage.find(params[:stage_id])
  end

  def issue_params
    params.require(:issue).permit(:title, :description)
  end
end
