require 'spec_helper'


RSpec.describe ArgumentType, :type => :model do
  it 'has proband record' do
    expect( ArgumentType.proband ).to be_a ArgumentType
  end

  it 'has observer record' do
    expect( ArgumentType.observer ).to be_a ArgumentType
  end

  it 'has moderator record' do
    expect( ArgumentType.moderator ).to be_a ArgumentType
  end
end
