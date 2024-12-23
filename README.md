# Jenkins Master to Slave Connection Using SSH Authentication

This repository demonstrates how to create a Jenkins Master to Slave connection using SSH authentication (Public and Private keys). The following steps outline the setup, customization, and configuration required to establish the connection and test Jenkins functionality.

---

## Setup Overview

1. **Customized Jenkins Docker Image (CASC Configuration)**:
   - We have created a customized Jenkins Docker container using a `Dockerfile` that builds a Jenkins image with the Configuration as Code (CASC) plugin, OpenJDK 17, and essential default Jenkins plugins.

2. **Docker Compose Setup**:
   - We have used Docker Compose to run our Jenkins container seamlessly with all necessary configurations.

3. **SSH Authentication for Master-Slave Communication**:
   - The repository also demonstrates how to configure an Ubuntu host to accept the SSH connection from the Jenkins master to the slave using public and private keys for authentication.

4. **Testing Jenkins on Port 8082**:
   - After setting up the master-slave connection and required configurations, Jenkins is accessible on port 8082 for testing and deployment.

---

## Prerequisites

Before running the setup, make sure you have the following installed:

- **SSH**: [Install SSH Server on slave](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- **Docker**: [Install Docker](https://docs.docker.com/get-docker/)
- **Docker Compose**: [Install Docker Compose](https://docs.docker.com/compose/install/)
- **Git**: [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

---

## Steps to Set Up

### 1. **Building the Custom Jenkins Docker Image**

We have created a `Dockerfile` to build a customized Jenkins image with the following features:

- **OpenJDK 17** for Java 17 support.
- **Default Jenkins plugins** like `configuration-as-code`, `git`, `workflow-aggregator`, and others for basic Jenkins functionality.

To build the custom Jenkins Docker image, run the following command:

```bash
docker build -t jenkins-casc:jv18 .
```
### 2. **Configure the Jenkins Master and Node(Slave)**

To generate SSH public and private keys on master machine, run the following command:

```bash
ssh-keygen -t rsa -b 2048 -f jenkins_master_key -N ""
```
Then, **the following steps**:
1) Create a jenkins user and add it to the sudoers group, using the following command:
```bash
sudo usermod +aG sudo Jenkins
```
2) Copy the public key (jenkins_master_key.pub) into the authorized_keys in the slave machine at
(/home/jenkins/.ssh/authorized_keys) and add permissions to it, using the following command:
```bash
sudo chmod 700 -R ~/.ssh
```
3) Go to the master jenkins running on the master machine and add the agent/node with the appropriate credentials, which you will need to use the generated private key of the master machine (jenkins_master_key).

4) Watch the generated logs after launching the agent from the Jenkins dashboard to observe any errors.
