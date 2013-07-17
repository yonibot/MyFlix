class AdminsController < ApplicationController

  before_filter :ensure_admin

end