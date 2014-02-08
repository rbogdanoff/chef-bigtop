chef-bigtop
===========

[![Built on Travis](https://secure.travis-ci.org/rbogdanoff/chef-bigtop.png)](http://travis-ci.org/rbogdanoff/chef-bigtop)

Fixes in 0.1.2
==============
Use Berkshelf 3.x (still in beta) as Berkshelf 2 has issues and broke this cookbook
(related to how it was resolving the Java cookbook dependency)
See https://github.com/berkshelf/berkshelf hopfully Berkshelf 3 will move to rubygems.org soon

New Gemfile.lock - forgot to check it in last time.  This was causing some test failures

Fix a bug user_hdfs execute - related to a couple of yarn hdfs dirs that were missing

Had to disable rubocop - it's not working, it's probably a gem compatibily issue, will
fix next release

Description
===========

This cookbook installs Apache Bigtop http://bigtop.apache.org/
using Vagrant onto a single VM.  You can use this as a 'sandbox'
for hadoop to try it out.  This is NOT a 'production' cookbook!!

current bigtop version being used is 0.7.0

This is not for 'production':
this is for learning/testing/developing hadoop ecosystem/bigtop.  Vagrant is being used
to provided a virtualized environment for this use case.  As with all Vagrant, the use case
is NOT 'production' i.e. Vagrant is a development/testing tool...You typically will do `vagrant destroy`
on occasion to wipe out your vagrant box that you may have hacked, and create a clean one again.  So...
don't put data into your Vagrant VM that you want to permanently keep!!!  If you want to do this,
you should keep that data external to your vagrant VM and load it with a script post creating a new vagrant VM.

Currently, this is a 'single server' install.  TODO: soon there will be a (small) cluster install too!!! 

By default, it will install hadoop hdfs as this is all that I have
tested thus far.  If you want to install the other components (e.g. hive, hbase, pig, mahout, etc.)
see `attributes/default.rb` it should be obvious what to do

This cookbook essentially does what is described at https://cwiki.apache.org/confluence/display/BIGTOP/How+to+install+Hadoop+distribution+from+Bigtop+0.6.0   

Requirements
============

### what you need

* Ruby 1.9.x 
* the bundle gem  
  `gem install bundle`
* Vagrant 1.4.1+ (www.vagrantup.com) - If you have not used Vagrant before, check out their short 'get started' tutorial.
* VirtualBox 4.3.4 
* the vagrant plugin vagrant-omnibus
  `vagrant plugin install vagrant-omnibus`
* the vagrant plugin vagrant-berkshelf
  `vagrant plugin install vagrant-berkshelf`

* then cd to where you cloned this repository (where the file Gemfile is located), apply the Gemfile.  
  `bundle install`
  
* A VM will be created on your machine with the hostname of 'bigtop' and an ip number of 33.33.33.10.  Add this line to your /etc/hosts file
  `33.33.33.10     bigtop`  
  
# Usage - 'how do I run this thing?'
You now should be set to go.  cd to the top level directory (where Vagrantfile is located) and start the vagrant box
  `vagrant up`
  
The first time this will take several minutes as the VM image (the box) needs to download.

When vagrant up has completed  you can ssh into the VM
  `vagrant ssh`
  
Then, to test that hadoop is running, try to run the pi test mapreduce job
  `hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar pi 10 1000`

## AWS
There is basic AWS support.  You you want to run on EC2 instead of your desktop, do this...
* Edit Vagrantfile and change the following parameters
`aws.access_key_id = "YOUR ACCESS KEY"`
`aws.secret_access_key = "YOUR SECRET KEY"`
`override.ssh.private_key_path = "YOUR FULL PATH TO YOUR KEY FILE"`

* then you can `vagrant up --provider=aws`
* NOTE: vagrant only supports up,ssh,provision,destroy and NOT halt,reload so you will need to stop/start with AWS console once you vagrant up
  
### Chef Usage
* TODO: show example of run_list and chef.json attribute override usage

## Platform
* CentOS6  (more on the way)

# Attributes

See `attributes/default.rb` for default values.

* `node['bigtop']['components']`  list of bigtop components to install
* `node['bigtop']['version']` bigtop version to install - 0.7.0 is the default

# Recipes

## default
this does it all. just use bigtop::default in your run_list 

All other recipes are private

Development
===========
TODO: Will create recipes for each hadoop component.

Known Issues
============
Default components that get installed are hadoop hdfs.  I have not tested the others, but
I did notice that in a single server install, hbase rest and yarn nodemanger both use port 8080 and this
conflict will break yarn nodemanger service from starting.  Will look into this.

See comments in `recipes\install.rb` for some FIXME and TODOs I have tagged

I want to get rid of the ruby_blocks in install.rb.  It will make the recipe better with less 'notifies'

Please let me know any suggestions/improvements/bug you have.  I am still learning Chef and esp. interested
in Chef and Ruby best practices feedback ron.bogdanoff@gmail.com

The Future
==========

* separate recipes for each hadoop component (hdfs, hbase, hive, etc.)
* test all bigtop component installations
* create recipe for a 'bigtop development' VM - used if you want to do dev on bigtop itself
* create recipe for a cluster
* add support for other platforms (debian)
* add support for AWS provider (vagrant stuff)
* ?


# Author

Author:: Ron Bogdanoff (ron.bogdanoff@gmail.com)
