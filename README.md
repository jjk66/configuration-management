# Configuration Management using Ansible
This is a project from roadmaps for configuration management using ansible and can be found here:

https://roadmap.sh/projects/configuration-management

## Requirements:
Use a Linux server from a previous project, like one running on AWS or Digital Ocean.

Use an Ansible playbook to setup the Linux server.
- plabook name: setup.yml
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
  - name: inventory.ini
  - include the server you are going to configure

The playbook should run each of the roles in the above order/sequence.

The playbook should have tags so each role can run individually

## Stretch goal
Modify app to pull the app from GitHub and deploy it

