module AuthenticationHelpers
  def log_in_as(user)
    visit '/'
    click_link 'Sign in'
    fill_in 'Name', with: user.name
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    expect(page).to have_content 'You have signed in'
  end

  RSpec.configure do |c|
    c.include AuthenticationHelpers, type: :feature
  end
end
