#!/bin/bash

# Обновление списка пакетов
sudo apt-get update

# Установка пакетов, необходимых для добавления репозитория по HTTPS
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Добавление ключа GPG официального репозитория Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Добавление репозитория Docker
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Обновление списка пакетов и установка Docker
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Добавление пользователя vagrant в группу docker
sudo usermod -aG docker vagrant

# Подключение к Swarm-кластеру через manager01 (IP 192.168.56.11)
sudo docker swarm join --token $(cat /home/vagrant/swarm_token.txt) 192.168.56.11:2377
