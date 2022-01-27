class PagesController < ApplicationController
  def home
    @projects = search(params[:keyword])
  end

  private

  def search(keyword)
    if keyword.present?
      Project.where("name ILIKE ?", "%#{keyword}%")
    else
      current_user.projects.order("created_at DESC")
    end
  end
end
