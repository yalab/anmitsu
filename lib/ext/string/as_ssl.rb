class String
  REG_HTTP = /^http:/
  def as_ssl
    gsub!(REG_HTTP, 'https:') if Rails.env != 'development'
    self
  end
end
