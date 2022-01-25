class PagesController < ApplicationController
  def home
    @projects = current_user.projects.order("created_at DESC") if current_user
  end
end
