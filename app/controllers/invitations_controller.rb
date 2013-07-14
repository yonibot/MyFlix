class InvitationsController < ApplicationController

  before_filter :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation].merge!(inviter_id: current_user.id))
    if @invitation.save
      MyflixMailer.send_invitation_email(@invitation).deliver
      flash[:success] = "An invitation has been sent to #{@invitation.recipient_email}."
      redirect_to new_invitation_path
    else
      flash[:error] = "Please fill in all fields to send an invitation."
      render :new
    end
  end


end