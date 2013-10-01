require 'spec_helper.rb'

feature 'User registers', js: true, vcr: true do
  scenario 'with valid user info and valid card' do
    visit register_path
    fill_in "Email address", with: "john@example.com"
    fill_in "Password", with: "foobarbaz"
    fill_in "Full Name", with: "John Stewart"
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "2014", from: "date_year"

    click_button "Sign Up"
    sleep 5

    expect(page).to have_content("Thank you")

  end
  scenario 'with valid user info and invalid card'
  scenario 'with valid user info and declined card'
  scenario 'with invalid user info and valid card'
  scenario 'with invalid user info and invalid card'
  scenario 'with invalid user info and declined card'
  
end