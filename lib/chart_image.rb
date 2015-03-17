module ChartImage
  def run(type, output_path, data)
    Phantomjs.run \
      Rails.root.join('lib', 'chart_image', 'generate_chart.js').to_s,
      type,
      output_path,
      *data
  end
end