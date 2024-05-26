class SessionsController < ApplicationController
  skip_before_action :require_login
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      reset_session # <- 攻撃者のセッションを共有させるセッション固定攻撃対策
      log_in(@user)
      flash[:success] = "ログインしました"
      redirect_to root_url
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが正しくありません"
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    if current_user
      reset_session
      # session.delete(:user_id)
      @current_user = nil # 安全のため
      flash[:success] = "ログアウトしました"
    end
    redirect_to root_path, status: :see_other
    # 303 See Otherステータスを指定することで、DELETEリクエスト後のリダイレクトが正しく振る舞うようにする必要があります
  end
end
