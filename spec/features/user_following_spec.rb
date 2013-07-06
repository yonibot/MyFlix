require 'spec_helper'

feature 'User following' do

# For selenium:
# self.use_transactional_fixtures = false

  scenario 'User follows and unfollows someone' do

    alice = Fabricate(:user)
    comedy = Fabricate(:category, name: "Comedy")
    curb = Fabricate(:video, title: "Curb Your Enthusiasm", category: comedy)
    review = Fabricate(:review, user: alice, video: curb)

    login
    click_on_video_on_home_page(curb)

    click_link alice.full_name
    click_link "Follow"
    expect(page).to have_content(alice.full_name)

    unfollow(alice)
    expect(page).not_to have_content(alice.full_name)
  end

  def unfollow(user)
    find("a[data-method='delete']").click
  end
end 