FactoryBot.define do
  factory :review do
    body { "body" }
    association :user
    association :fragrance

    trait :long_body do
      body { "a" * 1000 }
    end

    trait :too_long_body do
      body { "a" * 1001 }
    end

    trait :empty_body do
      body { "" }
    end
  end
end
