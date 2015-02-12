class Contact < ActiveRecord::Base
  has_many :research_institutes
  has_many :companies
end
