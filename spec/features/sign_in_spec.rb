require 'spec_helper'

feature 'Sign In' do
  let(:user) { FactoryGirl.create(:user) }

  before do
    visit '/'
    click_link 'Sign in'
  end

  scenario 'Sign in successfully' do
    fill_in 'Name', with: user.name
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    expect(page).to have_content 'You have signed in'
  end

  scenario 'Sign in fail' do
    fill_in 'Name', with: 'unknow'
    fill_in 'Password', with: 'wrong'
    click_button 'Sign in'
    expect(page).to have_content 'Wrong name/password combination'
  end
end
