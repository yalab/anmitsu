class ApplicationController < ActionController::Base
  force_ssl
  protect_from_forgery
  before_filter{
    @javascripts = []
  }

  private
  def after_sign_in_path_for(resource)
    items_path
  end

  def after_confirmation_path_for(resource_name, resource)
    items_path
  end
end




