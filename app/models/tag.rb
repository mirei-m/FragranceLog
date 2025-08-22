class Tag < ApplicationRecord
  has_many :fragrance_tags, dependent: :destroy
  has_many :fragrances, through: :fragrance_tags

  validates :name, presence: true, uniqueness: true

    # ransack用の検索設定
    def self.ransackable_attributes(auth_object = nil)
      %w[name id]
    end

    def self.ransackable_associations(auth_object = nil)
      %w[fragrances fragrance_tags]
    end
end
