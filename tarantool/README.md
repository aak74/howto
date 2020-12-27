# Tarantool
Tarantool In-memory база данных + сервер приложений от mail.ru.

## Материалы

- [В Tarantool можно совместить супербыструю базу данных и приложение для работы с ними. Вот как просто это делается](https://habr.com/ru/company/rebrainme/blog/521556/)


## Настройка

### Увеличение памяти выделенной 
Запустите `console`
```
box.cfg({memtx_memory = box.cfg.memtx_memory + 512 * 2^20})
```