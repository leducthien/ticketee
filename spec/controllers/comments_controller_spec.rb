require 'spec_helper'

describe CommentsController do
  let!(:admin) { FactoryGirl.create(:admin_user)}
  let!(:project) { FactoryGirl.create(:project)}
  let!(:ticket) { FactoryGirl.create(:ticket, project: project)}
  let!(:state) {FactoryGirl.create(:state)}

  context 'admin user' do
    before do
      sign_in admin
    end

    it 'should be able to create a comment with a state and tags' do
      post :create, ticket_id: ticket.id, comment: {text: 'a comment', state_id: state.id, tag_names: 'cloud rails cloud'}
      response.should redirect_to project_ticket_path(project, ticket)
      t = Ticket.find(ticket.id)
      expect(t.state.id).to eql(state.id)
      expect(t.comments.size).to eql(1)
      expect(t.comments.exists?(text: 'a comment')).to be_truthy
      expect(t.tags.size).to eql(2)
      expect(t.tags.exists?(name: 'cloud')).to be_truthy
      expect(t.tags.exists?(name: 'rails')).to be_truthy
    end
  end
end
