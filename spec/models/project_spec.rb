require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "associations" do
    it { should belong_to(:user).class_name("User") }
    it { should have_many(:stages).class_name("Stage") }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
