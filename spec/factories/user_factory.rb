
FactoryGirl.define do
  factory :user do
    name 'user 1'
    email 'email 1'
    password 'password'
    password_confirmation 'password'

    factory :admin_user do
      admin true
    end
  end
end
