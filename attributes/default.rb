#
# Author:: Ron Bogdanoff (<ron.bogdanoff@gmail.com>)
# Cookbook Name:: bigtop 
# Attributes:: default
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

default['bigtop']['user'] = "vagrant"  # shell user you want for using bigtop

include_attribute "java"
default['bigtop']['version'] = "0.6.0"

# bigtop archive 
default['bigtop']['archive_base'] = "http://archive.apache.org/dist/bigtop/"
default['bigtop']['archive'] = "#{node.bigtop.archive_base}bigtop-#{bigtop.version}/"
default['bigtop']['repo_base'] = "#{node.bigtop.archive}repos/"

# repos are platform dependent
case node['platform_family']
when "rhel"
  default['bigtop']['repo_target'] = "/etc/yum.repos.d/bigtop.repo"
  case node['platform']
  when "centos" # TODO: we assume centos6 - we may want to support centos5 too
    default['bigtop']['repo'] = "#{node.bigtop.repo_base}centos6/bigtop.repo"
  end
end

# bigtop components 
# only have tested hadoophdfs and hive.  So, by default we only install these
default['bigtop']['components'] = ["hadoop", "hue"]

# if you want the 'full monty' use this list instead - has not been tested!!
#default['bigtop']['components'] = ["hadoop", "hbase", "hive", "pig", "mahout", "flume", "sqoop", "oozie",
#                                   "whirr", "hue"]  

