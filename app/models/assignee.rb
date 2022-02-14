class Assignee < ApplicationRecord
  belongs_to :issue
  validates :assignee_username, presence: true
end
