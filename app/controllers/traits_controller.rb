class TraitsController < ApplicationController
  before_filter :admin_user

  def index
    @traits = Trait.all
  end

  def new
    @trait = Trait.new
    6.times { @trait.options.build }
  end

  def create
    @trait = Trait.new(params[:trait])
    if @trait.save
      flash[:success] = "Trait created successfully"
      redirect_to traits_path
    else
      render 'new'
    end
  end

  def destroy
    Trait.find(params[:id]).destroy
    flash[:success] = "Trait destroyed."
    redirect_to traits_url
  end


end
