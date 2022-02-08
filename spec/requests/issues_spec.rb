require 'rails_helper'

RSpec.describe "Issues", type: :request do
  context "while logged in as the project owner" do
    before do
      @project = FactoryBot.create(:project)
      @stage = FactoryBot.create(:stage)
      sign_in(@project.user)
    end

    describe "GET #new" do
      it "should load the page" do
        get new_project_stage_issue_path(@project, @stage)
        expect(response).to be_successful
      end
    end

    describe "POST #create" do
      it "should let users create issues" do
        post project_stage_issues_path(
          project_id: @project.id,
          stage_id: @stage.id,
          issue: {
            title: "issue title",
            description: "issue description"
          }
        )
        expect(response).to be_redirect
        expect(Issue.all.count).to eq 1
      end
    end

    describe "GET #show" do
      it "should load the page" do
        issue = FactoryBot.create(:issue)
        get issue_path(issue)
        expect(response).to be_successful
      end
    end

    describe "DELETE #destroy" do
      it "should let users delete issues" do
        issue = FactoryBot.create(:issue)
        delete project_issue_path(@project, issue)
        expect(Issue.all.count).to eq 0
      end
    end
  end

  context "while logged in as a foreign user" do
    before do
      @project = FactoryBot.create(:project)
      @stage = FactoryBot.create(:stage)
      @user = FactoryBot.create(:user)
      sign_in(@user)
    end

    describe "GET #new" do
      it "should be unauthorized" do
        get new_project_stage_issue_path(@project, @stage)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "POST #create" do
      it "should be unauthorized" do
        post project_stage_issues_path(
          project_id: @project.id,
          stage_id: @stage.id,
          issue: {
            title: "issue title",
            description: "issue description"
          }
        )
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "GET #show" do
      it "should load the page" do
        issue = FactoryBot.create(:issue)
        get issue_path(issue)
        expect(response).to be_successful
      end
    end

    describe "DELETE #destroy" do
      it "should be unauthorized" do
        issue = FactoryBot.create(:issue)
        delete project_issue_path(@project, issue)
        expect(response).to have_http_status(:unauthorized)
        expect(Issue.all.count).to eq 1
      end
    end
  end
end
