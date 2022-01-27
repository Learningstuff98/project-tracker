class PagesController < ApplicationController
  def home
    @projects = search(params[:keyword]) if current_user
  end

  private

  def search(keyword)
    if keyword.present?
      Project.where("name ILIKE ?", "%#{keyword}%").order("created_at DESC").page params[:page]
    else
      current_user.projects.order("created_at DESC").page params[:page]
    end
  end
end
