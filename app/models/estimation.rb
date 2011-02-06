class Estimation
  include Mongoid::Document
  include Mongoid::Timestamps

  [:title, :description, :note, :client_name].each{|name| field name, :type => String }
  [:created_at].each{|name| field name, :type => Time }
  referenced_in :user
  embeds_many :accounts
  validates :title, :presence => true

  def total
    accounts.map{|account| account.price }.inject(:+)
  end

  def to_pdf
    dir = "#{Rails.root}/tmp/pdf/#{user.id}"
    Dir.mkdir(dir) unless File.exists? dir
    fname = "#{dir}/#{title}.pdf"
    estimation = self
    helper = self.class
    Prawn::Document.generate(fname, :page_layout => :portrait) do
      font "#{Rails.root}/vendor/fonts/ipag00302/ipag.ttf"
      text I18n.t("Estimation"), :size => 36, :align => :center
      last_update = I18n.t('Last update') + ': ' + I18n.l(estimation.updated_at.to_date, :format => :default)
      text last_update, :size => 16, :align => :right, :float => :right
      build_rows = lambda{|*args|
        (rows, options) = args
        left_margin = options[:left_margin] || 0
        under_line = options[:under_line] || false
        rows.each do |left, right|
          right ||= ''
          bounding_box([left_margin, cursor], :width => 220, :height => 15){
            float{ text right, :align => :right, :width => 20 } && text(left)
            stroke_horizontal_rule if under_line
          }
        end
      }
      left_rows = [[estimation.client_name, I18n.t('Sir')],
                   [estimation.title, ''],
                   [I18n.t('Total'), number_to_currency(estimation.total)]]

      base_info    = estimation.user.base_info
      bank_account = estimation.user.bank_account
      right_rows = [[I18n.t('Name'),    base_info.name],
                    [I18n.t('Address'), base_info.address],
                    [I18n.t('Tel'),     base_info.tel]]
      right_rows << [I18n.t('Fax'),     base_info.fax] if base_info.fax && base_info.fax.length > 0

      bounding_box [0, cursor - 10], :height => 100, :width => 300 do
        float{ build_rows.call(left_rows, :under_line => true) } && build_rows.call(right_rows, :left_margin => 320)
      end

      table [:bank_name, :branch_name, :code, :name].map{|k| [I18n.t("activemodel.attributes.bank_account.#{k}"), bank_account[k]]}, :headers => [I18n.t('Recipient'), ''], :column_widths => {0 => 100, 1 => 200}, :align => {0 => :left, 1 => :left}

      stamp_width = 50
      margin_botom = 20
      bounding_box [bounds.width - (stamp_width * 3) - margin_botom, cursor + 30], :height => stamp_width + margin_botom, :width => 100 do
        2.times{|n| stroke_rectangle([cursor + n * stamp_width, cursor], stamp_width, stamp_width) }
      end
      rows =  estimation.accounts.map{|account| [account.content, number_to_currency(account.price)]} + (0..(35 - estimation.accounts.length)).map{['', '']}
      table rows, {:headers       => ["Content", "Price"].map{|k| I18n.t(k) },
                   :header_color  => '3333aa',
                   :header_text_color => 'ffffff',
                   :align         => {1 => :right},
                   :align_headers => :center,
                   :column_widths => {1 => 100},
                   :width         => 540}
      number_pages "<page> / <total>", [bounds.right - 30, -10]
    end
    fname
  end
end






