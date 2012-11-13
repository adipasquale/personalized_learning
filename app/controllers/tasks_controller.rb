class TasksController < ApplicationController
  before_filter :admin_user, only: [:new, :create, :destroy]
  before_filter :user_signed_in, only: [:show]
  before_filter :build_preview_traits, only: [:new, :edit, :update]

  def show
    @task = Task.find params[:id]
    @task.personalize_material_for_user current_user
    @task.questions.each do |question|
      question.choices.each do |choice|
        if current_user.answers.select{ |a| a.choice_id == choice.id}.empty?
          current_user.answers.build choice_id: choice.id
        end
      end
    end
  end

  def new
    @task = Task.new
    6.times do
      question = @task.questions.build
      6.times { question.choices.build }
    end
    render :edit
  end

  def edit
    @task = Task.find params[:id]
    @task.questions.each do |question|
      (6 - question.choices.count).times { question.choices.build }
    end
    (6 - @task.questions.count).times do
      question = @task.questions.build
      6.times { question.choices.build }
    end
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
