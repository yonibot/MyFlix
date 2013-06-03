require 'spec_helper'

describe Category do
  it "can have videos" do
    category = Category.create(name:"Comedy")
    video = Video.create(title: "Curb your enthusiasm")
    category.videos << video
    expect(category.videos.first).to be_valid
  end
end