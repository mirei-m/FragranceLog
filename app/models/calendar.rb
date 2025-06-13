class Calendar < ApplicationRecord
  belongs_to :user
  belongs_to :fragrance

  validates :memo, length: { maximum: 1000 }
  validates :start_time, presence: true
  validates :user_id, uniqueness: { scope: :start_time, message: "この日はすでに記録があります" }

  enum weather: {
    sunny: 0,
    cloudy: 1,
    rainy: 2,
    snowy: 3
  }, _prefix: :weather

  enum mood: {
    happy: 0,
    relaxed: 1,
    neutral: 2,
    sad: 3,
    angry: 4,
    tired: 5
  }, _prefix: :mood
end
