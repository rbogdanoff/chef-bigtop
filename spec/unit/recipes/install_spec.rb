require 'spec_helper'

describe 'bigtop::install'  do
  let(:chef_run) do
    ChefSpec::Runner.new(platform: 'centos', version: '6.4')
                    .converge(described_recipe)
  end
  let(:install_components) do
    chef_run.ruby_block('install_bigtop_components')
  end

  it 'sends notify from install components to format namenode' do
    expect(install_components).to notify('execute[format_namenode]').immediately
  end
  it 'sends notify from install components to seed hdfs' do
    expect(install_components).to notify('execute[seed_hdfs]').delayed
  end
  it 'sends notify from install components to hadoop-yarn-resourcemanager' do
    expect(install_components).to notify('service[hadoop-yarn-resourcemanager]').delayed
  end
  it 'sends notify from install components to hadoop-yarn-nodemanager' do
    expect(install_components).to notify('service[hadoop-yarn-nodemanager]').delayed
  end
  it 'sends notify from install components to start-bigtop-services' do
    expect(install_components).to notify('execute[start-bigtop-services]').delayed
  end

  it 'starts the hdfs namenode service' do
    expect(chef_run).to start_service('hadoop-hdfs-namenode')
  end
  it 'starts the hdfs datanode service' do
    expect(chef_run).to start_service('hadoop-hdfs-datanode')
  end
  it 'starts the hdfs namenode service' do
    expect(chef_run).to start_service('hadoop-hdfs-namenode')
  end
end
