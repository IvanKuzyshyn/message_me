class User < ApplicationRecord
  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: { minimum: 3, maximum: 255 }
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEXP, message: "should match required format" }

  has_secure_password
end
