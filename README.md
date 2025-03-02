# Container Orchestration Basics

## Project Overview

This project explores the fundamentals of container orchestration using **Docker Compose** and **Docker Swarm**. The goal was to deploy and manage a microservices-based application efficiently by leveraging these tools. The project involved setting up multiple Docker containers, configuring a Swarm cluster, and implementing load balancing.

## Contents

1. [Docker Compose Deployment](#docker-compose-deployment)
2. [Virtual Machine Setup](#virtual-machine-setup)
3. [Docker Swarm Cluster](#docker-swarm-cluster)

## Docker Compose Deployment

To orchestrate multiple microservices on a single machine, **Docker Compose** was utilized. The following steps were completed:

- **Dockerfile Creation**: Each microservice was containerized using individual Dockerfiles, ensuring proper dependencies and optimized image sizes.
- **Docker Compose Configuration**: A `docker-compose.yml` file was written to define service interactions, network configurations, and exposed ports.
- **Application Deployment**: The application was successfully deployed using `docker-compose up`, allowing inter-service communication.
- **Testing with Postman**: Predefined Postman test cases were executed to verify the correct functionality of the services.

## Virtual Machine Setup

To simulate a multi-node environment, **Vagrant** was used to create virtual machines:

- **Vagrantfile Configuration**: A `Vagrantfile` was written to automate the setup of a virtual machine.
- **Code Deployment**: The application source code was transferred to the virtual machine’s working directory.
- **Verification**: The virtual machine was accessed via SSH to confirm that the application was correctly placed.

## Docker Swarm Cluster

To achieve container orchestration across multiple nodes, a **Docker Swarm** cluster was configured:

- **Multi-Node Setup**: A modified `Vagrantfile` created three virtual machines (`manager01`, `worker01`, `worker02`).
- **Automated Setup Scripts**: Shell scripts were written to install Docker, initialize the Swarm cluster, and connect worker nodes.
- **Docker Hub Integration**: Application images were pushed to **Docker Hub**, enabling Swarm nodes to pull prebuilt images.
- **Service Deployment**: The `docker stack deploy` command was used to launch the microservices stack.
- **NGINX Reverse Proxy**: Configured to route traffic through an overlay network, making **gateway service** and **session service** accessible only via proxy.
- **Testing & Verification**: Postman tests were executed in the Swarm environment, confirming that the services functioned correctly.
- **Container Distribution Analysis**: Docker commands were used to inspect service distribution across Swarm nodes.
- **Portainer Integration**: Installed **Portainer** within the cluster to provide a graphical interface for monitoring and managing deployed services.

## Conclusion

This project demonstrated the key principles of container orchestration, from running multiple containers with **Docker Compose** to deploying a fully functional **Docker Swarm** cluster. The implementation successfully showcased containerized microservices, automated scaling, and efficient service management, providing a strong foundation for real-world container orchestration scenarios.

