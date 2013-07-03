require 'spec_helper'

feature "User signs in" do

  scenario "with valid email and password" do
    yoni = Fabricate(:user)
    login(yoni)
    page.should have_content("You are signed in, enjoy!")
    page.should have_content(yoni.full_name)
  end
end

