class PagesController < ApplicationController

  def home
    if current_user
      @projects = current_user.projects.order("created_at DESC")
    end
  end

end
