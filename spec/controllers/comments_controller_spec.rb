require 'spec_helper'

describe CommentsController do
  let!(:admin) { FactoryGirl.create(:admin_user)}
  let!(:project) { FactoryGirl.create(:project)}
  let!(:ticket) { FactoryGirl.create(:ticket, project: project)}
  let!(:state) {FactoryGirl.create(:state)}
  let!(:user) {FactoryGirl.create(:user)}

  context 'admin user' do
    before do
      sign_in admin
    end

    it 'should be able to create a comment with a state and tags' do
      post :create, ticket_id: ticket.id, comment: {text: 'a comment from admin', state_id: state.id, tag_names: 'cloud rails cloud admin'}
      response.should redirect_to project_ticket_path(project, ticket)
      t = Ticket.find(ticket.id)
      expect(t.state.id).to eql(state.id)
      expect(t.comments.size).to eql(1)
      expect(t.comments.exists?(text: 'a comment from admin')).to be_truthy
      expect(t.tags.size).to eql(3)
      expect(t.tags.exists?(name: 'cloud')).to be_truthy
      expect(t.tags.exists?(name: 'rails')).to be_truthy
    end
  end

  context 'normal user' do
    before do
      sign_in user
    end

    it 'can create a comment, but not tag' do
      post :create, ticket_id: ticket.id, comment: {text: 'a comment from user', state_id: state.id, tag_names: 'cloud rails cloud'}
      response.should redirect_to project_ticket_path(project, ticket)
      t = Ticket.find(ticket.id)
      t.tags.should be_empty
      t.state.should be_nil
    end
  end
end
