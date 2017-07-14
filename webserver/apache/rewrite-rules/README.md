Rewrite rules


ури будет переписан на "" и новый ури "/" будет послан на вход серверу

```
RewriteRule ^index\.php$ / [L]
```

[L] - предотвращает проверку входного ури на следующие за ним правила, если это правило сработало

ввиду наличия флага [L] мы прерываем все последующие проверки, и веб сервер сразу производит рерайтинг «index.php» -> "" и получает на вход ури "/" ([INTERNAL REDIRECT] ), и все повторяется с начала, с первого правила

В случае отсутствия флагов [L], модуль, как и предполагается, заменяет ури на сработавшем правиле, идет по всем оставшимся правилам до конца, потом производит [INTERNAL REDIRECT] и все равно проходит с этим ури все правила еще раз. То есть подтверждается то, о чем мы писали выше. Это правило, похоже, не имеет исключений.


RewriteBase добавляется в качестве префикса к целевому ури в том случае, если он является относительным, то есть в начале нет слэша

```
RewriteBase /local
RewriteRule ^$ ind1.php
```
будет осуществлен переход на ури /local/ind1.php

```
RewriteBase /local
RewriteRule ^$ /ind1.php
```
переход будет осуществлен на ури /ind1.php

Если мы никогда не используем относительные целевые ури в правилах, то и директива RewriteBase нам не нужна!

RewriteBase выполняется только после всех RewriteRule, а не между ними.
RewriteBase фактически является хаком, который помогает восстановить исходный путь до файла (нпример если htacces находится не в корневой директории)

```
# .htaccess находится в /images/
# RewriteBase указан /images/
RewriteBase /images/

# Запрос http://example.com/images/logo.gif
# На вход RewriteRule попадает "logo.gif"
RewriteRule ^logo.gif$ logo-orange.gif
# После RewriteRule: "logo.gif" -> "logo-orange.gif"
# После RewriteBase: "logo-orange.gif" -> "/images/logo-orange.gif"

# Запрос http://example.com/images/header.png
# На вход RewriteRule попадает "header.png"
RewriteRule ^header.png$ /templates/rebranding/header.png
# После RewriteRule: "header.png" -> "/templates/rebranding/header.png"
# После RewriteBase: ничего не меняется, так итоговый результат преобразований начинается со "/'.

# Запрос http://example.com/images/director.tiff
# На вход RewriteRule попадает "director.tiff"
# Используем внешний относительный редирект
RewriteRule ^director.tiff$ staff/manager/director.tiff [R=301]
# После RewriteRule: "director.tiff" -> "staff/manager/director.tiff"
# + mod_rewrite запомнил, что будет внешний редирект
# После RewriteBase: "staff/manager/director.tiff" -> "/images/staff/manager/director.tiff"
# mod_rewrite вспомнил про внешний редирект:
# "/images/staff/manager/director.tiff" -> http://example.com/images/staff/manager/director.tiff
```

Теперь, когда известно, что делает RewriteBase, можно сформулировать следующие корректные правила:
RewriteBase должен совпадать с путем от корня сайта до .htaccess.
Начинать перенаправления со "/" нужно только тогда, когда необходимо указать абсолютный путь от корня сайта до файла.

Что будет, если не указать RewriteBase? По умолчанию Apache делает его равным абсолютному пути на файловой системе до .htaccess (например, /var/www/example.com/templates/). Некорректность такого предположения Apache проявляется на внешних относительных редиректах:

```

# Запрос http://example.com/index.php
# DocumentRoot: /var/www/example.com/
# .htaccess находится в корне сайта, и в нем НЕ УКАЗАН RewriteBase.
# Поэтому по умолчанию RewriteBase равен абсолютному пути до .htaccess: /var/www/example.com/

# На входе RewriteRule - "index.php"
RewriteRule ^index.php main.php [R]
# На выходе: "index.php" -> "main.php"
# mod_rewrite запомнил, что нужен внешний редирект

# Закончились RewriteRule
# mod_rewrite все равно выполняет RewriteBase, так как у него есть значение по умолчанию.
# Получается: "main.php" -> "/var/www/example.com/main.php"

# Здесь mod_rewrite вспоминает, что был внешний редирект:
# "/var/www/example.com/main.php" -> http://example.com/var/www/example.com/main.php

# Получилось совсем не то, что имели в виду.

```

```
RewriteBase /

# Запрос: http://example.com/news/2010/?page=2
# На входе RewriteRule: "news/2010/"
RewriteRule ^news/(.*)$ index.php?act=news&what=$1
# После преобразования: "news/2010/" -> "index.php"
# Значение %{QUERY_STRING}: "page=2" -> "act=news&what=2010/"


RewriteBase /

# Запрос: http://example.com/news/2010/?page=2
# На входе RewriteRule: "news/2010/"
RewriteRule ^news/(.*)$ index.php?act=news&what=$1 [QSA]
# После преобразования: "news/2010/" -> "index.php"
# Значение %{QUERY_STRING}: "page=2" -> "act=news&what=2010/&page=2"
```

Если же mod_rewrite используется в <VirtualHost>, он будет работать по-другому:
В <VirtualHost> в RewriteRule попадает весь путь запроса, начиная от первого слеша, заканчивая началом параметров GET: «http://example.com/some/news/category/post.html?comments_page=3» -> "/news/category/post.html". Эта строка всегда начинается со /.
Второй аргумент RewriteRule также необходимо начинать со /, иначе будет «Bad Request».
RewriteBase не имеет смысла.
Проход правил происходит только один раз. Флаг [L] действительно заканчивает обработку всех правил, описанных в <VirtualHost>, без каких-либо последующих итераций.

При составлении более-менее сложных конфигураций mod_rewrite важно понимать, что изменение запроса не заканчивается на последнем RewriteRule. После того, как сработало последнее правило RewriteRule и был добавлен RewriteBase, mod_rewrite смотрит, изменился запрос или нет. Если запрос изменился, его обработка начинается заново с начала .htaccess.

LogLevel означает, что для всех модулей уровень ошибок warn и только для модуля rewrite — trace4
Получаем трассировку
```
LogLevel warn rewrite:trace4
```