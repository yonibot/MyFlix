class Admin::VideosController < AdminsController

  include ActionView::Helpers::TextHelper

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(params[:video])
    if @video.save
      flash[:success] = "You have successfully added the video #{@video.title}."
      redirect_to new_admin_video_path
    else
      flash[:error] = "#{pluralize(@video.errors.count, "error")} occured in uploading this video."
      render :new
    end
  end
end