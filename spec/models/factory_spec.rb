require 'spec_helper'

F.factories.map(&:name).each do |factory_name|
  RSpec.describe "Factory <#{factory_name}>" do
    it 'is valid' do
      factory = F.build_stubbed(factory_name)
      expect(factory).to be_valid, lambda { factory.errors.full_messages.join(',') }
    end

    context 'with trait' do
      F.factories[factory_name].definition.defined_traits.map(&:name).each do |trait_name|
        it "is valid with trait <#{trait_name}>" do
          factory = F.build_stubbed(factory_name, trait_name)
          expect(factory).to be_valid, lambda { factory.errors.full_messages.join(',') }
        end
      end
    end
  end
end