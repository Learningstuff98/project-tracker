class Issue < ApplicationRecord
  belongs_to :stage
  validates :title, presence: true
  has_rich_text :description
  validates :description, presence: true
  has_many :assignees, dependent: :delete_all
end
