
# About

This repo contains the provisioning information for setting up a dev environment for building a local copy of [drupal-site-jnl-elife](https://github.com/elifesciences/drupal-site-jnl-elife).

It is being built on top of the [drupal - vagrant project](https://drupal.org/project/vagrant), with the configuration moved to v2 of the vagrant API, and using librarian and chef for managing cookbooks.


# Setup

To setup your system to work with Vagrant and Chef please follow the guide provided at [elife-template-env](https://github.com/elifesciences/elife-template-env).

You are advised to setup and use the elife specified base box described in that guide, as it contains a base box configured with the required versions of chef, php and vagrant. If you don't have it setup already, you can add this box with the command:

	$ vagrant box add pre64-elife-rb1.9-chef-11
http://cdn.elifesciences.org/vm/pre64-elife-rb1.9-chef-11.box

# Quickstart

	$ git clone git@github.com:elifesciences/elife-vagrant.git
	$ cd elife-vagrant
	$ librarian-chef install
	$ vagrant up
	$ vagrant ssh

# What it does

Cookbooks are installed using librarian. Check the `Cheffile` to see which cookbooks we donwnlad as community cookbooks, and which ones we have made private instances of. (Creating a private instance of a cookbook is an anti-pattern, however for our immediate purposes, this is OK).

Librarian also installs the git repo for the elife specific drupal modules and themes. 

This git repo includes the `roles` provided by the drupal vagrant proejct. These have been modified to not install varnish or memcached. This was done out of convinience. 

This git repo contains a placeholder `public` directory. This is the directory that is used to serve our drupal site out of.


## elife journal drupal code

- [drupal-site-jnl-elife][eldcode] - the source code for the elife drupal site
- [drupal-site-jnl-elife-env][eldprovision] - Vagrant and Cheffile for building the vm
- [drupal-site-jnl-elife-cookbook][eldcook] - Chef cookbook called by Cheffile for building the dev environment

[eldcode]: https://github.com/elifesciences/drupal-site-jnl-elife
[eldprovision]: https://github.com/elifesciences/drupal-site-jnl-elife-env
[eldcook]: https://github.com/elifesciences/drupal-site-jnl-elife-cookbook

## Issues with the Drupal Install

## TODO

- netowrking is not working, so after install you can't actually see drupal running on the vm

- the roles are a little over complicated, these should be simplified

- `cookbooks/drupal/recipes/drupal_apps.rb` has been modified to not check whether the key `#if node["hosts"].has_key("localhost_aliases")` exists. Probably an updated issues with Ruby, should check, and re-imliment

- apc has been turned off, as getting it to install via chef was beyond me.

- contribute back fixes to the main vagrant-drupal project, and stop holiding a private version of these cookbooks. 

