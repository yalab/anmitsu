FactoryGirl.define do;
  factory :user do
    email { Faker::Internet.email }
    password(pass = 'password')
    password_confirmation(pass)
    items {|u| [FactoryGirl.create(:item, :user => u)] }
    bank_account {|u| u.create_bank_account(FactoryGirl.build(:bank_account))}
  end
end
