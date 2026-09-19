# Configuration Management using Ansible
This is a project from roadmaps for configuration management using ansible and can be found here:

https://roadmap.sh/projects/configuration-management

## Requirements:
Use a Linux server from a previous project, like one running on AWS or Digital Ocean.

Use an Ansible playbook to setup the Linux server.
- playbook name: setup.yml
- playbook roles:
  - base
    - basic server setup to install utilities, update the server, installs fail2ban, etc
  - nginx
    - installs and configures nginx
  - app
    - upload tarball of a static HTML website
    - unzip the tarball
  - ssh
    - add a given public key to the server
- inventory
  - name: inventory.yml
  - include the server you are going to configure

The playbook should run each of the roles in the above order/sequence.

The playbook should have tags so each role can run individually

## Stretch goal
Modify app to pull the app from GitHub and deploy it

## Get the project
Clone the project
```bash
git clone git@github.com:jjk66/configuration-management.git
cd configuration-management
```

## Configure inventory group vars
The ansible playbooks utilize inventory group vars to populate the inventory file, ansible user, and ssh pem file to use.

### Easily update your IP Address and Private key
After your instance is running, obtain your instances IP address and ssh pem file. You will need to pass this infomation into the provided tool to update the group vars file (named aws) with your desired values.

```bash
./tools/update-group-vars.sh <your Linux host IP address> <your ssh public key>
```

### Other Variable adjustments
If you desire more or less base application on your Linux server, ajust the base_utilities array found in `./ansible/inventory/group_vars/aws.yml` file.
Either delete or add applications to this list, following the same format.

## Base configuration
Run the ansible playbook base to update the instance with desired base content
```bash
ansible-playbook ./ansible/setup.yml -i ./ansible/inventory/inventory.yml --tags base
```

## Setup nginx web server
Run the ansible playbook to configure and start nginx web server
```bash
/ansible-playbook ./ansiblesetup.yml -i ./ansible/inventory/inventory.yml --tags nginx
```

## Setup SSH
Run the ansible playbook to setup SSH access to the Linux server
```bash
ansible-playbook ./ansible/setup.yml -i ./ansible/inventory/inventory.yml --tags ssh
```

## Install your web application
Run the ansible playbook to install your archived web application to the Linux server
```bash
ansible-playbook ./ansible/setup.yml -i ./ansible/inventory/inventory.yml --tags app
```