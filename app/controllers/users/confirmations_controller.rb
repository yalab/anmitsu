class Users::ConfirmationsController < Devise::ConfirmationsController
  private
  def redirect_location(*args)
    items_path
  end
end
