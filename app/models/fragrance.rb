class Fragrance < ApplicationRecord
  validates :name, presence: true
  validates :brand, presence: true

  belongs_to :user
end
