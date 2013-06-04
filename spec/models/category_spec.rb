require 'spec_helper'

describe Category do

  it { should have_many(:videos) }
  




  # it "can have videos" do
  #   category = Category.new(name:"Comedy")
  #   category.save
  #   video = Video.new(title: "Curb your enthusiasm", description: "Such a funny show!")
  #   video.save
  #   category.videos << video
  #   expect(category.videos.first).to be_valid
  # end


end