class AssigneesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create destroy]
  before_action :authenticate_user!

  def create
    @issue = current_issue
    @issue.assignees.create(assignee_params)
  end

  def index
    issue = current_issue
    assignees = issue.assignees
    render json: assignees
  end

  def destroy
    assignee = Assignee.find(params[:id])
    assignee.destroy
  end

  private

  def current_issue
    @current_issue ||= Issue.find(params[:issue_id])
  end

  def assignee_params
    params.require(:assignee).permit(:assignee_username, :issue_id, :assignee_id)
  end
end
