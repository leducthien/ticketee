require 'spec_helper'

describe ProjectsController do
  it 'displays errors for a missing project' do
    get :show, id: 'not-exist'
    expect(response).to redirect_to projects_path
    message = 'Project not exist'
    expect(flash[:alert]).to eql message
  end
end
