#!/bin/bash
# yum install -y git
# git clone https://github.com/penguinbeam/ansible_mysql-cluster-allinone.git
# cd ansible_mysql-cluster-allinone/
# /bin/bash ansible_mysql-cluster-allinone/bootstrap.sh 

yum install -y epel-release
yum install -y ansible
ansible-playbook -i hosts.ini mysql-cluster.yaml