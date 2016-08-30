require 'spec_helper'

feature 'Create projects' do
  scenario 'Can create a new project' do
    visit '/'
    click_link 'New project'
    fill_in 'Name', with: 'Textmate 2'
    fill_in 'Description', with: 'Text editor for Mac'
    click_button 'Create Project'
    expect(page).to have_content 'project created'
    project = Project.where(name: 'Textmate 2').first
    expect(page.current_url).to eql project_url(project)
    expect(page).to have_title 'Textmate 2 - Projects - Ticketee'
  end
end
