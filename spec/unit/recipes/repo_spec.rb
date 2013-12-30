require 'spec_helper'

describe 'bigtop::repo'  do
  let(:chef_run) do
    ChefSpec::Runner.new(platform: 'centos', version: '6.4')
                    .converge(described_recipe)
  end

  it 'gets the bigtop repository' do
    expect(chef_run).to create_remote_file('/etc/yum.repos.d/bigtop.repo')
      .with_owner('root')
      .with_group('root')
      .with_mode('0644')
  end
end
