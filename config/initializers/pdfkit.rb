PDFKit.configure do |config|
  config.wkhtmltopdf = (Rails.env == 'production') ? "#{Rails.root}/bin/wkhtmltopdf" : "/usr/local/bin/wkhtmltopdf"
  config.default_options = {:page_size        => 'A4',
                            :print_media_type => true}
end
