class Review < ApplicationRecord
  belongs_to :user
  belongs_to :fragrance

  validates :body, presence: true, length: { maximum: 1000 }
  validates :fragrance_id, uniqueness: { scope: :user_id, message: "はすでにレビュー済みです" }

  after_create :make_fragrance_public
  after_destroy :revert_fragrance_status

  private

  def make_fragrance_public
    fragrance.update(status: :published) if fragrance.unpublished?
  end

  def revert_fragrance_status
    fragrance.update(status: :unpublished)
  end
end
