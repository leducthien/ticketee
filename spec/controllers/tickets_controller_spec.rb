require 'spec_helper'

describe TicketsController do
  let!(:user) { FactoryGirl.create(:user)}
  let!(:project) { FactoryGirl.create(:project)}
  let!(:ticket) { FactoryGirl.create(:ticket, project: project)}

  it 'cannot see tickets of a project without permission' do
    sign_in user
    get :show, id: ticket.id, project_id: project.id
    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to eql 'Project not exist'
  end

  context 'with permission to view projects' do
    before do
      sign_in user
      define_permission!(user, 'view', project)
    end

    it 'cannot begin to create a ticket' do
      get :new, project_id: project.id
      cannot_create_tickets!
    end

    it 'cannot create a ticket' do
      post :create, project_id: project.id, ticket: { title: 'ticket1', description: 'a sample description' }
      cannot_create_tickets!
    end

    def cannot_create_tickets!
      response.should redirect_to(project)
      expect(flash[:alert]).to eql "You cannot create tickets for this project"
    end

    it 'cannot edit a ticket without permission' do
        get :edit, project_id: project.id, id: ticket.id
        cannot_edit_tickets!
    end

    it 'cannot update a ticket without permission' do
      patch :update, project_id: project.id, id: ticket.id, ticket: { title: '', description: '' }
      cannot_edit_tickets!
    end

    def cannot_edit_tickets!
      response.should redirect_to project
      expect(flash[:alert]).to eql 'You cannot edit tickets for this project'
    end

    it 'cannot delete a ticket without permission' do
      delete :destroy, project_id: project.id, id: ticket.id
      response.should redirect_to project
      expect(flash[:alert]).to eql 'You cannot delete tickets for this project'
    end

  end
end
