require 'spec_helper'

describe ArgumentsController do
	before do
		@argument = FactoryGirl.create(:argument)
		@valid_attributes = FactoryGirl.attributes_for(:argument)
	end

	let(:valid_session) { }

end
