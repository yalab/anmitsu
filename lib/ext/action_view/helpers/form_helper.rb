ActionView::Helpers::FormBuilder.module_eval do
  def error_message(attribute)
    @object.errors[attribute].map{|error|
      attr_name = @object.class.human_attribute_name(attribute, :default => attribute.to_s.gsub('.', '_').humanize)
      message = I18n.t(:"activemodel.errors.full_messages.format", :message => error, :attribute => attr_name)
      '<span class="alert">' + message + '</span>'

    }.join("<br>").html_safe
  end
end
