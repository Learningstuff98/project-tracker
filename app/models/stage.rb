class Stage < ApplicationRecord
  belongs_to :project
  has_many :issues, dependent: :delete_all
  validates :name, presence: true
end
