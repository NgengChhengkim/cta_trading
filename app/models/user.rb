class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  devise :omniauthable, :omniauth_providers => [:google_oauth2, :facebook]

  has_many :invoices, as: :customer, dependent: :destroy

  has_many :product_carts, dependent: :destroy
  has_many :carts, through: :product_carts, source: :product

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: {minimum: 4}
  validates :phone_number, presence: true
  validates :role, presence: true

  scope :find_users, -> ids{where id: ids}

  enum role: [:admin, :editor, :customer]

  class << self
    def from_omniauth access_token
      data = access_token.info
      user = User.find_by email: data.email
      unless user
        password = Devise.friendly_token[0,20]
        user = User.new name: data.name, email: data.email, password: password,
          password_confirmation: password, remote_avatar_url: data.image
        user.save validate: false
      end
      user
    end
  end
end
