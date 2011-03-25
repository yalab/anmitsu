class ClientsController < ApplicationController
  respond_to :json
  def index
    regex = if (name = params[:item][:client_name]) =~ /[a-z]/
              Migemo.new(name).regex
            else
              Regexp.compile(name)
            end
    @client_names = current_user.items.where(:client_name => /^(#{regex})/).distinct(:client_name)
    respond_with(@client_names)
  end
end
