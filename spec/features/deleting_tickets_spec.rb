require 'spec_helper'

feature 'Deleting tickets' do
  scenario 'Can delete a ticket' do
    project = FactoryGirl.create(:project)
    user = FactoryGirl.create(:user)
    ticket = FactoryGirl.create(:ticket, project: project, user: user)
    define_permission!(user, :view, project)
    define_permission!(user, 'delete tickets', project)
    log_in_as user
    visit '/'
    click_link project.name
    click_link ticket.title
    click_link 'Delete Ticket'
    expect(page).to have_content 'Ticket Deleted'
    expect(page).to_not have_content ticket.title
    expect(page.current_url).to eq project_url(project)
  end
end
