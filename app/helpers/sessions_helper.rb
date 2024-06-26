module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticate?(:remember, cookies[:remember_token])
        reset_session
        log_in user
        @current_user ||= user
      end
    end
  end

  def logged_in?
    !session[:user_id].nil?
    # -> !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    reset_session
    # session.delete(:user_id)
    @current_user = nil # 安全のため
  end

  def remember(user)
    user.remember
    cookies.permanent[:remember_token] = user.remember_token
    cookies.permanent.encrypted[:user_id] = user.id
  end
end
