# == Schema Information
#
# Table name: videos
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  description     :string(255)
#  large_cover_url :string(255)
#  small_cover_url :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_id     :integer
#  user_id         :integer
#

class Video < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :reviews
#  validates :title, presence: true
#  validates :description, presence: true

  validates_presence_of :title, :description


  # Todo: handle case matching

  def self.search_by_title(search_term)
    return [] if search_term.blank?
   where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end
end