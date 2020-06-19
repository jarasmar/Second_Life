def create_user_and_sign_up_1
  visit '/welcome'
  click_button 'Sign Up'
  fill_in("Username", with: "User1")
  fill_in("Email", with: "user1@user.com")
  fill_in("Password", with: "password")
  find('#user_profile_image').click
  attach_file('test_photos/Test.jpg')
  click_button "Create User"
end

def create_user_and_sign_up_2
  visit '/welcome'
  click_button 'Sign Up'
  fill_in("Username", with: "User2")
  fill_in("Email", with: "user2@user.com")
  fill_in("Password", with: "password")
  find('#user_profile_image').click
  attach_file('test_photos/Test.jpg')
  click_button "Create User"
end