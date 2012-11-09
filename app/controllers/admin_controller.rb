class AdminController < ApplicationController

  def index
    @tasks = Task.all
    @users = User.all
    @traits = Trait.all
  end

end
