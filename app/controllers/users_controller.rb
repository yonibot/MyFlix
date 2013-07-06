class UsersController < ApplicationController
  before_filter :require_user

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

end