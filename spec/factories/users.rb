FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }

    trait :with_oauth do
      provider { "google" }
      sequence(:uid) { |n| "google_uid_#{n}" }
    end
  end
end
