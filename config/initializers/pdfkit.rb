PDFKit.configure do |config|
  config.wkhtmltopdf = (Rails.env == 'production') ? Rails.root.join("bin", "wkhtmltopdf") : "/usr/local/bin/wkhtmltopdf"
  config.default_options = {:page_size        => 'Legal',
                            :print_media_type => true}
end
