
dump data

```
mongodump --host localhost --port 27017 --out /backups/somedomain.com/mongo
```

restore from dump

To use mongorestore to connect to an active mongod or mongos, use a command with the following prototype form:

```
mongorestore --port <port number> <path to the backup>
```

To use mongorestore to write to data files without using a running mongod, use a command with the following prototype form:

```
mongorestore --dbpath <database path> <path to the backup>
```

Consider the following example:

```
mongorestore /backups/somedomain.com/mongo
```