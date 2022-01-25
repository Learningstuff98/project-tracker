class Project < ApplicationRecord
  belongs_to :user
  validates :name, presence: true

  def project_owner?(user)
    user.id == user_id
  end
end
