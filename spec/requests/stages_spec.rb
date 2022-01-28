require 'rails_helper'

RSpec.describe "Stages", type: :request do
  context "while logged in as the project owner" do
    before do
      @user = FactoryBot.create(:user)
      @project = FactoryBot.create(:project)
      sign_in @project.user
    end

    describe "POST #create" do
      it "should let users create stages" do
        post project_stages_path(
          project_id: @project.id,
          stage: {
            name: "stage name"
          }
        )
        expect(Stage.all.count).to eq 1
      end
    end

    describe "PATCH #update" do
      it "should let users update stages" do
        stage = FactoryBot.create(:stage)
        patch stage_path(
          {
            id: stage.id,
            stage: {
              name: "new name"
            }
          }
        )
        stage.reload
        expect(stage.name).to eq "new name"
      end
    end

    describe "DELETE #destroy" do
      it "should let users delete stages" do
        stage = FactoryBot.create(:stage)
        delete stage_path(stage)
        expect(Stage.all.count).to eq 0
      end
    end
  end

  context "While logged in as a foreign user" do
    before do
      @user = FactoryBot.create(:user)
      @project = FactoryBot.create(:project)
      sign_in @user
    end

    describe "POST #create" do
      it "should be unauthorized" do
        post project_stages_path(
          project_id: @project.id,
          stage: {
            name: "stage name"
          }
        )
        expect(response).to have_http_status(:unauthorized)
        expect(Stage.all.count).to eq 0
      end
    end

    describe "PATCH #update" do
      it "should be unauthorized" do
        stage = FactoryBot.create(:stage)
        patch stage_path(
          {
            id: stage.id,
            stage: {
              name: "new name"
            }
          }
        )
        expect(response).to have_http_status(:unauthorized)
        stage.reload
        expect(stage.name).to eq "stage name"
      end
    end

    describe "DELETE #destroy" do
      it "should be unauthorized" do
        stage = FactoryBot.create(:stage)
        delete stage_path(stage)
        expect(response).to have_http_status(:unauthorized)
        expect(Stage.all.count).to eq 1
      end
    end
  end
end
