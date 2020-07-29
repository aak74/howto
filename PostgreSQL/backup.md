# Резервное копирование
Далее для простоты предполагается, что все манипуляции производятся от имени пользователя `postgres`. У большинства утилит по работе с PostgreSQL есть ключ `-U` для указания пользователя.

Кроме того пользователя можно указать стандартным для shell образом:
```sh
su -c "pg_dump -U postgres -d mydb > db.sql" postgres
```

## Создание бэкапов
Существуют различные варианты создания резервных копий в PostgreSQL:
- Снятие дампа с данных [pg_dump](https://postgrespro.ru/docs/postgresql/11/app-pgdump)
- Сохранение физических данных [wal-g]()
- Развертывание копии с существующей БД [pg_basebackup](https://postgrespro.ru/docs/postgresql/11/app-pgbasebackup)

### pg_dump
Сохраняет данные в виде SQL. Получается логическая копия данных. Чаще всего это сильно дольше чем снятие физической копии.

```sh
# Сохранение данных
pg_dump -U postgres -d mydb > db.sql

# Восстановление данных используя psql
psql -U postgres -d newdb -f db.sql
```
При работе в консоли от имени пользователя `postgres` ключ `-U postgres` можно опустить.


### wal-g

```sh
# Настройки для wal-g размещены в папке /data/walg.env
# Создание резервной копии. 
envdir /data/walg.env wal-g backup-push /data/prod

# Оставить две полные резервные копии и дельты между ними
envdir /data/walg.env wal-g delete retain FULL 2 --confirm
```

### S3 хранилище
Cron бэкапа
```sh
0 1 * * *  cd /; su -c "envdir /nfs/env/walg.s3.env wal-g delete retain FULL 2 --confirm" postgres
0 2 * * *  cd /; su -c "envdir /nfs/env/walg.s3.env wal-g backup-push /data/prod" postgres
```

archive_command
```sh
#!/bin/bash

export AWS_ACCESS_KEY_ID=
export AWS_ENDPOINT=https://storage.yandexcloud.net
export AWS_REGION=ru-central1
export AWS_SECRET_ACCESS_KEY=
export PGDATA=/data/prod
export PGHOST=127.0.0.1
export PGPASSWORD=
export PGPORT=5432
export PGUSER=
export WALG_DELTA_MAX_STEPS=6
export WALG_DELTA_ORIGIN=LATEST
export WALG_S3_PREFIX=s3://my-backup

wal-g wal-push $1
```