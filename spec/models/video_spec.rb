require 'spec_helper'

describe Video do
  it "is valid with a title, description, small_cover_url and large_cover_url" do
    video = Video.new(
      title: 'The Fun Show',
      description: 'A really fun show about great stuff!',
      small_cover_url: 'funshow_small.jpg',
      large_cover_url: 'funshow_large.jpg')
    expect(video).to be_valid
  end


end
