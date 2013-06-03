require 'spec_helper'

describe Video do
  it "is valid with a title, description, small_cover_url and large_cover_url" do
    video = Video.create(
      title: 'The Fun Show',
      description: 'A really fun show about great stuff!',
      small_cover_url: 'funshow_small.jpg',
      large_cover_url: 'funshow_large.jpg')
    expect(video).to be_valid
  end

  it "can belong to a category" do
    category = Category.create(name: "Comedy")
    video = Video.create(title: "Curb Your Enthusiasm")
    category.videos << video
    expect(category.videos.first.category_id).to eq 1
  end

end
