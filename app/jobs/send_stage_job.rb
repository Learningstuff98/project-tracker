class SendStageJob < ApplicationJob
  queue_as :default

  def perform(stage)
    ActionCable.server.broadcast "project_channel", { stage: stage }
  end
end
