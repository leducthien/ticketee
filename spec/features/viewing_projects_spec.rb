require 'spec_helper'

feature 'Viewing projects' do
  let!(:user) { FactoryGirl.create(:user)}
  let!(:project) {FactoryGirl.create(:project)}

  before do
    log_in_as user
    define_permission(user, :view, project)
    FactoryGirl.create(:project, name: 'Text Mate 2') # In spec/factories/project_factory.rb
    FactoryGirl.create(:project, name: 'Ambiot')
  end

  scenario 'Can view a project' do
    name = 'Text Mate 2'
    project = Project.find_by(name: name)
    visit '/'
    click_link name
    expect(page.current_url).to eql project_url(project)
  end

  scenario 'Can view all projects' do
    visit '/'
    expect(page).to have_content 'Text Mate 2'
    expect(page).to have_content 'Ambiot'
    click_link project.name
    expect(page.current_url).to eql project_url(project)
  end
end
