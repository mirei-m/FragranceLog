FactoryBot.define do
  factory :calendar do
    association :user
    association :fragrance
    start_time { Time.current }
    weather { :sunny }
    mood { :happy }
    memo { "今日は良い香りでした。" }
  end

  trait :long_memo do
    memo { "a" * 1000 }
  end

  trait :too_long_memo do
    memo { "a" * 1001 }
  end

  trait :without_memo do
    memo { nil }
  end

  trait :without_weather do
    weather { nil }
  end

  trait :without_mood do
    mood { nil }
  end
end
