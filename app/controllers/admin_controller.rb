class AdminController < ApplicationController

  def home
    @tasks = Task.all
    @users = User.students.all
    @traits = Trait.all
    @questionnaires = Questionnaire.all
  end

end
