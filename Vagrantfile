# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "boxcutter/ubuntu1604"
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 9000, host: 9000
  config.vm.network "forwarded_port", guest: 29418, host: 29418
  config.vm.network "public_network"


  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
    v.customize ["modifyvm", :id, "--paravirtprovider", "legacy"]
    v.customize ["modifyvm", :id, "--memory", "6144"]
    v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    v.customize ["modifyvm", :id, "--cpus", "4"]
    v.customize ["modifyvm", :id, "--vram", "64"]
    v.customize ["modifyvm", :id, "--nestedpaging", "on"]
		v.customize ["modifyvm", :id, "--nictype1", "virtio"]
  end

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe "apt"
    chef.add_recipe "vim"
    chef.add_recipe "git"
    chef.add_recipe "java"
    chef.add_recipe "maven" 
    chef.add_recipe "gradle" 
    chef.add_recipe "gitblit" 
    chef.add_recipe "jenkins" 

    chef.json = {
      "java" => { 
        "set_etc_enviornment" => true,
        "install_flavor" => "oracle", 
        "jdk_version" => "8",
        "set_default" => true,
        "oracle" => { 
          "accept_oracle_download_terms" => true 
        } 
      }
    }
  end

end
