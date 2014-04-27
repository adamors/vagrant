# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "precise32"
    config.vm.provider "virtualbox" do |v|
        v.memory = 512
        v.cpus = 1
    end
    config.vm.box_url = "http://files.vagrantup.com/precise32.box"
    config.vm.network "private_network", ip: "192.168.56.101"
    config.vm.network :forwarded_port, guest: 80, host: 8080
    config.vm.provision :shell, path: "bootstrap.sh"
    config.vm.synced_folder "../", "/vagrant", type: "nfs"
end
