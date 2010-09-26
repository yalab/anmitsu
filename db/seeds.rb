User.create(:email => 'admin@example.com', :password => (pass = 'password'), :password_confirmation => pass) if User.count < 0
