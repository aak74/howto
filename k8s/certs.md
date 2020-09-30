# Сертификаты

[Общая информация](https://habr.com/ru/company/southbridge/blog/465733/)

## При установке с помощью kubeadm

Обновление сертификатов
```sh
kubeadm alpha certs renew all
```

После обновления сертификатов необходимо обновить конфиги для доступа к Kubernetes.
Конфиг тут: `/etc/kubernetes/admin.conf`.