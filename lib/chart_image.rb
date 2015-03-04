class ChartImage
  def self.exists?(user, namespace = nil)
    user.id && File.exists?(path_for(user, namespace))
  end

  def self.path_for(user, namespace = nil)
    if user.id
      namespace ||= ""
      Rails.root.join('data', namespace, 'charts', 'user', "#{user.id}.png").to_s
    end
  end

  def initialize(user, namespace)
    @user = user
    @namespace = namespace
  end

  def generate!
    if !@user.persisted?
      raise ArgumentError, 'user is not persisted'
    elsif !@user.has_survey?
      raise ArgumentError, 'user has no survey'
    else
      Phantomjs.run \
        Rails.root.join('lib', 'chart_image', 'generate_chart.js').to_s,
        "user",
        self.class.path_for(@user, @namespace),
        *@user.survey.scale_values.map(&:to_s)
    end
  end
end