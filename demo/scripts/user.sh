#!/usr/bin/env bash

. env/env.user

# Get the user name from the first argument
USER=$1
# Get the path to the ssh-pub-key from the first argument
export USER_SSH_PUB_KEY_PATH=$2

# A helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_CALLBACKS_ENABLED=profile_tasks
# `admin` is the default admin name.
# If the user name is `admin`, then we must use `root` to administer it.
if [ "$USER" = "admin" ]; then
  export ADMIN_USER=root
else
  export ADMIN_USER=admin
fi
# Create the user with the specified ssh-pub-key, name, and admin status
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$ADMIN_USER" \
  -e "user_name=$USER" \
  -e "user_ssh_pub_key_path=$USER_SSH_PUB_KEY_PATH" \
  ./ansible/admin/user.yml