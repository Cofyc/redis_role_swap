# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  #config.vm.box     = "CentOS-6.3-x86_64-minimal"
  config.vm.box = "centos6.5"
  #config.vm.box_url = "https://dl.dropbox.com/u/7225008/Vagrant/#{config.vm.box}.box"
  config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v6.5.3/centos65-x86_64-20140116.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  #config.vm.boot_mode = :gui


  #
  # Targets
  #
  config.vm.define :redis1 do |target_config|
    target_config.vm.host_name = 'test-redis-1'
    target_config.vm.network :hostonly, "192.168.50.31"
    target_config.vm.provision :shell, :path => 'vagrant/setup.sh', :args => "master"
  end

  config.vm.define :redis2 do |target_config|
    target_config.vm.host_name = 'test-redis-2'
    target_config.vm.network :hostonly, "192.168.50.32"
    target_config.vm.provision :shell, :path => 'vagrant/setup.sh', :args => "slave"
  end
end

