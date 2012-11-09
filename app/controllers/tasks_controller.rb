class TasksController < ApplicationController
  before_filter :admin_user, only: [:new, :create, :show, :destroy]
  before_filter :user_signed_in, only: [:index, :show]

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find params[:id]
  end

  def new
    @task = Task.new
    render :edit
  end

  def edit
    @task = Task.find params[:id]
  end

  def update
    @task = Task.find params[:id]
    if @task.update_attributes params[:task]
      flash[:success] = "Task #{@task.name} updated successfully"
      redirect_to admin_path
    else
      render :edit
    end
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

end
