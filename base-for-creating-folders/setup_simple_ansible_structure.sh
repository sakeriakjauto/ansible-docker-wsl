#!/bin/bash

# Base directory
BASEDIR=ansible-docker-wsl

# Create necessary directories
mkdir -p $BASEDIR/inventory
mkdir -p $BASEDIR/roles/docker/tasks

# Create inventory file
echo "[local]
localhost ansible_connection=local" > $BASEDIR/inventory/hosts.ini

# Create Docker role tasks
echo "---
- name: Install Docker
  apt:
    name: docker-ce
    state: present
    update_cache: yes
    force: yes" > $BASEDIR/roles/docker/tasks/main.yml

# Create main playbook
echo "---
- hosts: local
  become: yes
  roles:
    - docker" > $BASEDIR/install_docker.yml

# Create Ansible configuration
echo "[defaults]
inventory = inventory/hosts.ini
remote_user = root
host_key_checking = False
retry_files_enabled = False" > $BASEDIR/ansible.cfg

echo "Simplified Ansible project structure created successfully!"
