require 'spec_helper'

feature 'Create tickets' do
  before do
    FactoryGirl.create(:project, name: "Atom")
    visit '/'
    click_link 'Atom'
    click_link 'New ticket'
  end

  scenario 'Can create a new ticket' do
    fill_in 'Title', with: 'ticket 1'
    fill_in 'Description', with: 'a sample description'
    click_button 'Create Ticket'
    expect(page).to have_content 'Ticket created'
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
end
