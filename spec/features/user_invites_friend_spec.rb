require 'spec_helper'

feature "User invites friend" do
  scenario "User successfully invites friend and invitation is accepted", { js: true, vcr: true } do

    clear_email

    alice = Fabricate(:user)
    login(alice)
    
    invite_a_friend
    friend_accepts_invitation
    inviter_and_recipient_should_follow_each_other(alice)

  end

  def invite_a_friend
    visit new_invitation_path
    fill_in("Friend's name", with: "Richard Simmons")
    fill_in("Friend's email address", with: "richard@example.com")
    fill_in("Invitation Message", with: "Richard, you got to see this site.")
    click_button "Send Invitation"
    expect(page).to have_content("An invitation has been sent to richard@example.com.")
    logout
  end

  def friend_accepts_invitation
    open_email "richard@example.com"
    current_email.click_link "Accept this invitation"
    expect(find_field("Email address").value).to eq("richard@example.com")
    fill_in "Password", with: "foobarbaz"
    fill_in "Full Name", with: "Richard Simmons"
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "2015", from: "date_year"
    click_on "Sign Up"
  end

  def inviter_and_recipient_should_follow_each_other(alice)
    visit people_path
    find_link(alice.full_name).click
    find_link("People").click
    expect(page).to have_content "Richard Simmons"
  end

end