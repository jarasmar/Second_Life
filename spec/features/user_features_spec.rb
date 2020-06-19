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
    expect(page).to have_content 'User1'
  end

  scenario "user can sign out" do
    create_user_and_sign_up_1
    click_link "Sign Out"
    expect(page).to have_content 'Log In'
  end

  scenario "user can log in" do
    create_user_and_sign_up_1
    click_link "Sign Out"
    fill_in("Username", with: "User1")
    fill_in("Password", with: "password")
    click_button "Login"
    expect(page).to have_content 'User1'
  end

  scenario "a user can't log in if they haven't signed up" do
    visit '/welcome'
    click_button 'login'
    fill_in("Username", with: "User1")
    fill_in("Password", with: "password")
    expect(page).to have_content "Log In"
  end

  scenario "A user can see their profile page and profile picture" do
    create_user_and_sign_up_1
    click_link "View Profile"
    expect(page).to have_content "User1's posts"
    expect(page).to have_css("img[src$='Test.jpg']")
  end
end
