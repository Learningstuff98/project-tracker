require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET #home" do
    it "should load the page" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end
end
