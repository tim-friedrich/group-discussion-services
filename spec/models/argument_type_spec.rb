require 'spec_helper'

describe ArgumentType do
	let(:argument_type) { ArgumentType.where(name:'proband').first }

  	it { argument_type.should respond_to(:name) }
end
