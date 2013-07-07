class StaticPagesController < ApplicationController

  def send_token
    @email = params[:email]
  end



end