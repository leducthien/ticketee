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
end
