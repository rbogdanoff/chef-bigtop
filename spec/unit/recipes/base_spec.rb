require 'spec_helper'

describe 'bigtop::base'  do
  let(:chef_run) do
    ChefSpec::Runner.new(platform: 'centos', version: '6.4')
                    .converge(described_recipe)
  end

  it 'includes the java recipe' do
    expect(chef_run).to include_recipe('java')
  end

end
