Синкаем файлы с удаленного сервера (source) на локальный(destination).

```
rsync -av --progress --del /var/www/forum.rbkgames.com/ www-data@91.237.99.91:/var/www/forum.rbkgames.com/

```