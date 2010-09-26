User.create(:email => 'admin@example.com', :password => (pass = 'password'), :password_confirmation => pass).confirm!
