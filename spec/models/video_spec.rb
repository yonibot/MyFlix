require 'spec_helper'

describe Video do

  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe 'Search feature' do
    it "returns a blank array if there is no match" do
      Video.create(title: "Curb your enthusiasm", description: "Hilarious show")
      expect(Video.search_by_title("Futurama")).to eq([])
    end

    it "returns an array with a single video for one exact match" do
      curb = Video.create(title: "Curb your enthusiasm", description: "Hilarious show")
      southpark = Video.create(title: "South park", description: "animated comedy")
      expect(Video.search_by_title("South park")).to eq([southpark])
    end

    it "returns an array with a single video for one partial match" do
      curb = Video.create(title: "Curb your enthusiasm", description: "Hilarious show")
      southpark = Video.create(title: "South park", description: "animated comedy")
      expect(Video.search_by_title("enthus")).to eq([curb])
    end


    it "returns an array with multiple videos ordered by created_at" do
      southcentral = Video.create(title: "South central", description: "Hilarious show", created_at: 1.day.ago)
      southpark = Video.create(title: "South park", description: "animated comedy")
      expect(Video.search_by_title("South")).to eq([southpark, southcentral])
    end

    it "returns a blank array if search string is empty" do
      southcentral = Video.create(title: "South central", description: "Hilarious show")
      southpark = Video.create(title: "South park", description: "animated comedy")
      expect(Video.search_by_title("")).to eq([])
    end



  end


  #   it "fails to find any videos" do
  #     Video.create(title: "Curb your enthusiasm", description: "a funny show!")
  #     searchQuery = Video.search_by_title("family")
  #     expect(searchQuery.blank?).to be_true
  #   end

  #   it "finds a single video" do
  #     Video.create(title: "Curb your enthusiasm", description: "great show!")
  #     Video.create(title: "south Park", description: "animated comedy")
  #     searchQuery = Video.search_by_title("curb")
  #     expect(searchQuery).to eq(["Curb your enthusiasm"])
  #   end

  #   it "finds multiple videos" do
  #     Video.create(title: "Curb your enthusiasm", description: "great show!")
  #     Video.create(title: "south Park", description: "animated comedy")
  #     Video.create(title: "simpsons", description: "another animated!")
  #     Video.create(title: "southern walls", description: "made-up show")
  #     searchQuery = Video.search_by_title("south")
  #     expect(searchQuery).to eq(["south Park", "southern walls"])
  #   end
  # end



  # it "saves itself" do
  #   video = Video.new(
  #     title: 'The Fun Show',
  #     description: 'A really fun show about great stuff!',
  #     small_cover_url: 'funshow_small.jpg',
  #     large_cover_url: 'funshow_large.jpg')
  #   video.save
  #   expect(Video.first).to eq(video)
  # end

  # it "belongs to a category" do
  #   comedy = Category.create(name: "Comedy")
  #   curb = Video.create(title: "Curb Your Enthusiasm", category: comedy)
  #   expect(curb.category).to eq(comedy)
  # end

  # test validations

  # it "does not save a video without a title" do
  #   video = Video.create(description: "a great video!")
  #   # video should not be saved
  #   expect(Video.count).to eq(0)
  # end

  # it "does not save a video without a description" do
  #   video = Video.create(title: "monk")
  #   expect(Video.count).to eq(0)
  # end





end
