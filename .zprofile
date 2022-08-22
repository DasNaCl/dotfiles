# In case the user is using zsh as default shell, load .profile
[ -f "$HOME/.profile" ] && emulate sh -c ". $HOME/.profile"
