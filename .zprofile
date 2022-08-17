# In case the user is using zsh as default shell, load .profile
[ -f "~/.profile" ] && emulate sh -c '. ~/.profile'
