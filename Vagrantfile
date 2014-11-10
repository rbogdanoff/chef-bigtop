# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.define "bigtop" do |bigtop|

    # make sure we have chef installed
    bigtop.omnibus.chef_version = "latest"
    
    bigtop.vm.hostname = "bigtop"
  
    # Every Vagrant virtual environment requires a box to build off of.
    # bigtop.vm.box = "Berkshelf-CentOS-6.3-x86_64-minimal"
    bigtop.vm.box = "opscode-centos-6.4"
  
    # The url from where the 'bigtop.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.
    # bigtop.vm.box_url = "https://dl.dropbox.com/u/31081437/Berkshelf-CentOS-6.3-x86_64-minimal.box"
    bigtop.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_centos-6.4_provisionerless.box"
    # Assign this VM to a host-only network IP, allowing you to access it
    # via the IP. Host-only networks can talk to the host machine as well as
    # any other machines on the same network, but cannot be accessed (through this
    # network interface) by any external networks.
    bigtop.vm.network :private_network, ip: "33.33.33.10"
  
    # Create a public network, which generally matched to bridged network.
    # Bridged networks make the machine appear as another physical device on
    # your network.
  
    # bigtop.vm.network :public_network
  
    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
  
    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    # bigtop.vm.synced_folder "../data", "/vagrant_data"
  
    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    # Example for VirtualBox:
    #
    bigtop.vm.provider :virtualbox do |vb|
    #   # Don't boot with headless mode
    #   vb.gui = true
    #
    #   # Use VBoxManage to customize the VM. For example to change memory:
      vb.customize ["modifyvm", :id, "--memory", "2048"]
    end
    #
    # View the documentation for the provider you're using for more
    # information on available options.
    # aws provider - when you use --provider=aws from command line
    bigtop.vm.provider :aws do |aws, override|
      aws.access_key_id = ""
      aws.secret_access_key = ""
      aws.instance_type = "m1.medium"
      aws.region = "us-west-2"   #Oregon
      aws.region_config "us-west-2" do |region|
        region.ami = "ami-c00d80f0"
        region.keypair_name =  ""
      end
      aws.user_data = "#!/bin/bash\necho 'Defaults:ec2-user !requiretty' > /etc/sudoers.d/999-vagrant-cloud-init-requiretty && echo 'Defaults:root !requiretty' >> /etc/sudoers.d/999-vagrant-cloud-init-requiretty && chmod 440 /etc/sudoers.d/999-vagrant-cloud-init-requiretty && sleep 10"
      aws.instance_ready_timeout = 360
      aws.tags = {
        'Name' => 'Bigtop'
      }
      override.ssh.username = "ec2-user"
      override.ssh.private_key_path = ""
    end
  
    # bigtop.ssh.max_tries = 40
    # bigtop.ssh.timeout   = 120
  
    # The path to the Berksfile to use with Vagrant Berkshelf
    # bigtop.berkshelf.berksfile_path = "./Berksfile"
  
    # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  
    # option to your ~/.vagrant.d/Vagrantfile file
    bigtop.berkshelf.enabled = true
  
    # An array of symbols representing groups of cookbook described in the Vagrantfile
    # to exclusively install and copy to Vagrant's shelf.
    # bigtop.berkshelf.only = []
  
    # An array of symbols representing groups of cookbook described in the Vagrantfile
    # to skip installing and copying to Vagrant's shelf.
    # bigtop.berkshelf.except = []
  
    bigtop.vm.provision :chef_solo do |chef|
      chef.json = {
        # bigtop.user => "ec2-user"
      }
  
      chef.run_list = [
          "recipe[bigtop::default]"
      ]
    end
  end
end
