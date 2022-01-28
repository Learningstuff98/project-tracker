class Project < ApplicationRecord
  belongs_to :user
  has_many :stages, dependent: :delete_all
  validates :name, presence: true
  paginates_per 8

  def project_owner?(user)
    user.id == user_id
  end
end
