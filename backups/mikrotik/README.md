####Create configuration backup####

```
/system backup save name=somerouter_backup_DD.MM.YYYY
```

**Скопировать себе через sFTP**

```
scp admin@11.22.33.44:somerouter_backup_DD.MM.YYYY.backup . 
```

**Залить на роутер**

```
scp somerouter_backup_DD.MM.YYYY.backup admin@11.22.33.44:
```

**Восстановить**

```
system backup load name=somerouter_backup_DD.MM.YYYY.backup
```