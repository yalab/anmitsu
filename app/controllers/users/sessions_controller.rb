class Users::SessionsController < Devise::SessionsController
  def sign_in_and_redirect(*args)
    redirect_to items_path
  end
end
