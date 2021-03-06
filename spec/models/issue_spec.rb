require 'rails_helper'

RSpec.describe Issue, type: :model do
  describe "associations" do
    it { should belong_to(:stage).class_name("Stage") }
    it { should have_many(:assignees).class_name("Assignee") }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end
end
