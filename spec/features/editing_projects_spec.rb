require 'spec_helper'


feature 'Editing projects' do
  before do
    admin_user = FactoryGirl.create(:user, admin: true)
    log_in_as admin_user
    project = FactoryGirl.create(:project, name: 'Text Mate 2')
    visit '/'
    click_link 'Text Mate 2'
    click_link 'Edit Project'
  end

  scenario 'Can edit a project' do
    fill_in 'Description', with: 'A text editor for Mac'
    click_button 'Update Project'
    expect(page).to have_content 'Project Updated'
  end

  scenario 'Change a project name to blank should raise errors' do
    fill_in 'Name', with: ''
    click_button 'Update Project'
    expect(page).to have_content 'Fail to update project'
  end
end
