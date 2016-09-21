require 'spec_helper'

feature 'Viewing tickets' do
  scenario 'Can view all project tickets' do
    project_atom = FactoryGirl.create(:project, name: 'Atom')
    FactoryGirl.create(:ticket, title: 'ticket 1', description: 'inside browser', project: project_atom)
    visit '/'
    click_link 'Atom'
    expect(page).to have_content 'ticket 1'
  end
end
