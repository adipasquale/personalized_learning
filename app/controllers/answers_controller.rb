class AnswersController < ApplicationController

  before_filter :admin_user

  def for_tasks
    # only answers for tasks questions
    @answers = Answer.joins(:question).where("questions.task_id IS NOT NULL")
    respond_to do |format|
      format.csv { render text: @answers.to_csv }
    end
  end

end
