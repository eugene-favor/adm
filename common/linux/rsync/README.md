Синкаем файлы с удаленного сервера (source) на локальный(destination).

```
rsync -av --progress --del www-data@source-server:/var/www/test/ /var/www/test/

```