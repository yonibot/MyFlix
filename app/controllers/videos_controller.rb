class VideosController < ApplicationController

  before_filter :require_user


  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
    @reviews = @video.reviews
    @average_rating = find_rating_average(@video.reviews.map(&:rating))
  end

  def search
    @results = Video.search_by_title(params[:search_term])
  end


private

def find_rating_average(ratings)
  if ratings == []
    return 0
  else
    result = 0
    ratings.each do |rating|
      result += rating
    end
  avg = result / ratings.size
  end
end



end
