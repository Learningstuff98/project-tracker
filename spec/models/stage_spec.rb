require 'rails_helper'

RSpec.describe Stage, type: :model do
  describe "associations" do
    it { should belong_to(:project).class_name("Project") }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
