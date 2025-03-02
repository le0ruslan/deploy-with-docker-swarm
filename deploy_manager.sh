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
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Добавление пользователя vagrant в группу docker
sudo usermod -aG docker vagrant


# Установка Docker Compose (если не установился через docker-compose-plugin)
DOCKER_COMPOSE_VERSION="2.32.2"
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Установка прав для выполнения
sudo chmod +x /usr/local/bin/docker-compose

# Применение новых прав без перезапуска
newgrp docker <<SCRIPT
# Инициализация Docker Swarm
docker swarm init --advertise-addr 192.168.56.11

# Сохранение токена для добавления worker-узлов
sudo docker swarm join-token -q worker > /home/vagrant/swarm_token.txt
SCRIPT
