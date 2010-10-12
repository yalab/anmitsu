class UsersController < Devise::RegistrationsController
  def registered
  end

  private
  def sign_in_and_redirect(*args)
    redirect_to users_registered_path
  end
end
