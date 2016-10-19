
FactoryGirl.define do
  sequence(:email) { |n| "user#{n}@example.com" }

  factory :user do
    name 'user 1'
    email { generate(:email) }
    password 'password'
    password_confirmation 'password'

    factory :admin_user do
      admin true
    end
  end
end
