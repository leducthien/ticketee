require 'spec_helper'

feature "hidden links" do
  let!(:user) { FactoryGirl.create(:user)}
  let!(:admin) { FactoryGirl.create(:admin_user, name: 'Thien')}
  let!(:project) { FactoryGirl.create(:project) }

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

    scenario 'standard user cannot create a new project' do
      visit '/'
      assert_no_link_for 'New project'
    end

    scenario 'standard user cannot edit a project' do
      visit project_path project
      assert_no_link_for 'Edit Project'
    end

    scenario 'standard user cannot delete a project' do
      visit project_path project
      assert_no_link_for 'Delete project'
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
  end
end
