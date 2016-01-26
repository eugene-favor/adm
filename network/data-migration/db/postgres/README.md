
Migrate database from source server to destination server

On source server
```
sudo -u postgres pg_dump source_db | psql -h destination.server.com -U DB_USER destination_db  #(Promt pass - DB USER PASSWORD postgres
```
