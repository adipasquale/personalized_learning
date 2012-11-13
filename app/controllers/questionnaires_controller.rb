class QuestionnairesController < ApplicationController
  before_filter :admin_user, only: [:new, :create, :update, :destroy]
  before_filter :user_signed_in, only: [:show]

  def show
    @questionnaire = Questionnaire.find params[:id]
    build_answers @questionnaire, current_user
  end

  def new
    @questionnaire = Questionnaire.new
    build_questions @questionnaire, 10, 5
    render :edit
  end

  def edit
    @questionnaire = Questionnaire.find params[:id]
    build_questions @questionnaire, 10, 5
  end

  def create
    @questionnaire = Questionnaire.new(params[:questionnaire])
    if @questionnaire.save
      flash[:success] = "Questionnaire #{@questionnaire.name} created successfully"
      redirect_to admin_path
    else
      render :edit
    end
  end

  def update
    @questionnaire = Questionnaire.find params[:id]
    if @questionnaire.update_attributes(params[:questionnaire])
      flash[:success] = "Questionnaire #{@questionnaire.name} updated successfully"
      redirect_to admin_path
    else
      render :edit
    end
  end

  def destroy
    Questionnaire.find(params[:id]).destroy
    flash[:success] = "Questionnaire destroyed."
    redirect_to admin_path
  end

end
