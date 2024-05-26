class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :require_login
  add_flash_types :success, :info, :warning, :danger

  def require_login
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to login_path
    end
  end
end
