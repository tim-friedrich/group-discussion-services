require 'spec_helper'


RSpec.describe Role, :type => :model do
  it 'has user record' do
    expect( Role.user ).to be_a Role
  end

  it 'has proband record' do
    expect( Role.proband ).to be_a Role
  end

  it 'has observer record' do
    expect( Role.observer ).to be_a Role
  end

  it 'has moderator record' do
    expect( Role.moderator ).to be_a Role
  end

  it 'has deputy record' do
    expect( Role.deputy ).to be_a Role
  end

  it 'has admin record' do
    expect( Role.admin ).to be_a Role
  end
end
