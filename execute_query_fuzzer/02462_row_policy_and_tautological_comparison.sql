-- Tags: no-parallel

DROP TABLE IF EXISTS test_alias;
DROP USER IF EXISTS test_02462;

create table test_alias (str String, sub_str String ALIAS substring(str, 1, 3)) engine = Memory();
insert into test_alias (str) values('0123456');
create user test_02462;
grant SELECT(sub_str) ON test_alias to test_02462;
select sub_str from test_alias;
select sub_str from test_alias where 1=0;

DROP USER test_02462;
DROP TABLE test_alias;
