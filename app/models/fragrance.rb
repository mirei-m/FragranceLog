class Fragrance < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }
  validates :brand, presence: true, length: { maximum: 50 }
  validates :sweetness, :freshness, :floral, :calm, :sexy, :spicy,
          allow_nil: true,
          numericality: { only_integer: true, greater_than: 0, less_than: 6 }

  enum status: { unpublished: 0, published: 1 }

  belongs_to :user
  has_one_attached :image
  has_many :calendars, dependent: :destroy
  has_one :review, dependent: :destroy
  has_many :fragrance_tags, dependent: :destroy
  has_many :tags, through: :fragrance_tags

  validate :tags_count_within_limit

  # ransack用の検索設定
  def self.ransackable_attributes(auth_object = nil)
    %w[name brand]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[reviews]
  end

  private

  # タグの数を最大3つに制限
  def tags_count_within_limit
    if tags.size > 3
      errors.add(:tags, 'は3つまでしか選択できません')
    end
  end
end
