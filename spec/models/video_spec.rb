require 'spec_helper'

describe Video do

  it { should belong_to(:category) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }





  # it "saves itself" do
  #   video = Video.new(
  #     title: 'The Fun Show',
  #     description: 'A really fun show about great stuff!',
  #     small_cover_url: 'funshow_small.jpg',
  #     large_cover_url: 'funshow_large.jpg')
  #   video.save
  #   Video.first.title.should == 'The Fun Show'
  # end


  # it "is valid with a title, description, small_cover_url and large_cover_url" do
  #   video = Video.new(
  #     title: 'The Fun Show',
  #     description: 'A really fun show about great stuff!',
  #     small_cover_url: 'funshow_small.jpg',
  #     large_cover_url: 'funshow_large.jpg')
  #   expect(video).to be_valid
  # end

  # it "can belong to a category" do
  #   category = Category.create(name: "Comedy")
  #   video = Video.create(title: "Curb Your Enthusiasm")
  #   category.videos << video
  #   expect(category.videos.first.category_id).to eq 1
  # end

  # it "is invalid without a title" do
  #   v = Video.new(title: nil)
  #   expect(v).to have(1).errors_on(:title)
  # end

  # it "is invalid without a description" do
  #   v = Video.new(description: nil)
  #   expect(v).to have(1).errors_on(:description)
  # end


end
