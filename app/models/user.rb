class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def password?(raw)
    BCrypt::Password.new(password_digest).is_password?(raw)
  end
end
