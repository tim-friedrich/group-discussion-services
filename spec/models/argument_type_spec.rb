require 'spec_helper'

RSpec.describe ArgumentType, :type => :model do
  let(:argument_type) { ArgumentType.find_by(name:'proband') }

  it { argument_type.should respond_to(:name) }
end
