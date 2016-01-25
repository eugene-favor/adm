###Add user

sudo useradd --shell=/bin/bash --user-group --groups=sudo --create-home vasja.pupkin

####or

useradd -g vasja.pupkin.custom-group -c"Vasja Pupkin" -s /bin/bash -m vasja.pupkin


###Add user to group

sudo usermod -a -G vasja.pupkin,vasja.pupkin.custom-group,sudo vasja.pupkin

####Delete user

sudo deluser vasja.pupkin


