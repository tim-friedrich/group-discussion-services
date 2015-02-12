class VisualAid < ActiveRecord::Base
  belongs_to :discussion
  has_many :visual_aids_logs
  has_attached_file :file, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z|\Avideo\/.*\Z/
end
