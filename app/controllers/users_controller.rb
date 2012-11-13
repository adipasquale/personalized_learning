include UserTraitsHelper

class UsersController < ApplicationController
  before_filter :admin_user, only: [:new, :create, :show, :destroy]
  before_filter :user_signed_in, only: [:edit, :update, :answer_task, :home]
  before_filter :correct_user, only: [:edit, :update, :answer_task]

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
    redirect_to admin_path
  end

  def edit
    fill_user_traits @user
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  def home
    @tasks = Task.all
  end

  def answer_task
    @task = Task.find(params[:task][:id])
    if @task.nil? or params[:user][:answers_attributes].nil?
      redirect_to :back
    else
      params[:user][:answers_attributes].each do |id, answer|
        if answer[:keep_or_create] == "0"
          params[:user][:answers_attributes][id][:_destroy] = "1"
        end
        params[:user][:answers_attributes][id].delete :keep_or_create
      end
      if @user.update_attributes(params[:user])
        flash[:success] = "Answer submitted"
        sign_in @user
        redirect_to home_path
      else
        render "tasks/show"
      end
    end
  end

end
