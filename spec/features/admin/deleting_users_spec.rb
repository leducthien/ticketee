require 'spec_helper'

feature 'Deleting users' do
  let!(:admin_user) { FactoryGirl.create(:admin_user) }
  let!(:user) { FactoryGirl.create(:user)}

  before do
    log_in_as admin_user
    visit '/'
    click_link 'Admin'
    click_link 'Users'
  end

  scenario 'Delete a single user' do
    click_link user.email
    click_link 'Delete'
    expect(page).to have_content 'User deleted'
  end

  scenario 'Cannot delete oneself' do
      click_link admin_user.email
      click_link 'Delete'
      expect(page).to have_content 'You cannot delete yourself'
  end
end
