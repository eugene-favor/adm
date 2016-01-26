Installing Apache APR.

```
scp apr-1.4.6.tar.gz vasja.pupkin@somedomain.someserver.com:/home/vasja.pupkin
tar -xzf apr-1.4.6.tar.gz
sudo apt-get install make
sudo ./configure
sudo make
sudo make install
```

Installing Tomcat Native.

```
scp tomcat-native-1.1.24-src.tar.gz vasja.pupkin@somedomain.someserver.com:/home/vasja.pupkin
tar -xzf tomcat-native-1.1.24-src.tar.gz
cd tomcat-native-1.1.24-src/jni/native/
sudo ./configure --with-apr=/usr/local/apr --with-java-home=$JAVA_HOME
sudo make
sudo make install
echo "export LD_LIBRARY_PATH=\"\$LD_LIBRARY_PATH:/usr/local/apr/lib\"" >> /etc/profile.d/apr.sh
chmod +x /etc/profile.d/apr.sh
```