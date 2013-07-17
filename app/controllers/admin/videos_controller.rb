class Admin::VideosController < AdminsController

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(params[:video])
    if @video.save
      uploader = LargeCoverUploader.new
      uploader.store!(params[:video][:large_cover_url])
      redirect_to home_path
    else
      flash[:error] = "New video upload has failed."
      render :new
    end
  end

end