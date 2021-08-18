# ELK

## Материалы

- [Как настроить Elasticsearch, чтобы не было утечек](https://habr.com/ru/company/dataline/blog/487210/)
- [Практическое применение ELK. Настраиваем logstash](https://habr.com/ru/post/451264/)

## Test

```sh
curl -X POST -H 'Content-Type: application/json' -d '{ "version": "1.1", "host": "example.org", "short_message": "A short message", "level": 5, "_some_info": "foo" }' 'http://graylog.example.com:12201/gelf'
```