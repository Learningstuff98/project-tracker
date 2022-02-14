require 'rails_helper'

RSpec.describe "Assignees", type: :request do
  context "while logged in" do
    before do
      @issue = FactoryBot.create(:issue)
      user = FactoryBot.create(:user)
      sign_in user
    end

    describe "POST #create" do
      it "should let users assign themselves to issues" do
        post issue_assignees_path(
          issue_id: @issue.id,
          assignee: {
            assignee_username: "MyUserName"
          }
        )
        expect(Assignee.all.count).to eq 1
      end
    end

    describe "GET #index" do
      it "should load the json endpoint" do
        get issue_assignees_path(@issue)
        expect(response).to be_successful
      end
    end

    describe "DELETE #destroy" do
      it "should let users unassign themselves from issues" do
        assignee = FactoryBot.create(:assignee)
        delete assignee_path(assignee)
        expect(Assignee.all.count).to eq 0
      end
    end
  end
end
