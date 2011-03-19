ActionDispatch::Response.module_eval do
  def json
    ActiveSupport::JSON.decode(body)
  end
end
