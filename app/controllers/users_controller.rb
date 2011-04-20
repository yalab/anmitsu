class UsersController < Devise::RegistrationsController
  def registered
  end

  private
  def after_inactive_sign_up_path_for(*args)
    users_registered_path
  end
end
