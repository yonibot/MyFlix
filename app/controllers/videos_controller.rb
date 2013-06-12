class VideosController < ApplicationController

  def index
    @videos = Video.all
    @categories = Category.all

    @results = Video.search_by_title(params[:search])


  end

  def show
    @video = Video.find(params[:id])
  end


end
