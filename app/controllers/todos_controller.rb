class TodosController < ApplicationController
  def index
    @user = current_user
    @todos = @user.todos.order(created_at: :desc)
  end

  def show
    @todo = current_user.todos.find(params[:id])
  end

  def new
    @todo = current_user.todos.build
  end

  def create
    @todo = current_user.todos.build(todo_params)
    if @todo.save
      flash[:success] = "ToDoを作成しました！"
      redirect_to todos_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :content)
  end
end
