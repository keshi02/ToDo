class AddColumnToTodo < ActiveRecord::Migration[7.1]
  def change
    add_reference :todos, :category, foreign_key: true
  end
end
