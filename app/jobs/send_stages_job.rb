class SendStagesJob < ApplicationJob
  queue_as :default

  def perform(project)
    ActionCable.server.broadcast "project_channel", {
      project: project,
      stages: project.stages
    }
  end
end
