require 'spec_helper'

describe 'bigtop::default'  do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'centos', version: '6.4')
                    .converge(described_recipe)
  end

  it 'includes the base recipe' do
    expect(chef_run).to include_recipe('bigtop::base')
  end
  it 'includes the repo recipe' do
    expect(chef_run).to include_recipe('bigtop::repo')
  end
  it 'includes the install recipe' do
    expect(chef_run).to include_recipe('bigtop::install')
  end
end
