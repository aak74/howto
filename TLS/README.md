# TLS / SSL

```sh
# Даты сертификата, издатель
# from site
echo | openssl s_client -connect admin.premiumbonus.su:443 2>/dev/null | openssl x509 -noout -dates -issuer

# from file
echo | openssl x509 -in 2.crt -text 2>/dev/null | openssl x509 -noout -dates -issuer

# Текст сертификата
# from helm template
grep 'tls.crt:' ./.helm/templates/10-cert-stage.yaml | cut -c 12- | base64 --decode | openssl x509 -in /dev/stdin -text

# from kubernetes secret
kubectl -n ecom-front-test get secrets stage.cert -o yaml | grep 'tls.crt' | cut -c 12- | base64 --decode | openssl x509 -in /dev/stdin -text
```

Modulus приватноко ключа и сертификата должны совпадать Можно проверить 

```sh
# Проверка сертификата
openssl x509 -noout -modulus -in certificate.crt | openssl md5
# Проверка приватного ключа
openssl rsa -noout -modulus -in private.key | openssl md5
# Проверка запроса
openssl req -noout -modulus -in request.csr | openssl md5

# У запроса и у приватного ключа modulus должны совпадать
```

Нужно обратить внимание на первый параметр у команды openssl. Для каждого случая это разные параметры.

Если вывод этих команд разный для request и private key, то пара сертификат + приватный ключ работать не будут.