#
# Author:: Ron Bogdanoff (<ron.bogdanoff@gmail.com>)
# Cookbook Name:: bigtop
# Recipe:: install
#
# Copyright 2013, Ron Bogdanoff
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# private recipe the will do the bigtop install

# install bigtop components.  when done, notify configuration steps
ruby_block 'install_bigtop_components' do
  block do
    node.bigtop.components.each do |component|
      Chef::Log.info "installing #{component} - this may take a few minutes"
      install = Mixlib::ShellOut.new("yum -y -q install '#{component}*'")
      install.run_command
    end
  end
  notifies :create, 'ruby_block[insert_java_home]',        :immediately
  notifies :run, 'execute[format_namenode]',               :immediately
  notifies :run, 'execute[seed_hdfs]',                     :delayed
  notifies :run, 'execute[user_hdfs]',                     :delayed
  notifies :start, 'service[hadoop-yarn-resourcemanager]', :delayed
  notifies :start, 'service[hadoop-yarn-nodemanager]',     :delayed
  notifies :run, 'execute[start-bigtop-services]',         :delayed
  only_if  { node.bigtop.components }
end

# make sure JAVA_HOME is set in the 'bigtop-utils' file
ruby_block 'insert_java_home' do
  block do
    file = Chef::Util::FileEdit.new('/etc/default/bigtop-utils')
    file.insert_line_if_no_match('^\s*export\s*JAVA_HOME\s*=\s*[\/a-zA-Z0-9]+\s*$',
                                 "export JAVA_HOME=#{node.java.java_home}")
    file.write_file
  end
  action :nothing
end

# only format once!! TODO: better way to check than seeing if VERSION file exists?
execute 'format_namenode' do
  command 'sh /etc/init.d/hadoop-hdfs-namenode init'
  creates '/var/lib/hadoop-hdfs/cache/hdfs/dfs/name/current/VERSION'
  action :nothing
end

# make sure hadoop-hdfs-namenode, "hadoop-hdfs-datanode services are
# started before execute seed_hdfs

service 'hadoop-hdfs-namenode' do
  action :start
end
service 'hadoop-hdfs-datanode' do
  action :start
end

# TODO/FIXME: improve only_if check, we currently only test ls /t*
execute 'seed_hdfs' do
  command 'sudo sh /usr/lib/hadoop/libexec/init-hdfs.sh'
  user 'root'
  action :nothing
 # only_if "test  -z \"`hadoop fs -ls /t*`\""
end

# create hdfs dir for node.bigtop.user and change some other privs
execute 'user_hdfs' do
  command "hadoop fs -mkdir -p /user/#{node.bigtop.user} ;
           hadoop fs -chown #{node.bigtop.user}:#{node.bigtop.user} /user/#{node.bigtop.user} ;
           hadoop fs -chmod 755 /user/#{node.bigtop.user} ;
           hadoop fs -mkdir -p /tmp/hadoop-yarn/staging ;
           hadoop fs -chmod -R 1777 /tmp/hadoop-yarn/staging ;
           hadoop fs -mkdir -p /tmp/hadoop-yarn/staging/history/done_intermediate ;
           hadoop fs -chmod -R 1777 /tmp/hadoop-yarn/staging/history/done_intermediate"
  user 'hdfs'
  action :nothing
 # only_if "test  -z \"`hadoop fs -ls /user/#{node.bigtop.user}`\""
end

# after hdfs_seed startup yarn
service 'hadoop-yarn-resourcemanager' do
  supports status: true, restart: true, reload: true
  action :nothing
end

service 'hadoop-yarn-nodemanager' do
  supports status: true, restart: true, reload: true
  action :nothing
end

# the bigtop package installs do not start the services!!, so we can do this here
# by issuing runlevel 3 which will starts services in correct order (we hope)
# TODO: when we refactor to separate recipes for each hadoop component
# we will use service resource to start the service instead of the
# brute force init 3 (so we don't restart services if we are only provisioning
# a VM that is already running)
execute 'start-bigtop-services' do
  command 'telinit 3'
  action :nothing
end
