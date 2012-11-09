class TraitsController < ApplicationController
  before_filter :admin_user

  def new
    @trait = Trait.new
    6.times { @trait.options.build }
    render :edit
  end

  def edit
    @trait = Trait.find params[:id]
    6.times { @trait.options.build }
  end

  def create
    @trait = Trait.new(params[:trait])
    if @trait.save
      flash[:success] = "Trait created successfully"
      redirect_to admin_path
    else
      render :edit
    end
  end


  def update
    @trait = Trait.find params[:id]
    if @trait.update_attributes(params[:trait])
      flash[:success] = "Trait updated successfully"
      redirect_to admin_path
    else
      render :edit
    end
  end

  def destroy
    Trait.find(params[:id]).destroy
    flash[:success] = "Trait destroyed."
    redirect_to admin_path
  end


end
