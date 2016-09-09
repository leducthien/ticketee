require 'spec_helper'

feature 'Deleting projects' do
  scenario 'Can delete a project' do
    FactoryGirl.create(:project, name: 'Atom')
    visit '/'
    click_link 'Atom'
    click_link 'Delete project'
    expect(page).to have_content 'Project deleted'
    visit '/'
    expect(page).to have_no_content 'Atom'
  end
end
