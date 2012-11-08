class UsersController < ApplicationController
  before_filter :admin_user

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "User #{@user.login} created successfully"
      redirect_to admin_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find params[:id]
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def index
    @users = User.where("is_admin IS NULL") # todo: very dirty !
  end

end
