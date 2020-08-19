require 'sign_up_helper'

def make_a_post
  click_link "New Post"
  fill_in("Title", with: "A Picture of my Nan")
  fill_in("Description", with: "She has been left on the sidewalk to be picked up for free, ASAP")
  find('#post_main_image').click
  attach_file('test_photos/Test.jpg')
  click_button "Create Post"
end

def make_a_post_2
  click_link "New Post"
  fill_in("Title", with: "A picture of a monkey")
  fill_in("Description", with: "Free monkey, may have rabies")
  find('#post_main_image').click
  attach_file('test_photos/Test.jpg')
  click_button "Create Post"
end

def make_a_post_no_photo
  click_link "New Post"
  fill_in("Title", with: "A Picture of my Nan")
  fill_in("Description", with: "She has been left on the sidewalk to be picked up for free, ASAP")
  click_button "Create Post"
end
