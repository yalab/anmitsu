ActionView::Helpers::FormBuilder.module_eval do
  def error_message(attribute)
    @object.errors[attribute].map{|error| '<span class="error">' + error + '</span>'}.join("<br>").html_safe
  end
end
