class Users::SessionsController < Devise::SessionsController
  def sign_in_and_redirect(*args)
    redirect_to estimations_path
  end
end
