class Calendar < ApplicationRecord
  belongs_to :user
  belongs_to :fragrance

  validates :fragrance_id, presence: true
  validates :start_time, presence: true
  validates :user_id, uniqueness: { scope: :start_time, message: "この日はすでに記録があります" }
end
