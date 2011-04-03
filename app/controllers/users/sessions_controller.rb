class Users::SessionsController < Devise::SessionsController
  private
  def redirect_location(*args)
    items_path
  end
end
