####Создать новый openvpn аккаунт (openvpn gate)####

**1.Експорт нужных переменных окружения:**

```
cd /etc/openvpn/easy-rsa
. ./vars
```

**2.Генерим и подписываем клиентский ключик:**

```
cd /etc/openvpn/easy-rsa
./build-key {first-not-capital-case-letter-of-name}.{not-capital-case-surname}
```

**Чтоб работало достаточно везде согласится в промте,
но можно думаю и подправить для красоты данные персонального сертификата**

```
Sign the certificate? [y/n]
1 out of 1 certificate requests certified, commit? [y/n]
```

**Жмем "y"**

**3. Этот скриптик подправляет client.ovpn и складывает все нужные ключики и сертификаты для клиента в zip архив.**

```
cd /etc/openvpn/easy-rsa/keys
./prepare_cert.sh
enter new nick
```
**вводим имя клиента {first-not-capital-case-letter-of-name}.{not-capital-case-surname}**

**4. Скачиваем архивчик из /etc/openvpn/easy-rsa/keys**

**5. Отдаем клиентам по защищенному каналу (ssh, tls).**