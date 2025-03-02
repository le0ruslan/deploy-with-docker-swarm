# -*- mode: ruby -*-
# vi: set ft=ruby :

# Подключение к стороннему репозиторию
ENV['VAGRANT_SERVER_URL'] = 'https://vagrant.elab.pro'

Vagrant.configure("2") do |config|
  # Машина manager01
  config.vm.define "manager01" do |manager01|
    # Название образа
    manager01.vm.box = "ubuntu/jammy64"
    # Отключение проверки обновлений в репозитарии
    manager01.vm.box_check_update = false
    # Название машины
    manager01.vm.hostname = "manager01"
    # Настройка сетевого адаптера
    manager01.vm.network "private_network", ip: "192.168.56.11"
    manager01.vm.network "forwarded_port", guest: 8081, host: 8081
    manager01.vm.network "forwarded_port", guest: 8087, host: 8087
    #Конфигурация ресурсов
    manager01.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = "1"
    end

        
    # Синхронизация папок
    manager01.vm.synced_folder ".", "/home/vagrant/"

    # Копирование скриптов и docker-compose.yml
    manager01.vm.provision "file", source: "./deploy_manager.sh", destination: "/home/vagrant/deploy_manager.sh"
    manager01.vm.provision "file", source: "./docker-compose.yaml", destination: "/home/vagrant/docker-compose.yaml"
    manager01.vm.provision "file", source: "./.env", destination: "/home/vagrant/.env"
    manager01.vm.provision "file", source: "./nginx.conf.template", destination: "/home/vagrant/nginx.conf.template"

    # Запуск инициализации Swarm
    $script = <<-SCRIPT
      chmod +x /home/vagrant/deploy_manager.sh
      bash /home/vagrant/deploy_manager.sh
    SCRIPT
   
    manager01.vm.provision "shell", inline: $script, privileged: false

  end

  # Машина worker01
  config.vm.define "worker01" do |worker01|
    worker01.vm.box = "ubuntu/jammy64"
    worker01.vm.box_check_update = false
    worker01.vm.hostname = "worker01"
    worker01.vm.network "private_network", ip: "192.168.56.12"
    worker01.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = "1"
    end

    # Синхронизация папок
    worker01.vm.synced_folder ".", "/home/vagrant/"

    worker01.vm.provision "file", source: "./deploy_worker.sh", destination: "/home/vagrant/deploy_worker.sh"
    
    $script = <<-SCRIPT
      # Ждем появления файла swarm_token.txt
      while [ ! -f /home/vagrant/swarm_token.txt ]; do
        sleep 2
      done

      chmod +x /home/vagrant/deploy_worker.sh
      bash /home/vagrant/deploy_worker.sh
    SCRIPT
 
    worker01.vm.provision "shell", inline: $script, privileged: false
        

  end

  # Машина worker02
  config.vm.define "worker02" do |worker02|
    worker02.vm.box = "ubuntu/jammy64"
    worker02.vm.box_check_update = false
    worker02.vm.hostname = "worker02"
    worker02.vm.network "private_network", ip: "192.168.56.13"
    worker02.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = "1"
    end
    
    # Синхронизация папок
    worker02.vm.synced_folder ".", "/home/vagrant/"

    worker02.vm.provision "file", source: "./deploy_worker.sh", destination: "/home/vagrant/deploy_worker.sh"

    $script = <<-SCRIPT
    # Ждем появления файла swarm_token.txt
      while [ ! -f /home/vagrant/swarm_token.txt ]; do
        sleep 2
      done

      chmod +x /home/vagrant/deploy_worker.sh
      bash /home/vagrant/deploy_worker.sh
    SCRIPT

    worker02.vm.provision "shell", inline: $script, privileged: false

  end
end
