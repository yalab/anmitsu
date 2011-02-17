ActionView::Helpers::RawOutputHelper.module_eval do
  def nl2br(stringish)
    html_escape(stringish).gsub(/\n/, '<br>').html_safe
  end
end
