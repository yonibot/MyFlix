class Admin::VideosController < AdminsController

  include ActionView::Helpers::TextHelper
  
  def new
    @video = Video.new
  end

  def create

    video = Video.create(params[:video])
    binding.pry
    if video.save
      flash[:success] = "You have successfully added the video #{video.title}."
      redirect_to new_admin_video_path
    else
      flash[:error] = "#{pluralize(video.errors.count, "error")} occured in uploading this video."
      render :new
    end

    # @video = Video.new(params[:video])
    # uploader = LargeCoverUrlUploader.new
    # uploader.store!(params[:video][:large_cover_url])
    # if @video.save
    #   redirect_to home_path
    # else
    #   flash[:error] = "New video upload has failed."
    #   render :new
    # end
  end
end