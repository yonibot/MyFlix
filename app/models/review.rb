# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  video_id   :integer
#  rating     :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Review < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  validates_presence_of :content, :rating
  



end
