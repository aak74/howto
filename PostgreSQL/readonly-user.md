# Create read only user in PostgreSQL



```SQL

DROP FUNCTION create_ro_user;

CREATE FUNCTION create_ro_user(p_username NAME, p_password TEXT, p_database TEXT) RETURNS VOID AS $func$
DECLARE
    p_schema TEXT;
    row record;
BEGIN

    EXECUTE format('CREATE ROLE %I LOGIN PASSWORD %L', p_username, p_password);
    EXECUTE format('GRANT CONNECT, TEMPORARY ON DATABASE %I TO "%I"', p_database, p_username);

    FOR row IN
        SELECT nspname
        FROM pg_catalog.pg_namespace
        WHERE nspname not LIKE 'pg_%' AND nspname <> 'information_schema'
    LOOP
        EXECUTE format('GRANT USAGE ON SCHEMA "%s" TO "%I"', row.nspname, p_username);
        EXECUTE format('GRANT SELECT ON ALL TABLES IN SCHEMA "%s" TO "%I"', row.nspname, p_username);
    END LOOP;

END $func$ LANGUAGE plpgsql;


select create_ro_user('user_ro', 'your_password', 'your_db');
```
