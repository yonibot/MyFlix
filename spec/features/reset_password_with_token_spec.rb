require 'spec_helper'

feature 'User resets password using a token' do
  scenario 'User submits password in Forgot Email page and resets password' do

    alice = Fabricate(:user, email: "alice@example.com", password: "foobarbaz")
    visit login_path
    click_link "Forgot password?"
    fill_in "email", with: "alice@example.com"
    click_button "Send Email"
    open_email('alice@example.com')
    expect(current_email).to have_content('Someone at this')

  end
end