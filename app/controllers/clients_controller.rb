class ClientsController < ApplicationController
  respond_to :json
  def index
    regexp = if (name = params[:item][:client_name]) =~ /[a-z]/
              Migemo.new(name).regex
            else
              Regexp.compile(name)
            end
    @client_names = current_user.items.select("DISTINCT client_name").where("client_name like ?", regexp)
    respond_with(@client_names)
  end
end
