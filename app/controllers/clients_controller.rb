class ClientsController < ApplicationController
  respond_to :json
  def index
    regex = if (name = params[:item][:client_name]) =~ /[a-z]/
              Migemo.new(name).regex
            else
              Regex.compile(name)
            end
    @client_names = current_user.items.where(:client_name => /^(#{regex})/).map(&:client_name)
    respond_with(@client_names)
  end
end