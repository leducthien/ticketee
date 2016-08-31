require 'spec_helper'

feature 'Create projects' do
  before do
    visit '/'
    click_link 'New project'
  end

  scenario 'Can create a new project' do
    fill_in 'Name', with: 'Textmate 2'
    fill_in 'Description', with: 'Text editor for Mac'
    click_button 'Create Project'
    expect(page).to have_content 'project created'
    project = Project.where(name: 'Textmate 2').first
    expect(page.current_url).to eql project_url(project)
    expect(page).to have_title 'Textmate 2 - Projects - Ticketee'
  end

  scenario 'Cannot create a new project without a name' do
    click_button 'Create Project'
    expect(page).to have_content 'Project has not been created'
    expect(page).to have_content 'Name can\'t be blank'
  end
end
