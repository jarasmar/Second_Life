require 'rails_helper'
require 'sign_up_helper'
require 'make_post_helper'

RSpec.feature "home features", type: :feature do
  scenario "A user can see all posts in reverse chronological order" do
    create_user_and_sign_up_1
    make_a_post
    make_a_post_2
    expect(page.text.index("A picture of a monkey")).to be < page.text.index("A picture of my nan")
  end

  scenario "A user can see a map view" do
    create_user_and_sign_up_1
    click_link "Map View"
    expect(page).to have_content "List View"
  end

  scenario "A user can see post markers on map" do
    create_user_and_sign_up_1
    make_a_post
    click_link "Map View"
    expect(page).to have_content "A picture of my nan"
  end
end
