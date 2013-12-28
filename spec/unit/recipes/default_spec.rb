#default_spec.rb
require 'spec_helper'

describe 'bigtop::default'  do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.4').converge(described_recipe) }

  it 'includes the java recipe' do
    expect(chef_run).to include_recipe('java')
  end

  it 'gets the bigtop repository' do
    expect(chef_run).to create_remote_file('/etc/yum.repos.d/bigtop.repo')
      .with_owner('root')
      .with_group('root')
      .with_mode('0644')
  end	
end