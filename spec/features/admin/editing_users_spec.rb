require 'spec_helper'

feature 'Editing users' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:admin_user) { FactoryGirl.create(:admin_user, name: 'Admin', email: 'admin@example.com') }

  before do
    log_in_as admin_user
    visit '/'
    click_link 'Admin'
    click_link 'Users'
    click_link user.email
    click_link 'Edit'
  end

  scenario 'Change user email' do
    fill_in 'Email', with: 'newguy@example.com'
    click_button 'Update User'
    expect(page).to have_content 'User updated'
    expect(page).to have_content 'newguy@example.com'
  end


end
