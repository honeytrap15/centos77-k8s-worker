# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # common setting
  config.vm.box = "bento/centos-7.7"
  config.vm.box_check_update = false
  config.vm.synced_folder '.', '/vagrant', disabled: true

  # configure resources
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  # setup private ip address
  config.vm.network "private_network", ip: "192.168.33.10"

  # install utility common package
  config.vm.provision "shell", inline: <<-SHELL
    yum -y install bash-completion bash-completion-extras
  SHELL

  # disable swap
  config.vm.provision "shell", inline: <<-SHELL
    swapoff -a
    sed -i '/swap/d' /etc/fstab
  SHELL

  # put config files
  config.vm.provision "file", source: "./provision", destination: "/tmp/provision"
  config.vm.provision "shell", inline: <<-SHELL
    cp -a /tmp/provision/* /
    rm -rf /tmp/provision
    sysctl --system
  SHELL

  # install docker daemon
  config.vm.provision "shell", inline: <<-SHELL
    yum -y install yum-utils device-mapper-persistent-data lvm2
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    yum -y update && yum -y install docker-ce
    systemctl enable --now docker
    gpasswd -a vagrant docker
  SHELL

  # install k8s for worker
  config.vm.provision "shell", inline: <<-SHELL
    yum install -y kubeadm --disableexcludes=kubernetes
    systemctl enable kubelet
  SHELL

end
