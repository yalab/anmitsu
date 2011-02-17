# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone
Mime::Type.register 'application/pdf', :pdf
ActionController.add_renderer :pdf do |model, options|
  if ENV['NOPDF']
    self.content_type = Mime::HTML
    self.response_body = render_to_string(:file => "pdfs/#{model.class.name.underscore}")
  else
    pdfkit = PDFKit.new(render_to_string(:file => "pdfs/#{model.class.name.underscore}"))
    send_data pdfkit.to_pdf, :filename => model.title + '.pdf'
  end
end
