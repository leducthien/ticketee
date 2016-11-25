
FactoryGirl.define do
  sequence(:email) { |n| "user#{n}@example.com" }
  sequence(:name) { |n| "user #{n}"}

  factory :user do
    name { generate(:name)}
    email { generate(:email) }
    password 'password'
    password_confirmation 'password'

    factory :admin_user do
      admin true
    end
  end
end
