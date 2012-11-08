module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user == @user
  end

  def signed_in?
    !current_user.nil?
  end

  def user_signed_in
    redirect_to signin_url, notice: "Please sign in to access this page." unless signed_in?
  end

  def admin_user
    redirect_to signin_url, notice: "Please sign in as an admin to access this page." unless signed_in? and current_user.is_admin?
  end
end
