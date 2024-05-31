class Todo < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, length: { maximum: 254 }

  def save_with_category(category_name:, user_id:)
    save
    if category_name.present?
      transaction do
        new_category = Category.find_or_create_by(name: category_name, user_id: user_id)
        self.update!(category_id: new_category.id)
      end
    end
  end
end
