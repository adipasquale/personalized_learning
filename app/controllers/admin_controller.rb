class AdminController < ApplicationController

  def index
    @tasks = Task.all
    @users = User.students.all
    @traits = Trait.all
  end

end
