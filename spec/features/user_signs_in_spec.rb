require 'spec_helper'

feature "User signs in" do

  scenario "with valid email and password" do
    yoni = Fabricate(:user)
    login(yoni)
    page.should have_content("You are signed in, enjoy!")
    page.should have_content(yoni.full_name)
  end

  scenario "with deactivated user" do
    yoni = Fabricate(:user, active: false)
    login(yoni)
    page.should have_content("Your account has been suspended. Please contact customer service.")
    expect(page).not_to have_content(yoni.full_name)
  end

end

