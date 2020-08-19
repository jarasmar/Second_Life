require 'rails_helper'
require 'sign_up_helper'

RSpec.feature "User features", type: :feature do
  scenario "user can sign up" do
    visit '/welcome'
    click_link 'Sign Up'
    fill_in("Username", with: "User1")
    fill_in("Email", with: "user1@user.com")
    fill_in("Password", with: "password")
    find('#user_profile_image').click
    attach_file('test_photos/Test.jpg')
    click_button "Create User"
    expect(page).to have_content 'User1'
  end

  scenario "user gets default profile image if nothing is uploaded" do
    create_user_and_sign_up_no_photo
    click_link "User1"
    click_link "View Profile"
    expect(page).to have_css("img[src*='default_profile.png']")
  end

  scenario "user can't sign up if username/email is taken" do
    create_user_and_sign_up_1
    click_link "Sign Out"
    create_user_and_sign_up_1
    expect(page).to have_content "Username User1 has already been taken"
    expect(page).to have_content "Email user1@user.com has already been taken"
  end

  scenario "user can't sign in without valid username, email and password" do
    visit '/welcome'
    click_link 'Sign Up'
    click_button "Create User"
    expect(page).to have_content "Password can't be blank"
    expect(page).to have_content "Password is too short (minimum is 5 characters)"
    expect(page).to have_content "Username can't be blank"
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Email is invalid"
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

  scenario "user can't log in if they haven't signed up" do
    visit '/welcome'
    click_link 'Login'
    fill_in :placeholder => 'Username', :with => 'User1'
    fill_in("Password", with: "password")
    expect(page).to have_content "Log In"
  end

  scenario "user can't log in if invalid username/password combination" do
    create_user_and_sign_up_1
    click_link "Sign Out"
    fill_in("Username", with: "User1")
    fill_in("Password", with: "wrongpassword")
    click_button "Login"
    expect(page).to have_content 'Invalid username/password combination'
  end

  scenario "user can see their profile page and profile picture" do
    create_user_and_sign_up_1
    click_link "View Profile"
    expect(page).to have_content "User1"
    expect(page).to have_css("img[src$='Test.jpg']")
  end

  scenario "user can't access home page unless signed in" do
    visit "/"
    expect(page).to have_content "Welcome to Second Life"
  end
end
