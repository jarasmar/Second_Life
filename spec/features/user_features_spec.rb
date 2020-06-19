require 'rails_helper'
require 'sign_up_helper'

RSpec.feature "User features", type: :feature do
  scenario "user can sign up" do
    visit '/welcome'
    click_button 'Sign Up'
    fill_in("Username", with: "User1")
    fill_in("Email", with: "user1@user.com")
    fill_in("Password", with: "password")
    find('#user_profile_image').click
    attach_file('test_photos/Test.jpg')
    click_button "Create User"
  end
end
