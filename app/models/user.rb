class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :fragrances, dependent: :destroy
  has_many :calendars, dependent: :destroy
  has_many :reviews, dependent: :destroy
end
