class VisualAid < ActiveRecord::Base
  belongs_to :discussion
  has_many :visual_aids_logs
end
