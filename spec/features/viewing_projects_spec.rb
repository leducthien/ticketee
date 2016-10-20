require 'spec_helper'

feature 'Viewing projects' do
  let!(:user) { FactoryGirl.create(:user)}
  let!(:project) {FactoryGirl.create(:project)}

  before do
    log_in_as user
    define_permission!(user, :view, project)
    @project_tm = FactoryGirl.create(:project, name: 'Text Mate 2') # In spec/factories/project_factory.rb
    define_permission!(user, :view, @project_tm)
    FactoryGirl.create(:project, name: 'Ambiot')
    visit '/'
  end

  scenario 'Can view a project' do
    click_link @project_tm.name
    expect(page.current_url).to eql project_url(@project_tm)
  end

  scenario 'Can view all projects' do
    expect(page).to have_content 'Text Mate 2'
    expect(page).to have_content 'Ambiot'
    click_link project.name
    expect(page.current_url).to eql project_url(project)
  end
end
