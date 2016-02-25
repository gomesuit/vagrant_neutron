# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.synced_folder ".", "/home/vagrant/sync", disabled: true
  config.vm.box = "centos/7"

  #config.vm.network :forwarded_port, guest: 80, host: 80

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  config.vm.define "neutron" do |host|
    host.vm.hostname = "neutron"
    #host.vm.network "private_network", ip: "192.168.33.50"
    host.vm.provision :shell, :path => "provision.sh"
  end
  
end
