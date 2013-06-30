Description
===========

This cookbook installs Apache Bigtop http://bigtop.apache.org/
using Vagrant onto a single VM.  You can use this as a 'sandbox'
for hadoop to try it out.  This is NOT a 'production' cookbook!!

Currently, this is a 'single server' install.  TODO: soon there will be a (small) cluster install too!!! 

By default, it will install hadoop hdfs and hive as this is all that I have
tested thus far.  If you want to install the other components (e.g. hbase, pig, mahout, etc.)
see `attributes/default.rb` it should be obvious what to do

This cookbook essentially does what is described at https://cwiki.apache.org/confluence/display/BIGTOP/How+to+install+Hadoop+distribution+from+Bigtop+0.5.0 

Requirements
============

### what you need

* Ruby 1.9.x 
* the bundle gem  
  `gem install bundle`
* Vagrant 1.2.2 (www.vagrantup.com) - If you have not used Vagrant before, check out their short 'get started' tutorial.
* VirtualBox 4.2.12 (4.2.14 has bug don't use it with Vagrant yet)
* the vagrant plugin vagrant-omnibus
  `vagrant plugin install vagrant-omnibus`
* the vagrant plugin vagrant-berkshelf
  `vagrant plugin install vagrant-berkshelf`

* then cd to where you cloned this repository (where the file Gemfile is located), apply the Gemfile.  
  `bundle install`
  
* A VM will be created on your machine with the hostname of 'bigtop' and an ip number of 33.33.33.10.  Add this line to your /etc/hosts file
  `33.33.33.10     bigtop`  
  
# Usage - 'how to I run this thing?'
You now should be set to go.  cd to the top level directory (where Vagrantfile is located) and start the vagrant box
  `vagrant up`
  
The first time this will take several minutes as the VM image (the box) needs to download.

When vagrant up has completed  you can ssh into the VM
  `vagrant ssh`
  
Then, to test that hadoop is running, try to run the pi test mapreduce job
  `hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples*.jar pi 10 1000`
  
### Chef Usage
* TODO: show example of run_list and chef.json attribute override usage

## Platform
* CentOS6  (more on the way)

# Attributes

See `attributes/default.rb` for default values.

* `node['bigtop']['components']`  list of bigtop components to install
* `node['bigtop']['version']` bigtop version to install - only 0.5.0 is supported right now

# Recipes

## default
this does it all. just use bigtop::default in your run_list 

All other recipes are private

Development
===========
TODO: will provide info on how to develop/improve these recipes.  I will be adding tests 
(ChefSpec/Rspec and test-kitchen) soon.

Known Issues
============
Default components that get installed are hadoop hdfs and hive.  I have not tested the others, but
I did notice that in a single server install, hbase rest and yarn nodemanger both use port 8080 and this
conflict will break yarn nodemanger service from starting.  Will look into this.

See comments in `recipes\install.rb` for some FIXME and TODOs I have tagged

I want to get rid of the ruby_blocks in install.rb.  It will make the recipe better with less 'notifies'

Please let me know any suggestions/improvements/bug you have.  I am still learning Chef and esp. interested
in Chef and Ruby best practices feedback ron.bogdanoff@gmail.com

The Future
==========

* get this to work with bigtop 0.6.0
* add testing
* test all bigtop component installations
* create recipe for bigtop build VM
* create recipe for a cluster
* add support for other platforms (debian)
* add support for AWS provider (vagrant stuff)
* ?


# Author

Author:: Ron Bogdanoff (ron.bogdanoff@gmail.com)
