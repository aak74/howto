# Terminate backend


```sql
SELECT pg_terminate_backend(id);
SELECT pg_cancel_backend(id);
```

```sql
-- Terminate transactions, with duration more than 1000 seconds
select pg_terminate_backend(pid)
from pg_stat_activity
where state != 'idle' and backend_type = 'client backend' and extract(epoch from now() - xact_start) > 1000;
```
