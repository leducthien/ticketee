module AuthorizationHelpers
  def define_permission!(user, action, thing)
    Permission.create!(user: user, action: action, thing: thing)
  end

  RSpec.configure do |c|
    c.include AuthorizationHelpers
  end

end
