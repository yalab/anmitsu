Factory.define :user do |f|
  f.email { Faker::Internet.email }
  f.password(pass = 'password')
  f.password_confirmation(pass)
  f.estimations {|u| [Factory(:estimation, :user => u)] }
  f.bank_account {|u| u.create_bank_account(Factory.build(:bank_account))}
end
