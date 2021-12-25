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

  describe "POST #create" do
    it "should authenticate the user" do
      post :create
      expect(response).to redirect_to new_user_session_path
    end

    it "users should be able to start projects" do
      user = FactoryBot.create(:user)
      sign_in user
      post :create, params: {
        user_id: user.id,
        project: { name: "project name" }
      }
      expect(response).to have_http_status(:found)
      expect(Project.all.count).to eq 1
    end

    it "project names can't be blank" do
      user = FactoryBot.create(:user)
      sign_in user
      post :create, params: {
        user_id: user.id,
        project: { name: "" }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET #show" do
    it "should load the page" do
      project = FactoryBot.create(:project)
      get :show, params: { id: project.id }
      expect(response).to have_http_status(:success)
    end
  end
end
