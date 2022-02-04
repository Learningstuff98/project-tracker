class Issue < ApplicationRecord
  belongs_to :stage
  validates :title, presence: true
end
