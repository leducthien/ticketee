require 'spec_helper'

feature 'Sign Up' do
  scenario 'Visitor can sign up for an account' do
    visit '/'
    click_link 'Sign Up'
    fill_in "Name", with: 'Thien'
    fill_in 'Email', with: 'timducle@yahoo.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'
    expect(page).to have_content 'You have signed up'
  end
end
