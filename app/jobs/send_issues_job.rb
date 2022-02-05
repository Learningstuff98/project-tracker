class SendIssuesJob < ApplicationJob
  queue_as :default

  def perform(project)
    ActionCable.server.broadcast "project_channel", {
      project: project,
      issues: project.collect_all_issues
    }
  end
end
