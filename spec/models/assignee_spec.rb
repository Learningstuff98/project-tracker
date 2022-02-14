require 'rails_helper'

RSpec.describe Assignee, type: :model do
  describe "associations" do
    it { should belong_to(:issue).class_name("Issue") }
  end

  describe "validations" do
    it { should validate_presence_of(:assignee_username) }
  end
end
