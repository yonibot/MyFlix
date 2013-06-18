class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
      if @user.save
      redirect_to home_path
    else
      render :new
    end
  end

  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
  end

end