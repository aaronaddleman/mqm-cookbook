# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'chef'
require 'json'

Chef::Config.from_file(File.join(File.dirname(__FILE__), '.chef', 'knife.rb'))

vagrant_json = JSON.parse(Pathname(__FILE__).dirname.join('nodes', (ENV['NODE'] || 'sender.json')).read)

Vagrant.configure(2) do |config|
  # config.vm.box = "."
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"
  # config.vm.synced_folder "../data", "/vagrant_data"

  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
  
    # Customize the amount of memory on the VM:
    #vb.memory = "2048"
  end

  config.vm.define :mq_sender_centos_65 do |desktop|
    desktop.vm.box = "chef/centos-6.5"

    desktop.vm.provision :chef_solo do |chef|
      chef.log_level = :debug
      chef.cookbooks_path = Chef::Config[:cookbook_path]
      chef.roles_path = Chef::Config[:role_path]
      chef.data_bags_path = Chef::Config[:data_bag_path]

      chef.environments_path = Chef::Config[:environment_path]
      #chef.environment = ENV['ENVIRONMENT'] || 'development'
      chef.environment = 'development'
      chef.add_role("sender")

      #chef.encrypted_data_bag_secret_path = Chef::Config[:encrypted_data_bag_secret]
      #chef.run_list = vagrant_json.delete('run_list')
    end

  end

  config.vm.define :mq_centos_65 do |desktop|
    desktop.vm.box = "chef/centos-6.5"
  end

  config.vm.define :mq_centos_70 do |desktop|
    desktop.vm.box = "chef/centos-7.0"
  end

end
