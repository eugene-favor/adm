Урезаем старые данные

и запускаем из консоли

```


```



```
CREATE TABLE some_table_new (LIKE some_table);
INSERT INTO some_table_new (SELECT * FROM some_table WHERE date_time > '2014-12-31 23:59:59');

CREATE SEQUENCE some_table_new_id_seq
        INCREMENT 1
        MINVALUE 1
        MAXVALUE 9223372036854775807
        START 1
  CACHE 1;
  ALTER TABLE some_table_new_id_seq
  OWNER TO someuser;

select setval('some_table_new_id_seq', (SELECT max(id) FROM some_table_new));

ALTER TABLE some_table_new ALTER COLUMN id SET DEFAULT nextval('some_table_new_id_seq'::regclass);

ALTER TABLE some_table RENAME TO some_table_old;
ALTER INDEX some_table_date_time_idx RENAME TO some_table_old_date_time_idx; 
ALTER SEQUENCE some_table_id_seq RENAME TO some_table_old_id_seq;

ALTER TABLE some_table_new RENAME TO some_table;
ALTER INDEX some_table_new_date_time_idx RENAME TO some_table_date_time_idx;
ALTER SEQUENCE some_table_new_id_seq RENAME TO some_table_id_seq;



ALTER TABLE some_table
  ADD CONSTRAINT some_table_id_pkey PRIMARY KEY(id);

```