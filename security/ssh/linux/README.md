**Сгенерировать ключи в default path: ~/.ssh/**

ssh-keygen -t rsa

**Добавить публичный ключ на удаленный на сервер в ~/.ssh/authorized_keys**

ssh-copy-id vasja.pupkin@hostname

**или**

ssh-copy-id -i .ssh/id_rsa.pub vasja.pupkin@server