# == Schema Information
#
# Table name: queue_items
#
#  id         :integer          not null, primary key
#  video_id   :integer
#  user_id    :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }  
  it { should validate_numericality_of(:position) }

# Convention for describing class methods (#method_name)
  describe "#video_title" do
    it "returns the title of the associated video" do
      video = Fabricate(:video, title: 'Monk')
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq('Monk')
    end
  end

  describe "#rating" do
    # we need to look at the user of the review of the queue item
    # if review is there, we pull the rating. If not, we return nil
    it "returns the rating from the review when the review is present" do
      video = Fabricate(:video)
      alice = Fabricate(:user)
      review = Fabricate(:review, user: alice, video: video, rating: 4)
      queue_item = Fabricate(:queue_item, user: alice, video: video)
      expect(queue_item.rating).to eq(4)
    end

    it "returns nil when the user's review is not present" do
      video = Fabricate(:video)
      alice = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: alice, video: video)
      expect(queue_item.rating).to eq(nil)
    end
  end

  describe "#category_name" do
    # all videos have categories, so we don't need to test for no category
    it "returns the category's name of the video" do
      category = Fabricate(:category, name: "comedies")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq("comedies")
    end
  end

  describe "#category" do
    it "returns the category of the video" do
      category = Fabricate(:category, name: "comedies")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq(category)      
    end
  end

  describe "#rating=" do
    it "changes the rating of the review if the review is present" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, user: user, video: video, rating: 2)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      queue_item.rating = 4
      # expect (review.reload.rating).to eq(4)
      expect(Review.first.rating).to eq(4)
    end
    
    it "clears the rating of the review if review is present" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, user: user, video: video, rating: 2)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      queue_item.rating = nil
      expect(Review.first.rating).to be_nil
    end

    it "creates a review with the rating if the review is not present" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      queue_item.rating = 4
      expect(Review.first.rating).to eq(4)
    end
  end
end
















