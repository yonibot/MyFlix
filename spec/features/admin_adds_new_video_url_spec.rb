require 'spec_helper'

feature 'Admin adds a new video' do
  scenario 'Admin successfully adds a new video' do

    gareth = Fabricate(:admin, password: "foobarbaz")
    drama = Fabricate(:category, name: "Drama")
    comedy = Fabricate(:category, name: "Comedy")

    login(gareth)

    visit new_admin_video_path
    fill_in "Title", with: "The Shield"
    select "Drama", from: "Category"
    fill_in "Description", with: "A good police show."
    attach_file "Large cover", "spec/support/uploads/theshield_large.jpg"
    attach_file "Small cover", "spec/support/uploads/theshield_small.jpg"
    fill_in "Video URL", with: "http://www.youtube.com/watch?v=vinjVcvUrXo"
    click_button "Submit"

    expect(page).to have_content("You have successfully added")

    logout

    login
    visit video_path(Video.first)
    expect(page).to have_selector("img[src='/uploads/theshield_large.jpg']")
    expect(page).to have_selector("a[href='http://www.youtube.com/watch?v=vinjVcvUrXo']")

  end
end



