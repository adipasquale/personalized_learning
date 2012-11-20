include UserTraitsHelper

class UsersController < ApplicationController
  before_filter :admin_user, only: [:new, :edit, :update, :create, :show, :destroy]
  before_filter :user_signed_in, only: [:edit_traits, :update_traits, :answer_task, :home]
  before_filter :correct_user, only: [:edit_traits, :update_traits, :answer_task, :answer_questionnaire]

  def new
    @user = User.new
    render :edit
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

  def edit_traits
    fill_user_traits @user
  end

  def update_traits
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to home_path
    else
      render :edit_traits
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes(params[:user])
      flash[:success] = "User updated"
      redirect_to admin_path
    else
      render :edit
    end
  end

  def home
    @tasks = current_user.current_tasks if current_user.step.name == "practice"
    @task = current_user.current_tasks.first if ["pre-test", "post-test"].include? current_user.step.name
    @questionnaire = current_user.current_questionnaires.first if current_user.step.name == "questionnaire"
  end

  def answer_task
    @task = Task.find(params[:task][:id])
    answer @task, "tasks/show"
  end

  def answer_questionnaire
    @questionnaire = Questionnaire.find(params[:questionnaire][:id])
    answer @questionnaire, "questionnaires/show"
  end

  private

    def answer object, template
      if object.nil? or params[:user][:answers_attributes].nil?
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
          render template
        end
      end
    end
end
