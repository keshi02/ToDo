class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :content
      t.boolean :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :todos, [:user_id, :created_at]
  end
end
