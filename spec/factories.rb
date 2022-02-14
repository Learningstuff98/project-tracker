FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    sequence :username do |n|
      "dummy_user_name#{n}"
    end
    password { "secretPassword" }
    password_confirmation { "secretPassword" }
  end

  factory :project do
    name { "project name" }
    association :user
  end

  factory :stage do
    name { "stage name" }
    association :project
  end

  factory :issue do
    title { "issue title" }
    description { "issue description" }
    association :stage
  end

  factory :assignee do
    assignee_username { "assignee username" }
    association :issue
  end
end
