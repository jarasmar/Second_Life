require 'rails_helper'
require 'sign_up_helper'

RSpec.feature "post features", type: :feature do
  scenario "A user can make a post" do
    create_user_and_sign_up_1
    click_link "New Post"
    fill_in("Title", with: "A Picture of my Nan")
    fill_in("Description", with: "She has been left on the sidewalk to be picked up for free, ASAP")
    find('#post_main_image').click
    attach_file('test_photos/Test.jpg')
    click_button "Create Post"
    expect(page).to have_content "A Picture of my Nan"
  end
end