FactoryBot.define do
  factory :fragrance do
    sequence(:name) { |n| "香水#{n}" }
    sequence(:brand) { |n| "ブランド#{n}" }
    status { :unpublished }
    sweetness { rand(1..5) }
    freshness { rand(1..5) }
    floral { rand(1..5) }
    calm { rand(1..5) }
    sexy { rand(1..5) }
    spicy { rand(1..5) }

    association :user

    trait :published do
      status { :published }
    end
  end
end
