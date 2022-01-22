require 'rails_helper'

RSpec.describe "Projects", type: :request do
  context "While logged in" do
    before do
      @user = FactoryBot.create(:user)
      sign_in(@user)
    end

    describe "GET #new" do
      it "should load the page" do
        get new_project_path
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      it "should let users make new projects" do
        post projects_path(
          user_id: @user.id,
          project: {
            name: "project name"
          }
        )
        expect(response).to be_redirect
        expect(Project.all.count).to eq 1
      end
    end

    describe "GET #show" do
      it "should load the page" do
        project = FactoryBot.create(:project)
        get project_path(project)
        expect(response).to be_successful
      end
    end

    describe "GET #edit" do
      it "should load the page" do
        project = FactoryBot.create(:project)
        get edit_project_path(project)
        expect(response).to be_successful
      end
    end

    describe "PATCH #update" do
      it "should let users update projects" do
        project = FactoryBot.create(:project)
        patch project_path(
          {
            id: project.id,
            project: {
              name: "new name"
            }
          }
        )
        expect(response).to be_redirect
        project.reload
        expect(project.name).to eq "new name"
      end
    end

    describe "DELETE #destroy" do
      it "should let users delete projects" do
        project = FactoryBot.create(:project)
        delete project_path(project)
        expect(response).to be_redirect
        expect(Project.all.count).to eq 0
      end
    end
  end
end
