require 'spec_helper'

describe ProjectsController do
  let!(:user) { FactoryGirl.create(:user) }

  it 'displays errors for a missing project' do
    get :show, id: 'not-exist'
    expect(response).to redirect_to projects_path
    message = 'Project not exist'
    expect(flash[:alert]).to eql message
  end

  context 'standard users' do
    before do
      sign_in user
    end

    { new: :get, create: :post, edit: :get, update: :put, destroy: :delete}.each do |action, method|
      it "cannot access the #{action} action" do
        send(method, action, id: FactoryGirl.create(:project))
        expect(response).to redirect_to('/')
        expect(flash[:alert]).to eql 'You must be admin to do that'
      end
    end

  end
end
