class SessionsController < ApplicationController
  skip_before_action :require_login
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      reset_session
      log_in(@user)
      flash[:success] = "ログインしました"
      redirect_to root_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    if current_user
      reset_session
      session.delete(:user_id)
      flash[:success] = "ログアウトしました"
    end
    redirect_to root_path, status: :see_other
  end
end
