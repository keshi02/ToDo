class SessionsController < ApplicationController
  skip_before_action :require_login
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      reset_session # <- 攻撃者のセッションを共有させるセッション固定攻撃対策
      params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
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
      log_out if logged_in?
      flash[:success] = "ログアウトしました"
    end
    redirect_to root_path, status: :see_other
    # 303 See Otherステータスを指定することで、DELETEリクエスト後のリダイレクトが正しく振る舞うようにする必要があります
  end
end
