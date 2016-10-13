require 'spec_helper'

feature 'Creating users by admins' do
  scenario 'Create an user' do
    admin = FactoryGirl.create(:admin_user)
    log_in_as admin
    visit '/'
    click_link 'Admin'
    click_link 'Users'
    click_link 'New user'
    fill_in 'Email', with: 'user1@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Create User'
    expect(page).to have_content 'User created'
  end
end
