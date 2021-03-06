-- test startup permissions failure
CREATE FUNCTION start() RETURNS void AS $$ plv8.elog(NOTICE, 'nope'); $$ LANGUAGE plv8;

CREATE ROLE someone_else;

REVOKE EXECUTE ON FUNCTION start() FROM public;

SET plv8.start_proc = 'start';
REVOKE EXECUTE ON FUNCTION start() FROM public;

SET ROLE TO someone_else;
DO $$ plv8.elog(NOTICE, 'hello') $$ LANGUAGE plv8;

RESET ROLE;
DROP ROLE someone_else;

RESET plv8.start_proc;

DROP FUNCTION start();
