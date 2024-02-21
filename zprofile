# Emulate sh to load ~/.profile
# (via https://superuser.com/questions/187639/zsh-not-hitting-profile)
emulate sh -c '. ~/.profile'
#emulate sh -c 'source /etc/profile'
