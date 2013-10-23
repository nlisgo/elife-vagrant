# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # need to add apache to the synced folder via
  config.vm.synced_folder "./public", "/opt/public", id: "vagrant-root", :owner => "www-data", :group => "www-data"

  # this expects the drupal-site-jnl-elife git repository checked out in the same parent folder
  config.vm.synced_folder "../drupal-site-jnl-elife", "/shared/elife_module"


  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "pre64-elife-rb1.9-chef-11"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
     vb.customize ["modifyvm", :id, "--memory", "1024"]
     vb.customize ["modifyvm", :id, "--vram", "12"]
  end

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # new syntax is now
  config.vm.network :private_network, ip: "192.168.33.44"

  config.vm.provision "chef_solo" do |chef|

    # the receipe that we are basing this build off of
    # installs the following: 
    # - varnish 
    # - memcaced
    # as this is for a purely dev install, we are going to ignore these for now. 

    # define where things have been collected together by librarian-chef
    chef.cookbooks_path = ["cookbooks"]
    chef.roles_path = ["roles"]

    # this installs most of the infrastrucutre required to support a drupal instance
    chef.add_recipe "apt" # add this so we have updated packages available
    chef.add_recipe "git"
    # chef.add_recipe "openvpn"  # vpn to highwire needed, but using tunnelblick on mac host instead.

    # This role represents our default Drupal development stack.
    chef.add_role   "drupal_lamp_varnish_dev"
    chef.add_recipe "drupal-site-jnl-elife-cookbook"

    # Pulled out so it's obvious: disable content delivery as it won't work for non-live sites
    chef.add_recipe "drupal-site-jnl-elife-cookbook::disable-cdn"

    # we set these attrbutes, and in particular the mysql root passwors
    # as in chef solo we don't have access to a chef server
    chef.json = {
      "git_root" => "/opt/public",
      "www_root" => "/opt/public/drupal-webroot",
      "hosts" => {
        "localhost_aliases" => ["elife.vbox.local"]  # used in drupal_apps recipe
      },
      "drupal" => {
        "site_name" => "elife.vbox.local",
        "shared_folder" => "/vagrant/public",
        "drupal_sqlfile" => "jnl-elife.sql",         # expects .sql.gz file in shared_folder
      },
      "mysql" => {
        "server_database" => "jnl_elife",
        "server_root_userid" => "admin",
        "server_root_password" => "admin",
		    "server_repl_password" => "",
		    "server_debian_password" => "root",
		    "elife_user_password" => "elife"
	    }
    }   

  end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 80, host: 8080


  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

end
