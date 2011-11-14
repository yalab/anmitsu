class Users::SessionsController < Devise::SessionsController
  private
  def after_sign_in_path_for(resource)
    items_path
  end
end
