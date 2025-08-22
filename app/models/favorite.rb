class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :review

  # 同じユーザーが同じレビューを複数回お気に入りできないように
  validates :user_id, uniqueness: { scope: :review_id }
end
