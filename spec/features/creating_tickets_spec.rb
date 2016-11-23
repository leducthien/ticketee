require 'spec_helper'

feature 'Create tickets' do
  before do
    # log_in_as FactoryGirl.create(:admin_user)
    project = FactoryGirl.create(:project, name: "Atom")
    @user = FactoryGirl.create(:user)
    define_permission!(@user, :view, project)
    define_permission!(@user, 'create tickets'.to_sym, project)
    log_in_as @user
    visit '/'
    click_link project.name
    click_link 'New ticket'
  end

  scenario 'Can create a new ticket' do
    # byebug
    fill_in 'Title', with: 'ticket 1'
    fill_in 'Description', with: 'a sample description'
    click_button 'Create Ticket'
    expect(page).to have_content 'Ticket created'
    expect(page).to have_content "Created by #{@user.email}"
  end

  scenario 'Cannot create a new ticket with empty title' do

    click_button 'Create Ticket'
    expect(page).to have_content 'Create ticket failed'
  end

  scenario 'Description must be more than 10 characters' do
    fill_in "Title", with: 'Ticket 2'
    fill_in 'Description', with: 'short'
    click_button 'Create Ticket'
    expect(page).to have_content 'Description is too short'
  end

  scenario 'Create a new ticket with an attachment' do
    fill_in "Title", with: 'Add documentation for blink tag'
    fill_in 'Description', with: 'The blink tag has a speed attribute'
    attach_file "File #1", Rails.root.join("spec/fixtures/speed.txt")
    attach_file "File #2", Rails.root.join("spec/fixtures/spin.txt")
    attach_file "File #3", Rails.root.join("spec/fixtures/gradient.txt")
    click_button 'Create Ticket'
    expect(page).to have_content 'Ticket created'
    # within("#ticket .asset") do
      expect(page).to have_content("speed.txt")
      expect(page).to have_content("spin.txt")
      expect(page).to have_content("gradient.txt")
    # end
  end
end
