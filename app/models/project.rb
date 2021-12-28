class Project < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { minimum: 3 }

  def project_owner?(current_user)
    current_user == self.user
  end

end
