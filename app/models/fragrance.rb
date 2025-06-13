class Fragrance < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }
  validates :brand, presence: true, length: { maximum: 50 }

  belongs_to :user
  has_one_attached :image
  has_many :calendars, dependent: :destroy
end
