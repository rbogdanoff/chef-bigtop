require 'spec_helper'

# describe 'bigtop::install' do
# 
#   let(:bigtop_utils_file) do
#     file('/etc/default/bigtop-utils')
#   end
#   it 'had JAVA_HOME inserted into the bigtop-utils file' do
#     expect(bigtop_utils_file).to contain /JAVA_HOME/
#   end
# 
#   # are all the expected services installed/running
#   it 'had the hadoop-hdfs-namenode service enabled and running' do
#     expect(service('hadoop-hdfs-namenode')).to be_enabled
#     expect(service('hadoop-hdfs-namenode')).to be_running
#   end
#   it 'had the hadoop-hdfs-datanode service enabled and running' do
#     expect(service('hadoop-hdfs-datanode')).to be_enabled
#     expect(service('hadoop-hdfs-datanode')).to be_running
#   end
#   it 'had the hadoop-yarn-resourcemanager service enabled and running' do
#     expect(service('hadoop-yarn-resourcemanager')).to be_enabled
#     expect(service('hadoop-yarn-resourcemanager')).to be_running
#   end
#   it 'had the hadoop-yarn-nodemanager service enabled and running' do
#     expect(service('hadoop-yarn-nodemanager')).to be_enabled
#     expect(service('hadoop-yarn-nodemanager')).to be_running
#   end
# 
#   # does the hadoop cli work?
#   it 'has a working hadoop command' do
#     expect(command('hadoop')).to return_exit_status 0
#   end
# 
#   # some basic checking that hdfs got seeded
#   it 'has hdfs /tmp dir' do
#     expect(command('hadoop fs -ls /tmp')).to return_exit_status 0
#   end
#   it 'has hdfs /user dir' do
#     expect(command('hadoop fs -ls /user')).to return_exit_status 0
#   end
#   it 'has hdfs /var dir' do
#     expect(command('hadoop fs -ls /var')).to return_exit_status 0
#   end
# 
# end
