def create_user_and_sign_up_1
  visit '/welcome'
  click_link 'Sign Up'
  expect(page).to have_content "Already part of the community?"
  fill_in :placeholder => 'Username', :with => 'User1'
  fill_in("Email", with: "user1@user.com")
  fill_in("Password", with: "password")
  find("label#ProfileBtn").click
  Capybara.ignore_hidden_elements = false
  find('form input[type="file"]').set('test_photos/Test.jpg')
  click_button "Create User"
end

def create_user_and_sign_up_2
  visit '/welcome'
  click_link 'Sign Up'
  fill_in :placeholder => 'Username', :with => 'User2'
  fill_in("Email", with: "user2@user.com")
  fill_in("Password", with: "password")
  Capybara.ignore_hidden_elements = false
  find('#user_profile_image').click
  attach_file('test_photos/Test.jpg')
  click_button "Create User"
end

def create_user_and_sign_up_no_photo
  visit '/welcome'
  click_link 'Sign Up'
  expect(page).to have_content "Already part of the community?"
  fill_in :placeholder => 'Username', :with => 'User1'
  fill_in("Email", with: "user1@user.com")
  fill_in("Password", with: "password")
  find("label#ProfileBtn").click
  Capybara.ignore_hidden_elements = false
  click_button "Create User"
end
