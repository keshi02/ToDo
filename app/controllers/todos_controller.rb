class TodosController < ApplicationController
  def index
    @user = current_user
    @todos = @user.todos.order(created_at: :desc)
  end
end
