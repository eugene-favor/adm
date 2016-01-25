**Restore compressed backup files**

gunzip < somedbdump.sql.gz | mysql -u somedb -p somedb

**or**

gunzip < somedbdump.sql.gz | mysql -u somedb -p somedb  