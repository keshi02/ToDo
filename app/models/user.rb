class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 254 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
  has_many :todos
end
