# == Schema Information
#
# Table name: queue_items
#
#  id         :integer          not null, primary key
#  video_id   :integer
#  user_id    :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  # allows you to get video.category just by calling #category method
  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  validates_numericality_of :position, {only_integer: true}

  # Replaced by delegate
  # def video_title
  #   video.title    
  # end

  # pulls rating from reviews model
  def rating
    review.rating if review
  end

  # opposite of def rating. 
  # push the value from the queueitem to the review model. Treat the rating
  # as if its an attrib of the review model. 
  # This is called "virtual attributes" for activerecord models.

  def rating=(new_rating)
   if review
      review.update_column(:rating, new_rating)
    else
      review = Review.new(user: user, video: video, rating: new_rating)
      review.save(validate: false)
    end
  end


    # we can get rid of video.category method cause of delegation
    # def category_name
    #   video.category.name
    # end

  def category_name
    category.name
  end

  private

  def review
    @review ||= Review.where(user_id: user.id, video_id: video.id).first
  end





end
