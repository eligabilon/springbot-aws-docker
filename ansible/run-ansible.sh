#!/bin/bash

echo "Starting ansible..."
#server para nao pedir acesso no ssh ao logar
ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ../terraform/hosts --private-key ../terraform/key/beerstore_key beerstore-playbook.yml -v