require 'spec_helper'

feature 'Assigning permissions' do
  let!(:admin) { FactoryGirl.create(:admin_user, name: 'admin') }
  let!(:user) { FactoryGirl.create(:user, name: 'user')}
  let!(:project) {FactoryGirl.create(:project)}
  let!(:ticket) {FactoryGirl.create(:ticket, project: project, user: user)}

  before do
    log_in_as admin
    visit '/'
    click_link 'Admin'
    click_link 'Users'
    click_link user.email
    click_link 'Permissions'
  end

  scenario 'can view project' do
    check_permission_box 'view', project
    click_button 'Update'
    click_link 'Log out'
    log_in_as user
    expect(page).to have_content project.name
  end

  scenario 'create tickets for a project' do
    check_permission_box 'view', project
    check_permission_box 'create tickets', project
    click_button 'Update'
    click_link 'Log out'
    log_in_as user
    click_link project.name
    click_link 'New ticket'
    fill_in 'Title', with: 'ticket 1'
    fill_in 'Description', with: 'a sample description'
    click_button 'Create Ticket'
    expect(page).to have_content 'Ticket created'
    expect(page).to have_content "Created by #{user.email}"
  end

  scenario 'update a ticket for a project' do
    check_permission_box 'view', project
    check_permission_box 'edit tickets', project
    click_button 'Update'
    click_link 'Log out'
    log_in_as user
    click_link project.name
    click_link ticket.title
    click_link 'Edit Ticket'
    fill_in 'Title', with: 'a ticket'
    fill_in 'Description', with: 'another description'
    click_button 'Update Ticket'
    expect(page).to have_content 'Ticket updated'
    expect(page).to have_content 'a ticket'
  end

  scenario 'delete a ticket of a project' do
    check_permission_box 'view', project
    check_permission_box 'delete tickets', project
    click_button 'Update'
    click_link 'Log out'
    log_in_as user
    click_link project.name
    click_link ticket.title
    click_link 'Delete Ticket'
    expect(page).to have_content 'Ticket Deleted'
    expect(page).to_not have_content ticket.title
    expect(page.current_url).to eq project_url(project)
  end
end
