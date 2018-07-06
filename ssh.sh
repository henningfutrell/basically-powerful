# auto adds keys to ssh
if [[ -z $SSH_AUTH_SOCK && $SSH_ADD_KEYS = '1' ]]; then
  echo "Adding keys to ssh-agent. Your password may be required."
  eval "$(ssh-agent -s)"
  for key in $SSH_KEYS; do
    ssh-add "$SSH_KEY_DIR/$key"
  done
fi
