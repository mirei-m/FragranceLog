class Review < ApplicationRecord
  belongs_to :user
  belongs_to :fragrance

  validates :body, presence: true
  validates :fragrance_id, uniqueness: { scope: :user_id, message: "この香水はすでにレビュー済みです" }
end
