class TasksController < ApplicationController
  before_filter :admin_user, only: [:new, :create, :destroy]
  before_filter :user_signed_in, only: [:show]
  before_filter :build_preview_traits, only: [:new, :edit, :update]

  def show
    # fill_user_traits current_user
    @task = Task.find params[:id]
    @task.personalize_content_for_user current_user
    build_answers @task, current_user
  end

  def new
    @task = Task.new
    build_questions @task, 6, 6
    render :edit
  end

  def edit
    @task = Task.find params[:id]
    build_questions @task, 6, 6
  end

  def update
    @task = Task.find params[:id]
    if @task.update_attributes params[:task]
      flash[:success] = "Task #{@task.name} updated successfully"
    end
    render :edit
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      flash[:success] = "Task #{@task.name} created successfully"
      redirect_to admin_path
    else
      render :edit
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    flash[:success] = "Task destroyed."
    redirect_to admin_path
  end

  def build_preview_traits
    user= User.find_by_login("testuser")
    @preview_traits = {}
    Trait.no_options.each do |trait|
      user_trait = user.user_traits.where(trait_id: trait.id).first
      @preview_traits[trait.id] = user_trait.value
    end
    logger.debug @preview_traits
  end

end
