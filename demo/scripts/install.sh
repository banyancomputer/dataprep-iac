#!/usr/bin/env bash

. env/env.user
. env/env.git

# A helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_CALLBACKS_ENABLED=profile_tasks
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$USER" \
  -e "root_path=$ROOT_PATH" \
  -e "dataprep_repo=$DATAPREP_REPO" \
  -e "dataprep_branch=$DATAPREP_BRANCH" \
  ./ansible/install.yml