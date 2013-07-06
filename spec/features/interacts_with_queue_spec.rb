require 'spec_helper'

feature 'User interacts with the queue' do
  scenario 'user adds and reorders videos in the queue' do

    comedy = Fabricate(:category, name: "Comedy")
    curb = Fabricate(:video, title: "Curb your Enthusiasm", category: comedy)
    south_park = Fabricate(:video, title: "South Park", category: comedy)
    family_guy = Fabricate(:video, title: "Family Guy", category: comedy)
    login
    
    add_video_to_queue(curb)
    visit video_path(curb)
    expect(page).to_not have_content("+ My Queue")

    add_video_to_queue(south_park)
    visit video_path(south_park)
    expect(page).to_not have_content("+ My Queue")

    visit home_path
    find("a[href='/videos/#{family_guy.id}']").click
    expect(page).to have_content(family_guy.title)

    click_link("+ My Queue")
    expect(page).to have_content(curb.title)
    expect(page).to have_content(south_park.title)
    expect(page).to have_content(family_guy.title)

    visit video_path(family_guy)
    expect(page).to_not have_content("+ My Queue")

    visit my_queue_path
    within(:xpath, "//tr[contains(.,'#{curb.title}')]") do
      fill_in "queue_items[][position]", with: 3
    end

    within(:xpath, "//tr[contains(.,'#{south_park.title}')]") do
      fill_in "queue_items[][position]", with: 2
    end

    within(:xpath, "//tr[contains(.,'#{family_guy.title}')]") do
      fill_in "queue_items[][position]", with: 1
    end

    click_on("Update Instant Queue")

    expect(find(:xpath, "//tr[contains(.,'#{family_guy.title}')]//input[@type='text']").value).to eq("1")
    expect(find(:xpath, "//tr[contains(.,'#{south_park.title}')]//input[@type='text']").value).to eq("2")
    expect(find(:xpath, "//tr[contains(.,'#{curb.title}')]//input[@type='text']").value).to eq("3")


  end

  def add_video_to_queue(video)
    visit home_path
    click_on_video_on_home_page(video)
    click_link("+ My Queue")
  end

end


