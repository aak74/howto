# Journal

## Просмотр журнала

```sh
# Show journal
journalctl --since "2019-01-30 14:00:00"
journalctl --since today
```

## Очистка журнала

```sh
# Retain only the past two days:
journalctl --vacuum-time=2d

# Retain only the past 500 MB:
journalctl --vacuum-size=500M
```