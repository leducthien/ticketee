require 'spec_helper'

feature 'User Profile' do
  scenario 'View user profile' do
    user = FactoryGirl.create(:user)
    visit user_path user
    expect(page).to have_content user.name
    expect(page).to have_content user.email
  end
end

feature 'Edit User' do
  scenario 'Edit user profile' do
    user = FactoryGirl.create(:user)
    visit user_path user
    click_link 'Edit user'
    fill_in 'Name', with: 'new user'
    fill_in 'Email', with: 'new email'
    click_button 'Update User'
    expect(page).to have_content 'User profile updated'
  end
end
