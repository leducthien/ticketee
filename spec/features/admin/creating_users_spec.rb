require 'spec_helper'

feature 'Creating users by admins' do
  before do
    admin = FactoryGirl.create(:admin_user)
    log_in_as admin
    visit '/'
    click_link 'Admin'
    click_link 'Users'
    click_link 'New user'
  end

  scenario 'Create an user' do
    fill_in 'Email', with: 'user1@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Create User'
    expect(page).to have_content 'User created'
  end

  scenario 'Create an admin user' do
    fill_in 'Email', with: 'user1@example.com'
    fill_in 'Password', with: 'password'
    check 'Is an admin?'
    click_button 'Create User'
    expect(page).to have_content 'User created'
    expect(page).to have_content 'user1@example.com (Admin)'
  end
end
