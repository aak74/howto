# Docker

## Чистка логов

```sh
sudo sh -c "truncate -s 0 /var/lib/docker/containers/*/*-json.log"
```

### logrotate

```sh
vim /etc/logrotate.d/docker
```

Содержимое файла
```
/var/lib/docker/containers/*/*.log {
    rotate 7
    daily
    compress
    size=50M
    missingok
    delaycompress
    copytruncate
}
```

```sh
logrotate -f /etc/logrotate.d/docker
```