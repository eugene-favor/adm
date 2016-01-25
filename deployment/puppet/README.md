Install agent

```
apt-get install puppet
```

and

edit /etc/puppet/puppet.conf

```
[main]
logdir=/var/log/puppet
vardir=/var/lib/puppet
ssldir=/var/lib/puppet/ssl
rundir=/var/run/puppet
factpath=$vardir/lib/facter
templatedir=$confdir/templates
prerun_command=/etc/puppet/etckeeper-commit-pre
postrun_command=/etc/puppet/etckeeper-commit-post

[master]
## These are needed when the puppetmaster is run by passenger
## and can safely be removed if webrick is used.
ssl_client_header = SSL_CLIENT_S_DN
ssl_client_verify_header = SSL_CLIENT_VERIFY

[agent]
server=masterpuppert.somedomain.com
```

Get sertificate from master puppet at agent node

```
puppet agent --test --waitforcert=30
```
Sign sertificate at puppet master

```
puppet cert list

"someagent.somedomain.com" (D7:1F:30:BE:EB:3D:26:88:36:A8:8B:64:B7:08:A2:6A)
```

```
puppetca --sign someagent.somedomain.com
```

If hostname of node changes -

clean nodes from master

```
puppet node clean someagent.somedomain.com
```

and remove certs and certs requests from agent

```
rm /var/lib/puppet/ssl/certs/someagent.somedomain.com.pem
rm /var/lib/puppet/ssl/certificate_requests/someagent.somedomain.com.pem
```