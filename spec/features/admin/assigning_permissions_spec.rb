require 'spec_helper'

feature 'Assigning permissions' do
  let!(:admin) { FactoryGirl.create(:admin_user) }
  let!(:user) { FactoryGirl.create(:user)}
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
end
