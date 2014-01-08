# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'
require 'berkshelf/vagrant'

chef_configuration = JSON.parse(Pathname(__FILE__).dirname.join('.', 'chef.json').read)

Vagrant.configure("2") do |config|
  config.berkshelf.enabled = true
  config.omnibus.chef_version = '11.8.0'
  config.vm.box = 'precise64'
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 1024]
  end
  config.vm.network :forwarded_port, guest: 80, host: 80, auto_correct: true
  config.vm.synced_folder './../BEBPP0008_University_Moodle', '/home/apps/moodle/current', :create => true
  config.vm.synced_folder '~/.ssh/', '/ssh/'
  config.vm.provision :shell, :path => 'configure.sh'
  config.vm.provision :chef_solo do |chef|
    chef.json = chef_configuration
  end
end
