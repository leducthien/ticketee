require 'spec_helper'

feature 'Editing tickets' do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) { FactoryGirl.create(:ticket, project: project) }

  before do
    visit '/'
    click_link project.name
    click_link ticket.title
    click_link 'Edit Ticket'
  end

  scenario 'Can edit a ticket' do
    fill_in 'Title', with: 'a ticket'
    fill_in 'Description', with: 'another description'
    click_button 'Update Ticket'
    expect(page).to have_content 'Ticket updated'
    expect(page).to have_content 'a ticket'
  end

  scenario 'Giving empty title when editing a ticket should raise error' do
    fill_in 'Title', with: ''
    click_button 'Update Ticket'
    expect(page).to have_content 'Updating ticket failed'
    expect(page).to have_content "Title can't be blank"
  end
end
