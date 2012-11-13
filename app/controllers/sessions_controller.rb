class SessionsController < ApplicationController

  def new
    if signed_in?
      path = current_user.is_admin? ? admin_path : home_path
      redirect_to path
    end
  end

  def create
    user = User.find_by_login(params[:session][:login])
    if user
      sign_in user
      redirect_to (user.is_admin? ? admin_path : home_path)
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
