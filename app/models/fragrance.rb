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
end
