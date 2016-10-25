require 'spec_helper'

feature "hidden links" do
  let!(:user) { FactoryGirl.create(:user)}
  let!(:admin) { FactoryGirl.create(:admin_user, name: 'Thien')}
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) { FactoryGirl.create(:ticket, project: project) }

  context 'anonymous users' do
    scenario 'anonymous user cannot create a new project' do
      visit '/'
      assert_no_link_for 'New project'
    end

    scenario 'anonymous user cannot edit a project' do
      visit project_path(project)
      assert_no_link_for 'Edit Project'
    end

    scenario 'anonymous user cannot delete a project' do
      visit project_path(project)
      assert_no_link_for 'Delete project'
    end
  end

  context 'standard users' do
    before do
      log_in_as user
    end

    scenario 'cannot create a new project' do
      visit '/'
      assert_no_link_for 'New project'
    end

    scenario 'cannot edit a project' do
      visit project_path project
      assert_no_link_for 'Edit Project'
    end

    scenario 'cannot delete a project' do
      visit project_path project
      assert_no_link_for 'Delete project'
    end

    scenario 'can see new ticket link with permissions' do
      define_permission!(user, 'view', project)
      define_permission!(user, 'create tickets', project)
      visit project_path project
      assert_link_for 'New ticket'
    end

    scenario 'cannot see new ticket link without permissions' do
      define_permission!(user, 'view', project)
      visit project_path project
      assert_no_link_for 'New ticket'
    end

    scenario 'cannot see edit ticket link without permission' do
      define_permission!(user, 'view', project)
      # define_permission!(user, 'view', ticket)
      visit project_path project
      click_link ticket.title
      assert_no_link_for 'Edit Ticket'
    end

    scenario 'can see edit link with permission' do
      define_permission!(user, 'view', project)
      define_permission!(user, 'edit tickets', project)
      visit project_path project
      click_link ticket.title
      assert_link_for 'Edit Ticket'
    end

    scenario 'cannot see delete ticket link without permission' do
      define_permission!(user, 'view', project)
      visit project_path project
      click_link ticket.title
      assert_no_link_for 'Delete Ticket'
    end

    scenario 'can see delete ticket link with permission' do
      define_permission!(user, 'view', project)
      define_permission!(user, 'delete tickets', project)
      visit project_path project
      click_link ticket.title
      assert_link_for 'Delete Ticket'
    end
  end

  context 'admin users' do
    before do
      log_in_as admin
    end

    scenario 'admin user can create a new project' do
      visit '/'
      assert_link_for 'New project'
    end

    scenario 'admin user can edit a project' do
      visit project_path project
      assert_link_for 'Edit Project'
    end

    scenario 'admin user can delete a project' do
      visit project_path project
      assert_link_for 'Delete project'
    end

    scenario 'can see new ticket link always' do
      visit project_path project
      assert_link_for 'New ticket'
    end

    scenario 'can see edit ticket link always' do
      visit project_path project
      click_link ticket.title
      assert_link_for 'Edit Ticket'
    end

    scenario 'can see delete ticket link always' do
      visit project_path project
      click_link ticket.title
      assert_link_for 'Delete Ticket'
    end
  end
end
