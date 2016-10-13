require 'spec_helper'

describe Admin::UsersController do

  describe "GET 'index' for standard users" do
    before do
      user = FactoryGirl.create(:user)
      sign_in user
    end

    it "cannot access index" do
      get 'index'
      expect(response).to redirect_to('/')
      expect(flash[:alert]).to eql 'You must be admin to do that'
    end
  end

end
