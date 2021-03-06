class IssuesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[destroy move_issue]
  before_action :authenticate_user!
  before_action :require_authorized, only: %i[new create destroy edit update]

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
    @project = current_project
    @issue = current_issue
    @assignees = @issue.assignees
  end

  def destroy
    @project = current_project
    @issue = current_issue
    SendIssuesJob.perform_later(@project) if @issue.destroy
  end

  def edit
    @project = current_project
    @issue = current_issue
  end

  def update
    @project = current_project
    @issue = current_issue
    if @issue.update(issue_params)
      SendIssuesJob.perform_later(@project)
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def move_issue
    @project = current_project
    @issue = current_issue
    SendIssuesJob.perform_later(@project) if @issue.update(issue_params)
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
    params.require(:issue).permit(:title, :description, :stage_id)
  end
end
