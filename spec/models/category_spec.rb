# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Category do

  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }

  describe "#recent_videos" do
    it "returns the videos in reverse chronological order" do
      comedy = Category.create(name: "comedy")
      south_park = Video.create(title: "South Park", description: "ANimated", category: comedy, created_at: 2.days.ago)
      family_guy = Video.create(title: "Family Guy", description: "funny show", category: comedy, created_at: 1.day.ago)
      simpsons = Video.create(title: "The Simpsons", description: "Great long-standing comedy", category: comedy)
      expect(comedy.recent_videos).to eq([simpsons, family_guy, south_park])
    end

    it "returns all videos if number of videos uploaded is less than 6" do
      comedy = Category.create(name: "comedy")
      south_park = Video.create(title: "South Park", description: "ANimated", category: comedy, created_at: 2.days.ago)
      family_guy = Video.create(title: "Family Guy", description: "funny show", category: comedy, created_at: 1.day.ago)
      expect(comedy.recent_videos.count).to eq(2)
    end

    it "returns 6 videos if number of videos exceeds 6" do
      comedy = Category.create(name: "comedy")
      7.times { south_park = Video.create(title: "South Park", description: "Animated", category: comedy) }
      expect(comedy.recent_videos.count).to eq(6)
    end  

    it "returns the 6 most recent videos" do
      comedy = Category.create(name: "comedy")
      family_guy = Video.create(title: "Family Guy", description: "Animated", category: comedy, created_at: 1.day.ago)
      6.times {7.times { south_park = Video.create(title: "South Park", description: "Animated", category: comedy) }}
      expect(comedy.recent_videos).not_to include(family_guy)
    end

    it "returns an empty array if the category has no videos" do
      comedy = Category.create(name: "comedy")
      expect(comedy.recent_videos).to eq([])
    end

  end

end
