require 'rails_helper'
require 'sign_up_helper'
require 'make_post_helper'

RSpec.feature "post features", type: :feature do
  scenario "A user can make a post" do
    create_user_and_sign_up_1
    click_link "New Post"
    fill_in("Title", with: "A Picture of my Nan")
    fill_in("Description", with: "She has been left on the sidewalk to be picked up for free, ASAP")
    find('#post_main_image').click
    attach_file('test_photos/Test.jpg')
    click_button "Create Post"
    expect(page).to have_content "Post created by: User1"
    expect(page).to have_content "A picture of my nan"
  end

  scenario "A user can view their post" do
    create_user_and_sign_up_1
    make_a_post
    click_link "A picture of my nan"
    expect(page).to have_content "A picture of my nan"
  end

  scenario "A user can edit their post" do
    create_user_and_sign_up_1
    make_a_post
    page.find(:css, "#EditBtn").click
    fill_in 'post_title', with: 'Wait a minute...'
    click_button "Update Post"
    expect(page).to have_content "Wait a minute..."
  end

  scenario "A user is redirected to edit if edit post is incorrect" do
    create_user_and_sign_up_1
    make_a_post
    page.find(:css, "#EditBtn").click
    fill_in 'post_title', with: 'abc'
    click_button "Update Post"
    expect(page).to have_content "Title has to be more than 5 characters"
  end

  scenario "A user can delete their post" do
    create_user_and_sign_up_1
    make_a_post
    page.find(:css, "#DeleteBtn").click
    expect(page).not_to have_content "A picture of my nan"
  end

  scenario "A user cannot delete/edit another users post" do
    create_user_and_sign_up_1
    make_a_post
    click_link "Sign Out"
    create_user_and_sign_up_2
    expect(page).to have_content "A picture of my nan"
    expect(page).to have_no_css("#DeleteBtn")
    expect(page).to have_no_css("#EditBtn")
  end

  scenario "can't upload a post with a description of less than 25 characters" do
    create_user_and_sign_up_1
    click_link "New Post"
    fill_in("Title", with: "A Picture of my Nan")
    fill_in("Description", with: "Hello")
    find('#post_main_image').click
    attach_file('test_photos/Test.jpg')
    click_button "Create Post"
    expect(page).to have_content "Description has to be more than 25 characters"
  end

  scenario "can't upload a post with a title with less than 5 characters" do
    create_user_and_sign_up_1
    click_link "New Post"
    fill_in("Title", with: "Nan")
    fill_in("Description", with: "She has been left on the sidewalk to be picked up for free, ASAP")
    find('#post_main_image').click
    attach_file('test_photos/Test.jpg')
    click_button "Create Post"
    expect(page).to have_content "Title has to be more than 5 characters"
  end

  scenario "A post can't be bigger than 4mb and has to be JPEG or PNG" do
    create_user_and_sign_up_1
    click_link "New Post"
    fill_in("Title", with: "A Picture of my Nan")
    fill_in("Description", with: "She has been left on the sidewalk to be picked up for free, ASAP")
    find('#post_main_image').click
    attach_file('test_photos/Pizza.gif')
    click_button "Create Post"
    expect(page).to have_content "Main image has to be less than 4MB"
    expect(page).to have_content "Main image must be a JPEG or PNG"
  end

  scenario "A post is given a default image when no image is uploaded" do
    create_user_and_sign_up_1
    make_a_post_no_photo
    expect(page).to have_css("img[src*='default_main_image.png']")
  end
end
