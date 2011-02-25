ActionMailer::Base.module_eval do
  def mail_with_charset(headers={}, &block)
    m = mail_without_charset(headers, &block)
    m.body.charset = m.charset = charset
    m
  end
  alias_method_chain :mail, :charset
end