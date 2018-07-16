# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian/stretch64"
  config.vm.network :private_network, ip: "192.168.33.39"
  #config.ssh.insert_key = true
  #config.ssh.private_key_path = "/home/martin/.ssh/docs"
  config.ssh.forward_agent = true

  # Fail if vagrant-vbguest if not installed.
  # vagrant plugin install vagrant-vbguest
  unless Vagrant.has_plugin?('vagrant-vbguest')
    raise 'vagrant-vbguest not installed!'
  end

  # Fail if vagrant-hostmanager if not installed.
  # vagrant plugin install vagrant-hostmanager
  unless Vagrant.has_plugin?('vagrant-hostmanager')
    raise 'vagrant-hostmanager not installed!'
  end

  # Customize the hostsmanager ip_resolver
  # to properly retrieve the ip address from the guest.
  config.hostmanager.ip_resolver = proc do |machine|
    result = ""
    machine.communicate.execute("ip addr | grep 'dynamic' | tail -1") do |type, data|
      result << data if type == :stdout
    end
    (ip = /inet (\d+\.\d+\.\d+\.\d+)/.match(result)) && ip[1]
  end

  # Configure the vagrant-hostmanager plugin
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true

  # Disable the automatic update of the virtualbox guest additions
  config.vbguest.auto_update = false

  # Disable automatic box update checking.
  config.vm.box_check_update = false

  config.vm.hostname = "test-1"
  config.vm.provider :virtualbox do |v|
    v.name = "test-1"
    v.memory = 1024
    v.cpus = 2
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  # Enable provisioning with Ansible.
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbooks/common.yml"
    ansible.become = true
  end
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbooks/mariadb.yml"
    ansible.become = true
  end
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbooks/ox.yml"
  end

end

