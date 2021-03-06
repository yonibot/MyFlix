# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  has_many :videos, order: "created_at DESC"
  validates_presence_of :name

  def recent_videos
    videos.first(6)
  end


end
