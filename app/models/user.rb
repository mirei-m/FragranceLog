class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  has_many :fragrances, dependent: :destroy
  has_many :calendars, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_reviews, through: :favorites, source: :review

  has_one_attached :profile_image

  validates :name, presence: true, length: { maximum: 255 }
  validates :uid, uniqueness: { scope: :provider }, allow_nil: true
  validates :profile_image, content_type: { in: %w[image/jpeg image/gif image/png] },
                          size: { less_than: 5.megabytes },
                          if: -> { profile_image.attached? }

  def own?(object)
    id == object.user_id
  end

  # Google認証用
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
      user.provider = auth.provider
      user.uid = auth.uid
    end
  end
end
