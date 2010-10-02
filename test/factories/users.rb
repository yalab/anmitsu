Factory.define :user do |f|
  f.email { Faker::Internet.email }
  f.password(pass = 'password')
  f.password_confirmation(pass)
end
