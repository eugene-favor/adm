http://www.bigfastblog.com/gitolite-installation-step-by-step

1) On local machine (administration point):

```
sudo useradd --shell=/bin/bash --user-group --create-home gitolite

ssh-keygen -t rsa -f gitolite
```

2) At new server:

```
sudo adduser \
   --system \
   --shell /bin/bash \
   --gecos 'git version control' \
   --group \
   --disabled-password \
   --home /home/gitolite gitolite
```

3) On local machine (administration point):

```
scp ~/.ssh/gitolite.pub root@11.22.33.44:/home/gitolite/
```

4) At new server:

```
root@localhost:~# sudo su - gitolite

root@localhost:~# sudo chown gitolite:gitolite /home/gitolite/gitolite.pub

gitolite@localhost:~$ git clone git://github.com/sitaramc/gitolite

gitolite@localhost:~$ mkdir bin

gitolite@localhost:~$ gitolite/install -to /home/gitolite/bin

gitolite@localhost:~$ /home/gitolite/bin/gitolite setup -pk gitolite.pub
```

5) On local machine (administration point):

```
gitolite@localhost:~$ vim ~/.ssh/config
```

```
#Host gitbox
#   User gitolite
#   Hostname 11.22.33.44
#   Port 22
#   IdentityFile ~/.ssh/gitolite
```

```
gitolite@localhost:~$ git clone gitbox:gitolite-admin

vasja.pupkin@localhost:~$ sudo cp .ssh/vasja.pupkin.pub ../gitolite/gitolite-admin/keydir

vasja.pupkin@localhost:~$ sudo cp Projects/GIT-ADMIN/update.sh /home/gitolite/gitolite-admin/

vasja.pupkin@localhost:~$ sudo chown gitolite:gitolite ../gitolite/gitolite-admin/keydir/vasja.pupkin.pub

vasja.pupkin@localhost:~$ sudo chown gitolite:gitolite ../gitolite/gitolite-admin/update.sh

gitolite@localhost:~$ cd gitolite-admin

gitolite@vasja.pupkin-Z68M-D2H:~$ vim conf/gitolite.conf
```

```
#@admin      = vasja.pupkin
#
#repo gitolite-admin
#    RW+     =   gitolite @admin
```

6) On local machine (administration point):

copy keys exclude vasja.pupkin and gitolite

```
vasja.pupkin@localhost:~$ mc
```

modify config

```
vasja.pupkin@localhost:~$ vim conf/gitolite.conf
```

7) At old git server


old git address

```
ssh -p 23 vasja.pupkin@55.66.77.88
```

```
rsync -av --progress --del --exclude 'gitolite-admin.git'  /var/cache/git/ root@11.22.33.44:/home/gitolite/repositories/
```
