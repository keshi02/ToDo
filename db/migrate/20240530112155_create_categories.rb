class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :categories, [:user_id, :name], unique: true
  end
end
