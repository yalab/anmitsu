FactoryGirl.define do;
  factory :user do
    email { Faker::Internet.email }
    password(pass = 'password')
    password_confirmation(pass)
  end
end
