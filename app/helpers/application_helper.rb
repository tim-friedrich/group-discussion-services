module ApplicationHelper
  def title(page_title)
    content_for :title, "#{page_title}#{SETTINGS[:title_suffix]}"
  end

  def unescape_quotes(string)
    string.gsub('\&quot;', '"').html_safe
  end
end
