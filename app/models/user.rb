class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def password?(raw)
    BCrypt::Password.new(password_digest).is_password?(raw)
  end
end