# Privileges


## Добавление пользователю прав на все объекты БД
Предоставление прав разбивается на два этапа:
- Создание функции.
- Вызов функции.


```sql
--- 
CREATE OR REPLACE FUNCTION grant_all_in_db (grant_to name) RETURNS integer LANGUAGE plpgsql
AS $$
DECLARE
    rel RECORD;
BEGIN
    EXECUTE 'GRANT ALL PRIVILEGES ON DATABASE processing TO ' || quote_ident(grant_to);

    FOR rel IN
        SELECT nspname
        FROM pg_namespace
        WHERE nspname <> 'information_schema' AND nspname NOT LIKE 'pg\_%'
    LOOP
        EXECUTE 'GRANT USAGE ON SCHEMA ' || quote_ident(rel.nspname) || ' TO ' || quote_ident(grant_to);
        EXECUTE 'GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA ' || quote_ident(rel.nspname) || ' TO ' || quote_ident(grant_to);
        EXECUTE 'GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA ' || quote_ident(rel.nspname) || ' TO ' || quote_ident(grant_to);
    END LOOP;
    RETURN 1;
END;
$$;

---
SELECT grant_all_in_db('user_support');
```