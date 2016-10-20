require 'spec_helper'

feature 'Viewing tickets' do
  before do
    @project_atom = FactoryGirl.create(:project, name: 'Atom')
    @ticket_without_user = FactoryGirl.create(:ticket, title: 'ticket 1', description: 'inside browser', project: @project_atom)
    @user = FactoryGirl.create(:user)
    define_permission!(@user, :view, @project_atom)
    @ticket_with_user = FactoryGirl.create(:ticket, project: @project_atom)
    @ticket_with_user.update(user: @user)
    log_in_as @user
    visit '/'
    click_link @project_atom.name
  end

  scenario 'Can view all project tickets' do
    expect(page).to have_content @ticket_with_user.title
    expect(page).to have_content @ticket_without_user.title
  end

  scenario 'Can view a ticket without an associated user' do
    click_link @ticket_without_user.title
    expect(page).to_not have_content @user.email
  end

  scenario 'Can view a ticket with an associated user' do
    click_link @ticket_with_user.title
    expect(page).to have_content @user.email
  end
end
