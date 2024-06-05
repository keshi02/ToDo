class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "パスワードリセットメールを送信しました"
      redirect_to root_path
    else
      flash.now[:danger] = "メールアドレスが見つかりません"
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      @user.forget
      reset_session
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "ログインしました🚪"
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "パスワードリセットの有効期限が切れています"
      redirect_to new_password_reset_url
    end
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end


  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless (@user && @user.authenticate?(:reset, params[:id]))
      redirect_to root_url
    end
  end
end
