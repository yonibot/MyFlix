require 'spec_helper'

feature 'User resets password using a token' do
  scenario 'User submits password in Forgot Email page and resets password' do
    clear_emails

    alice = Fabricate(:user, email: "alice@example.com", password: "foobarbaz")
    visit login_path
    click_link "Forgot password?"

    fill_in "email", with: "alice@example.com"
    click_button "Send Email"

    open_email(alice.email)
    current_email.click_link "Reset my password"
    fill_in "password", with: "fishsoup"
    click_on "Reset Password"
    expect(page).to have_content("has been changed")

    # Sign in user with new password
    
    fill_in "Email Address", with: alice.email
    fill_in "Password", with: "fishsoup"
    click_on "Sign in"
    expect(page).to have_content("You are signed in, enjoy!")

  end
end