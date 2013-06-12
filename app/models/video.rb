class Video < ActiveRecord::Base
  belongs_to :category
#  validates :title, presence: true
#  validates :description, presence: true

  validates_presence_of :title, :description


  # Todo: handle case matching

  def self.search_by_title(search_term)
    # if search
    #   where("title LIKE ?", "%#{search_term}%")
    result = self.where("title LIKE ?", "%")
    name_result = []
    result.each do |record|
      name_result << record.title
    end
    return name_result
  end
end

