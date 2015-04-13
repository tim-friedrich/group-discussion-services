class ArgumentType < ActiveRecord::Base
  has_many :arguments

  ARGUMENT_TYPES = %I[
    proband
    moderator
    observer
  ]


  def self.create_defaults!
    ARGUMENT_TYPES.each{ |role|
      ArgumentType.create!(name: role.to_s) unless ArgumentType.public_send(role)
    }
  end

  ARGUMENT_TYPES.each{ |role|
    self.define_singleton_method role do
      ArgumentType.find_by_name(role.to_s)
    end
  }
end
