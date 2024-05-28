class TodosController < ApplicationController
  def index
    @user = current_user
    @todos = @user.todos.order(created_at: :desc)
  end

  def show
    @todo = current_user.todos.find(params[:id])
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :content)
  end
end
