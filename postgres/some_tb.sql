--https://www.postgresql.org/docs/current/plpgsql-trigger.html

CREATE SCHEMA IF NOT EXISTS some_schema;
CREATE SCHEMA IF NOT EXISTS other_schema;

CREATE TABLE IF NOT EXISTS some_schema.some_tb (
    id SERIAL PRIMARY KEY,
    status TEXT NOT NULL,
    name TEXT NOT NULL
);

-- Create table with matching columns datatypes
CREATE TABLE IF NOT EXISTS other_schema.other_tb AS 
SELECT id, status 
FROM some_tb st;

CREATE TABLE IF NOT EXISTS other_schema.some_tb_audit(
    operation         char(1)   NOT NULL,
    stamp             timestamp NOT NULL,
    id                integer   NOT NULL
);

CREATE OR REPLACE FUNCTION other_schema.process_some_tb() RETURNS TRIGGER AS $plpgsql$
    BEGIN
        --
        -- Create a row in emp_audit to reflect the operation performed on some_tb,
        -- making use of the special variable TG_OP to work out the operation.
        --
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO some_tb_audit SELECT 'D', now(), OLD.id;
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO some_tb_audit SELECT 'U', now(), NEW.id;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO some_tb_audit SELECT 'I', now(), NEW.id;
        END IF;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$plpgsql$ LANGUAGE plpgsql;

CREATE TRIGGER some_tb_audit
AFTER INSERT OR UPDATE OR DELETE ON some_schema.some_tb
    FOR EACH ROW EXECUTE FUNCTION other_schema.process_some_tb();