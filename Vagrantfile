# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "pristine/ubuntu-budgie-18-x64"

  #config.vm.box = "relativkreativ/ubuntu-18-minimal"
  #config.vm.box = "generic/ubuntu1810"
  #config.vm.box = "geerlingguy/ubuntu1804"
  
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network", bridge: "en5: USB Ethernet(?)"
  # config.vm.network "public_network", bridge: "en7: USB 10/100/1000 LAN"
  config.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
    v.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
  end
  

  # master
  config.vm.define :master do |node|
    node.vm.hostname = "master"
    node.vm.network :private_network, ip: "10.0.0.10"
    node.vm.provision "shell", path: "hadoop-install.sh"
    node.vm.provision "shell", path: "master-config.sh"
  end
  
  # node01
  config.vm.define :node01 do |node|
    node.vm.hostname = "node01"
    node.vm.network :private_network, ip: "10.0.0.11"
    node.vm.provision "shell", path: "hadoop-install.sh"
    node.vm.provision "shell", path: "slave-config.sh"
  end

  # node02
  config.vm.define :node02 do |node|
    node.vm.hostname = "node02"
    node.vm.network :private_network, ip: "10.0.0.12"
    node.vm.provision "shell", path: "hadoop-install.sh"
    node.vm.provision "shell", path: "slave-config.sh"
  end
end
