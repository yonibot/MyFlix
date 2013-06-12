require 'spec_helper'

describe Category do

  it "saves itself" do
    category = Category.new(name: "Comedies")
    category.save
    expect(Category.first).to eq(category)
  end

  # it { should have_many(:videos) }

  it "has many videos" do
    comedies = Category.create(name:"Comedy")
    curb = Video.create(title: "Curb your enthusiasm", description: "Such a funny show!", category: comedies)
    futurama = Video.create(title: "Futurama", description: "Space travel.", category: comedies)
    expect(comedies.videos).to include(curb, futurama)
  end


end