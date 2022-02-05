class Issue < ApplicationRecord
  belongs_to :stage
  validates :title, presence: true
  has_rich_text :description
  validates :description, presence: true
end
