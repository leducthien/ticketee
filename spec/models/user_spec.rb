require 'spec_helper'

describe User do
  describe 'passwords' do
    it 'needs password and confirmation to save' do
      u = User.new(name: 'user 1')
      u.save
      expect(u).to_not be_valid

      u.password = 'password'
      u.password_confirmation = '' # If obmit this, can save without errors. Why?
      u.save
      expect(u).to_not be_valid

      u.password_confirmation = 'password'
      u.save
      u.email = 'user1@example.com'
      expect(u).to be_valid
    end

    it 'needs password and confirmation to match' do
      u = User.create(name: 'user1', password: 'password', password_confirmation: 'pass')
      expect(u).to_not be_valid
    end
  end

  describe 'authentication' do
    let(:user) { User.create(name: 'user 1', password: 'hunt', password_confirmation: 'hunt' )}

    it 'authenticates with a correct password' do
      expect(user.authenticate('hunt')).to be
    end

    it 'does not authenticate with an incorrect password' do
      expect(user.authenticate('hunter')).to_not be
    end
  end

  describe 'Email' do
    it 'requires email to save' do
      u = User.create(name: 'user 1', password: 'password', password_confirmation: 'password')
      u.save
      expect(u).to_not be_valid
      u.email = 'user1@example.com'
      expect(u).to be_valid
    end
  end
end
