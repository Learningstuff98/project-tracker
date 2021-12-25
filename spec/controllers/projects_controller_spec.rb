require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe "GET #new" do
    it "should authenticate the user" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "should load the page" do
      user = FactoryBot.create(:user)
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end
  end
end
