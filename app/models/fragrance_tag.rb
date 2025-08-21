class FragranceTag < ApplicationRecord
  belongs_to :fragrance
  belongs_to :tag

  # 同じ香水に同じタグが重複して付けられないようにする
  validates :fragrance_id, uniqueness: { scope: :tag_id }
end
