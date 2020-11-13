#!/bin/sh

# remove "-C" when you want to apply
ansible-playbook -i inventories/hosts -C --ask-become-pass rui.yml