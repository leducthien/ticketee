require 'spec_helper'

describe FilesController do
  let(:good_user) { FactoryGirl.create(:user) }
  let(:bad_user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket,  project: project,  user: good_user) }
  let(:path) { Rails.root + "spec/fixtures/speed.txt" }
  let(:asset) do
    ticket.assets.create(asset: File.open(path))
  end
  before do
    good_user.permissions.create!(action: "view", thing: project)
  end

  context 'user with access' do
    before do
      sign_in good_user
    end

    it 'can access assets in a project' do
      get :show, id: asset.id
      expect(response.body).to eql(File.read(path))
    end
  end

  context 'user without access' do
    before do
      sign_in bad_user
    end

    it 'cannot access asset in a project' do
      get :show, id: asset.id
      expect(response).to redirect_to root_path
      expect(flash[:alert]).to eql 'You are not authorized to view the asset'
    end
  end
end
