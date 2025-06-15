class Review < ApplicationRecord
  belongs_to :user
  belongs_to :fragrance

  validates :body, presence: true, length: { maximum: 1000 }
  validates :fragrance_id, uniqueness: { scope: :user_id, message: "はすでにレビュー済みです" }
end
