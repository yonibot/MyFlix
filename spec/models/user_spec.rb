# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  full_name       :string(255)
#  password        :string(255)
#  password_digest :string(255)
#  email           :string(255)
#  token           :string(255)
#  admin           :boolean
#  customer_token  :string(255)
#

require 'spec_helper'

describe User do
  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:password)}
  it { should validate_presence_of(:full_name)}
  it { should validate_uniqueness_of(:email)}
  it { should have_many(:queue_items).order(:position)}
  it { should have_many(:reviews).order("created_at DESC")}

  it "generates a random token when the user is created" do
    alice = Fabricate(:user)
    expect(alice.token).to be_present
  end

  describe "#queued_video?" do

    it "returns true when the user queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user, video: video)
      expect(user.queued_video?(video)).to be_true
    end

    it "returns false when the user hasn't queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, video: video)
      expect(user.queued_video?(video)).to be_false
    end
  end

  describe "#follows?" do
    it "returns true if the user has a following relationship with another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: bob, follower: alice)
      expect(alice.follows?(bob)).to be_true
    end  

    describe "#follow" do
      it "follows another user" do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        alice.follow(bob)
        expect(alice.follows?(bob)).to be_true
      end
      
      it "does not follow oneself" do
        alice = Fabricate(:user)
        alice.follow(alice)
        expect(alice.follows?(alice)).to be_false
      end
    end

    it "returns false if the user does not have a following relationship with another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: alice, follower: bob)
      expect(alice.follows?(bob)).to be_false
    end
  end  


end
