class Tag < ApplicationRecord
  has_many :fragrance_tags, dependent: :destroy
  has_many :fragrances, through: :fragrance_tags

  validates :name, presence: true, uniqueness: true
end
