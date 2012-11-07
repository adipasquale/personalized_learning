class SessionsController < ApplicationController

  def new
    redirect_to tasks_path if signed_in?
  end

  def create
    user = User.find_by_login(params[:session][:login])
    if user
      sign_in user
      redirect_to (user.is_admin? ? admin_path : tasks_path)
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
