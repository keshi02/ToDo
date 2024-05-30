class Todo < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, length: { maximum: 254 }
end
