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
      flash[:success] = "ToDoを作成しました!"
      redirect_to todos_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit_multiple
    @errors = []
  end

  def update_multiple
    @errors = []
    # フォームから送信された各Todoを処理します
    todos_params.each do |id, todo_attributes|
      todo = current_user.todos.find(id)
      unless todo.update(todo_attributes.permit(:title, :content))
        @errors.push(todo.errors.full_messages)
        @invalid_todo = todo
      end
    end
    if @invalid_todo.nil?
      redirect_to todos_path, success: "更新されました!"
    else
      render :edit_multiple, status: :unprocessable_entity
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :content)
  end

  def todos_params
    todos_params = params.require(:todos)
  end
end
