class AdminsController < ApplicationController

  before_filter :ensure_admin

  private

  def ensure_admin
    if current_user
      if !current_user.admin?
        flash[:error] = "You are not authorized to do that."
        redirect_to home_path
      end
    end
  end

end