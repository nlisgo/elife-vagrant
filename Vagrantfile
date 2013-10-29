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

  # Install latest version of Chef
  config.omnibus.chef_version = :latest

  config.vm.provider :aws do |aws, override| 

    override.vm.box = "dummy"

    # Ian
    aws.access_key_id = "AKIAIEZCVFDGHB2QOVVA" 
    aws.secret_access_key = "faYcyTxTWb8vbusQdoSSaDh3StdTeK8J8/al+Rjp"
    aws.keypair_name = "ianm-working"
    override.ssh.private_key_path = "~/.ssh/ianm-working.pem"

    # Ruth
    aws.access_key_id = "AKIAI7RAXI5EZGOQX2OA" 
    aws.secret_access_key = "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"
    aws.keypair_name = "ruth"
    override.ssh.private_key_path = "~/.ssh/ruth.pem"

    # You cannot pass any parameter to vagrant. The only way is to use environment variables
    # MY_VAR='my value' vagrant up
    # And use ENV['MY_VAR'] in recipe.
    # aws.access_key_id = ENV['AWS_SECRET'] 
    # aws.secret_access_key = ENV['AWS_KEY']

    aws.instance_type = "t1.micro"
    aws.security_groups = "default"

    aws.ami = "ami-de0d9eb7" 
    aws.region = "us-east-1" 

    override.ssh.username = "ubuntu" 
    aws.tags = {
      'Name' => 'Elife Vagrant',
     }

  end 

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider :virtualbox do |vb|
    # Boot in headless mode
    vb.gui = false
    #
    # # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--vram", "12"]
  end

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # new syntax is now
  config.vm.network :private_network, ip: "192.168.33.44"

  config.vm.provision "chef_solo" do |chef|

    # define where things have been collected together by librarian-chef
    chef.cookbooks_path = ["cookbooks"]
    chef.roles_path = ["roles"]

    # Set this to :debug if you want more debugging info, else :info or :warn
    chef.log_level = :info

    # this installs most of the infrastrucutre required to support a drupal instance
    chef.add_recipe "apt" # add this so we have updated packages available
    chef.add_recipe "git"
    # chef.add_recipe "openvpn"  # vpn to highwire needed, but using tunnelblick on mac host instead.

    # This represents our default Drupal development stack.
    chef.add_recipe "elife-drupal-cookbook::drupal_lamp_dev"

    # site and SQL files for our Drupal site
    chef.add_recipe "drupal-site-jnl-elife-cookbook::default"

    # Pulled out so it's obvious: disable content delivery as it won't work for non-live sites
    chef.add_recipe "drupal-site-jnl-elife-cookbook::disable-cdn"

    # we set these attrbutes, and in particular the mysql root passwors
    # as in chef solo we don't have access to a chef server
    chef.json = {
      "git_root" => "/opt/public",                # directory containing webroot in which drupal repos fetched
      "www_root" => "/opt/public/drupal-webroot", # location of drupal webroot. Not really configurable!
                                                  # because dir is git_root and name is the drupal-webroot git
                                                  # repo folder name.
      "apache" => {
        "listen_ports" => [ "80", "8080" ],         # list of ports to listen on, e.g. [ "80", "8080"]
      },
      "drupal" => {
        "site_name" => "elife.vbox.local",        # a single name by which the server is known
        "site_aliases" => [],                     # used in web_app recipe, alternate names for server
        "shared_folder" => "/vagrant/public",     # in-VM folder used to mount .../elife-vagrant/public
        "drupal_sqlfile" => "jnl-elife.sql",      # Base filename of SQL database dump. gzip compressed as ".gz" 
      },
      "mysql" => {
        "server_database" => "jnl_elife",         # the name of the database. Must match settings.php
        "server_root_userid" => "admin",          # database admin userid
        "server_root_password" => "admin",        # database admin password
        "server_repl_password" => "",             # ... not used
        "server_debian_password" => "root",       # ... not used
        "elife_user_password" => "elife",         # ... not used
      },
      "elifejnl" => {
        "hiwire_rev" => "7.x-1.x-dev",            # revision of highwire module to fetch
        "webroot_rev" => "7.x-1.x-dev",           # revision of webroot module to fetch
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
