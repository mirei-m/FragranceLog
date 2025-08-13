class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :fragrances, dependent: :destroy
  has_many :calendars, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_one_attached :profile_image

  validates :name, presence: true, length: { maximum: 255 }
end
