**Continuous Archiving and Point-in-Time Recovery (PITR)**

1. Настройка бекапов.
Модифицируем postgresql.conf

```
sudo su postgres
nano /etc/postgresql/9.1/main/postgresql.conf
   
```
   
Добавляем строки:

```
archive_mode = on
wal_level = archive
archive_command = 'test ! -f /var/lib/postgresql/9.1/archive/%f && cp %p /var/lib/postgresql/9.1/archive/%f'
max_wal_senders = 2
```  
  
Создаём директорию для хранения WAL:

```
mkdir /var/lib/postgresql/9.1/archive/
chmod 700 /var/lib/postgresql/9.1/archive/
```   

Создаём пользователя с привелегией репликации, для того чтобы делать base бекапы.

```
su - postgres
psql -c "CREATE ROLE base_backup_user REPLICATION LOGIN PASSWORD 'b1a2c3k4u5p6u7s8e9r';"
```
    
Прописываем этого пользователя в pg_hba.conf

```
nano /etc/postgresql/9.1/main/pg_hba.conf
```   

и добавляем в конце:

```
host    replication     base_backup_user 127.0.0.1/32           trust
```

Рестартим postgresql:

```
service postgresql restart
```

2. Создание base-backup.

```
  sudo su postgres
  pg_basebackup -h127.0.0.1 -U base_backup_user -D /var/lib/postgresql/9.1/backups/2013-12-16 -Ft -z -P


  #with archive logs
  pg_basebackup -h127.0.0.1 -U base_backup_user -D /var/lib/postgresql/9.1/backups/2014-02-18 -Ft -z -x
  
  
```  

готово. базовый бекап лежит в /var/lib/postgresql/9.1/backups/2013-12-16


3. Восстановление бекапа.


Останавливаем сервер. Переносим файлы рабочей копии в tmp директорию.

```
service postgresql stop
mv /var/lib/postgresql/9.1/main/  /var/lib/postgresql/9.1/main.old/
mkdir /var/lib/postgresql/9.1/main && chown postgres:postgres /var/lib/postgresql/9.1/main && chmod 700 /var/lib/postgresql/9.1/main
```

Копируем и разворачиваем base_backup

```
cp /var/lib/postgresql/9.1/backups/2013-12-16/base.tar.gz /var/lib/postgresql/9.1/main/
cd /var/lib/postgresql/9.1/main/
tar -xvf base.tar.gz
rm base.tar.gz
```

Возможно нужны будут SSL ключи:

```
cp /etc/ssl/private/ssl-cert-snakeoil.key server.key
chown postgres:postgres server.key 
chmod 740 server.key
ln -s /etc/ssl/certs/ssl-cert-snakeoil.pem server.crt
```

Создаём конфиг восстановления из шаблона, если есть файл recovery.done то можно просто его переименовать или:

```
  cp /usr/share/postgresql/9.1/recovery.conf.sample /var/lib/postgresql/9.1/main
  mv /var/lib/postgresql/9.1/main/recovery.conf.sample  /var/lib/postgresql/9.1/main/recovery.conf
  chown postgres:postgres /var/lib/postgresql/9.1/main/recovery.conf
  nano /var/lib/postgresql/9.1/main/recovery.conf
```  
  
И добавляем к нему

```
  restore_command = 'cp /var/lib/postgresql/9.1/archive/%f %p'
```
  
Если надо востановить до какой-то определённой точки времени добавляем ещё:

```
  recovery_target_time = '2013-12-17 11:25:50.0'
```
  
запускаем postgres, возможно в предыдущей рабочей копии остались файлы в x_log которые ещё не успели заархивироваться
тогда нужно будет их ещё перенести в /var/lib/postgresql/9.1/main/pg_xlog:

```
service postgresql start
```


при удачном restore файл должен был переименоваться в /var/lib/postgresql/9.1/main/recovery.done


Смотрим всё ли ок, если что-то не так пытаемся развернуть снова.