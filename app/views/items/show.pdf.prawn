unless Prawn::Document.include?(ActionView::Helpers::NumberHelper)
  Prawn::Document.send(:include, ActionView::Helpers::NumberHelper)
  Prawn::Document.send(:delegate, :t, :l, :to => I18n)
end

prawn_document(:filename=> @item.title + '.pdf') do |pdf|
  pdf.instance_exec(@item, @item.user.information, @item.user.bank_account) do |item, information, bank_account|
    def text(string, options={})
      string = "" unless string
      pad(2){ super(string, options) }
    end

    def border(options={}, &block)
      padding = options.delete(:padding)
      width = @bounding_box.width
      top = cursor
      pad padding do
        indent padding, padding do
          box = block.call
        end
      end
      stroke{ rectangle([0, top], width, top - cursor) }
    end

    fonts_dir = "#{Rails.root}/config/fonts"
    font_families["migmix"] = {:normal => "#{fonts_dir}/migmix-1p-regular.ttf",
                               :bold   => "#{fonts_dir}/migmix-1p-bold.ttf"}
    font("migmix")

    text item.state == 'estimate' ? t('An estimate') : t('Bill'), :align => :center, :size => font_size + 14
    pad 20 do
      text l(item.updated_at.to_date), :align => :right
    end

    float do
      text t("Dear", :name => item.client_name)
      move_down(10)
      text item.title
      move_down(10)
      text "<u>#{t('Total')}#{number_to_currency(item.total_with_tax)}(#{t('tax-inclusive pricing')})</u>", :inline_format => true, :size => font_size + 3
    end

    left_margin = 300

    indent left_margin do
      move_down(22)
      text information.name
      text information.address
      text information.tel
      if information.fax && information.fax.length > 0
        text information.fax
      end
    end

    unless item.estimate?
      move_down(20)
      indent left_margin do
        text t('Recipient'), :style => :bold, :size => font_size + 1
        text bank_account.bank_name + ' ' + bank_account.branch_name +
          if bank_account.branch_number && bank_account.branch_number.length > 0
            "(#{t('Branch number')}:#{bank_account.branch_number})"
          else
            ''
          end
        text "(#{t("bank_type." + bank_account.type)}) #{bank_account.code} #{bank_account.name}"
      end
    end

    move_down(20)

    header = [t('Content'), t('Price')]
    rows = item.accounts.map{|i| [i.content, number_to_currency(i.price)] }
    rows << [t('Tax'), number_to_currency(item.total_with_tax)]
    rows << [t('Total'), number_to_currency(item.total_with_tax)]

    width = @bounding_box.width
    padding = 2
    w = 420
    border :padding => padding do
      table([header, *rows], :header => true, :row_colors => ['FFFFFF', 'F8F8F8'], :column_widths => [w, width - w - (padding * 2)]) do
        cells.style :borders => []
        row(0).style :background_color => '3333AA', :text_color => 'FFFFFF', :align => :center
        columns(1).style :align => :right, :borders => [:left], :border_colors => ['000000', 'FFFFFF']
        row(0).columns(1).style :align => :center
        footer = row(rows.length)
        footer.style :borders => [:top], :background_color => 'FFFFFF'
        footer.columns(0).style :align => :center
      end
    end

    move_down 20
    if item.estimate?
      border :padding => 4 do
        bounding_box([0,cursor], :width => width) do
          text t('Note'), :style => :bold
          text item.note
        end
      end
    end
  end
end
