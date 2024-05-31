class Category < ApplicationRecord
  has_many :todos
  belongs_to :user
  validates :name, length: { maximum: 20 }
end
