require 'spec_helper'

describe 'bigtop::install' do

  describe file('/etc/default/bigtop-utils') do
    its(:content) { should match /^export JAVA_HOME/ }
  end
 
  # are all the expected services installed/running
  %w(hadoop-hdfs-namenode hadoop-yarn-resourcemanager 
     hadoop-yarn-nodemanager).each do |s|
  	describe service(s) do
  	  it { should be_enabled }
  	  it { should be_running }
    end
  end
  
  describe command('hadoop') do
    its(:exit_status) { should eq 0 }
  end

  describe 'the hdfs' do
  	describe 'is seeded' do
  	  ['hadoop fs -ls /tmp', 
  	   'hadoop fs -ls /user',
  	   'hadoop fs -ls /var'].each do |h|
  	    describe command(h) do
  	  	  its(:exit_status) { should eq 0 }
  	    end
  	  end
  	end
  end

end
