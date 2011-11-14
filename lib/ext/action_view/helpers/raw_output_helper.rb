module ActionView::Helpers::OutputSafetyHelper
  def nl2br(stringish)
    html_escape(stringish).gsub(/\n/, '<br>').html_safe
  end
end
