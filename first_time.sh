#!/bin/sh

vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-omnibus

vagrant up --provision
vagrant halt
vagrant up --provision
