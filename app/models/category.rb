class Category < ApplicationRecord
  belongs_to :user
  validates :name, length: { maximum: 20 }
end
