# Drop user

```postgresql
select drop_user('user_ro', 'processing');

DROP FUNCTION drop_user;

CREATE FUNCTION drop_user(p_username NAME, p_database TEXT) RETURNS VOID AS $func$
DECLARE
    row record;
BEGIN
    FOR row IN
        SELECT nspname
        FROM pg_catalog.pg_namespace
        WHERE nspname not LIKE 'pg_%' AND nspname <> 'information_schema'
    LOOP
        EXECUTE format('REVOKE ALL ON SCHEMA "%s" FROM "%I"', row.nspname, p_username);
        EXECUTE format('REVOKE ALL ON ALL TABLES IN SCHEMA "%s" FROM "%I"', row.nspname, p_username);
    END LOOP;

    EXECUTE format('REVOKE ALL ON DATABASE %I FROM "%I"', p_database, p_username);
    EXECUTE format('DROP ROLE %I', p_username);

END $func$ LANGUAGE plpgsql;
```
