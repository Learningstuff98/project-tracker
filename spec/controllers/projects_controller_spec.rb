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

  describe "GET #edit" do
    it "should authenticate the user" do
      project = FactoryBot.create(:project)
      get :edit, params: { id: project.id }
      expect(response).to redirect_to new_user_session_path
    end

    it "should not let other users get to the edit page" do
      project = FactoryBot.create(:project)
      user = FactoryBot.create(:user)
      sign_in user
      get :edit, params: { id: project.id }
      expect(response).to have_http_status(:unauthorized)
    end

    it "load the page for the correct user" do
      project = FactoryBot.create(:project)
      user = FactoryBot.create(:user)
      sign_in project.user
      get :edit, params: { id: project.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH #update" do
    it "should authenticate the user" do
      project = FactoryBot.create(:project)
      post :update, params: {
        id: project.id,
        project: {
          name: "new name"
        }
      }
      expect(response).to redirect_to new_user_session_path
    end

    it "should let the project owner make updates" do
      project = FactoryBot.create(:project)
      user = FactoryBot.create(:user)
      sign_in project.user
      post :update, params: {
        id: project.id,
        project: {
          name: "new name"
        }
      }
      expect(response).to have_http_status(:found)
      project.reload
      expect(project.name).to eq "new name"
    end

    it "should not let other users make updates" do
      project = FactoryBot.create(:project)
      user = FactoryBot.create(:user)
      sign_in user
      post :update, params: {
        id: project.id,
        project: {
          name: "new name"
        }
      }
      expect(response).to have_http_status(:unauthorized)
      project.reload
      expect(project.name).to eq "project name"
    end

    it "project names can't be blank" do
      project = FactoryBot.create(:project)
      user = FactoryBot.create(:user)
      sign_in project.user
      post :update, params: {
        id: project.id,
        project: {
          name: ""
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
      project.reload
      expect(project.name).to eq "project name"
    end
  end

  describe "DELETE #destroy" do
    it "should authenticate the user" do
      project = FactoryBot.create(:project)
      delete :destroy, params: { id: project.id }
      expect(response).to redirect_to new_user_session_path
    end

    it "should let the project owner delete the project" do
      project = FactoryBot.create(:project)
      user = FactoryBot.create(:user)
      sign_in project.user
      delete :destroy, params: { id: project.id }
      expect(response).to have_http_status(:found)
      expect(Project.all.count).to eq 0
    end

    it "should not let other users delete the project" do
      project = FactoryBot.create(:project)
      user = FactoryBot.create(:user)
      sign_in user
      delete :destroy, params: { id: project.id }
      expect(response).to have_http_status(:unauthorized)
      expect(Project.all.count).to eq 1
    end
  end
end
