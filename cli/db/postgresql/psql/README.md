
Execute query from command line from file

```
psql -U some_user -d some_database -h 127.0.0.1 -f some_table.sql -W

```

Execute query from command line to csv

```
psql -d forum -t -A -F"," -c "select * from users" > output.csv

```