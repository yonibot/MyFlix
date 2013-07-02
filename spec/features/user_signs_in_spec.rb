require 'spec_helper'

feature "User signs in" do

  given(:yoni) { Fabricate(:user) }

  scenario "with valid email and password" do
    visit login_path
    fill_in "Email", with: yoni.email
    fill_in "password", with: yoni.password
    click_button "Sign in"
    page.should have_content("You are signed in, enjoy!")
    page.should have_content(yoni.full_name)
  end
end

