class UsersController < ApplicationController
  before_filter :require_user, only: [:show]

  def new
    @user = User.new
  end

  def new_with_invitation_token
    invitation = Invitation.where(token: params[:token]).first
    if invitation
      @user = User.new(email: invitation.recipient_email)
      @invitation_token = invitation.token
      render :new
    else
      redirect_to expired_token_path
    end
  end

  def create
    @user = User.new(params[:user])
    handle_invitation
    charge = StripeWrapper::Charge.new(
      :amount => 999,
      :card => params[:stripeToken],
      :description => "Sign-up charge for #{@user.email}")
    if charge.successful? && @user.save?
      flash[:success] = "Thanks for signing up!"
      session[:user_id] = @user.id
      MyflixMailer.notify_on_registration(@user).deliver
      redirect_to home_path
    else
      flash[:error] = charge.error_message
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  private

  def handle_invitation
    if params[:invitation_token].present?
      invitation = Invitation.where(token: params[:invitation_token]).first
      @user.follow(invitation.inviter)
      invitation.inviter.follow(@user)
      invitation.update_column(:token, nil)
    end
  end

end