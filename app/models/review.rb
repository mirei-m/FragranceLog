class Review < ApplicationRecord
  belongs_to :user
  belongs_to :fragrance

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  validates :body, presence: true, length: { maximum: 1000 }
  validates :fragrance_id, uniqueness: { scope: :user_id, message: "はすでにレビュー済みです" }

  after_create :make_fragrance_public
  after_destroy :revert_fragrance_status

  # ransackの検索設定
  def self.ransackable_attributes(auth_object = nil)
    %w[body]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[fragrance user]
  end

  private

  def make_fragrance_public
    fragrance.update(status: :published) if fragrance.unpublished?
  end

  def revert_fragrance_status
    fragrance.update(status: :unpublished)
  end
end
