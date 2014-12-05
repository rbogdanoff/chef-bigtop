#
# Author:: Ron Bogdanoff (<ron.bogdanoff@gmail.com>)
# Cookbook Name:: bigtop
# Recipe:: base
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

# The private 'base' recipe for the bigtop cookbook.  This install/configures
# all common components

# bigtop currently requires sun java6
node.set.java.install_flavor = 'oracle'
node.default.java.oracle.accept_oracle_download_terms = true
include_recipe 'java'
