module ApplicationHelper
  def title(page_title)
    content_for :title, "#{page_title}#{SETTINGS[:title_suffix]}"
  end

  def unescape_quotes(string)
    string.gsub('\&quot;', '"').html_safe
  end

  def generate_interactive_chart(options = {})
    type   = options.delete(:type)  or raise ArgumentError, "no type given"
    domid  = options.delete(:domid) or raise ArgumentError, "no domid given"
    data   = options.delete(:data)  or raise ArgumentError, "no data given"
    fmt    = options.delete(:fmt) || "normal" # is not called format, because of Kernel#format
    js_options = options.delete(:js) || {}
    <<-SCRIPT.html_safe
    <div id="#{domid}" class="chart-format-#{fmt}"><svg></svg></div>
    <script>
      $(function(){
        generateChart_#{type}("#{domid}", #{data.to_json}, true, #{js_options.to_json})
      })
    </script>
    SCRIPT
  end
end
