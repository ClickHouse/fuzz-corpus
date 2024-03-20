-- Tags: no-s3-storage, no-parallel, no-fasttest
-- no-s3-storage: s3 has 20 more threads
-- no-parallel: it checks the number of threads, which can be lowered in presence of other queries

-- avoid settings randomization by clickhouse-test
set max_threads = 0;

drop table if exists testX;
drop table if exists testXA;
drop table if exists testXB;
drop table if exists testXC;

create table testX (A Int64) engine=MergeTree order by tuple();

create materialized view testXA engine=MergeTree order by tuple() as select sleep(0.1) from testX;
create materialized view testXB engine=MergeTree order by tuple() as select sleep(0.2), throwIf(A=1) from testX;
create materialized view testXC engine=MergeTree order by tuple() as select sleep(0.1) from testX;

-- { echoOn }



select 'optimize_trivial_insert_select=0', 'max_insert_threads=0';

insert into testX select number from numbers(10) settings
    log_queries=1,
    parallel_view_processing=0,
    optimize_trivial_insert_select=0,
    max_insert_threads=0; -- { serverError FUNCTION_THROW_IF_VALUE_IS_NON_ZERO }
system flush logs;
select arrayUniq(thread_ids) from system.query_log where
    current_database = currentDatabase() and
    type != 'QueryStart' and
    query like '%insert into testX %' and
    Settings['parallel_view_processing'] = '0' and
    Settings['optimize_trivial_insert_select'] = '0' and
    Settings['max_insert_threads'] = '0';

select count() from testX;
select count() from testXA;
select count() from testXB;
select count() from testXC;

select 'optimize_trivial_insert_select=0', 'max_insert_threads=16';

insert into testX select number from numbers(10) settings
    log_queries=1,
    parallel_view_processing=0,
    optimize_trivial_insert_select=0,
    max_insert_threads=16; -- { serverError FUNCTION_THROW_IF_VALUE_IS_NON_ZERO }
system flush logs;
select arrayUniq(thread_ids) from system.query_log where
    current_database = currentDatabase() and
    type != 'QueryStart' and
    query like '%insert into testX %' and
    Settings['parallel_view_processing'] = '0' and
    Settings['optimize_trivial_insert_select'] = '0' and
    Settings['max_insert_threads'] = '16';

select count() from testX;
select count() from testXA;
select count() from testXB;
select count() from testXC;



select 'optimize_trivial_insert_select=1', 'max_insert_threads=0';

insert into testX select number from numbers(10) settings
    log_queries=1,
    parallel_view_processing=0,
    optimize_trivial_insert_select=1,
    max_insert_threads=0; -- { serverError FUNCTION_THROW_IF_VALUE_IS_NON_ZERO }
system flush logs;
select arrayUniq(thread_ids) from system.query_log where
    current_database = currentDatabase() and
    type != 'QueryStart' and
    query like '%insert into testX %' and
    Settings['parallel_view_processing'] = '0' and
    Settings['optimize_trivial_insert_select'] = '1' and
    Settings['max_insert_threads'] = '0';

select count() from testX;
select count() from testXA;
select count() from testXB;
select count() from testXC;

select 'optimize_trivial_insert_select=1', 'max_insert_threads=16';

insert into testX select number from numbers(10) settings
    log_queries=1,
    parallel_view_processing=0,
    optimize_trivial_insert_select=1,
    max_insert_threads=16; -- { serverError FUNCTION_THROW_IF_VALUE_IS_NON_ZERO }
system flush logs;
select arrayUniq(thread_ids) from system.query_log where
    current_database = currentDatabase() and
    type != 'QueryStart' and
    query like '%insert into testX %' and
    Settings['parallel_view_processing'] = '0' and
    Settings['optimize_trivial_insert_select'] = '1' and
    Settings['max_insert_threads'] = '16';

select count() from testX;
select count() from testXA;
select count() from testXB;
select count() from testXC;





select 'optimize_trivial_insert_select=0', 'max_insert_threads=0';

insert into testX select number from numbers(10) settings
    log_queries=1,
    parallel_view_processing=1,
    optimize_trivial_insert_select=0,
    max_insert_threads=0; -- { serverError FUNCTION_THROW_IF_VALUE_IS_NON_ZERO }
system flush logs;
select arrayUniq(thread_ids) from system.query_log where
    current_database = currentDatabase() and
    type != 'QueryStart' and
    query like '%insert into testX %' and
    Settings['parallel_view_processing'] = '1' and
    Settings['optimize_trivial_insert_select'] = '0' and
    Settings['max_insert_threads'] = '0';

select count() from testX;
select count() from testXA;
select count() from testXB;
select count() from testXC;

select 'optimize_trivial_insert_select=0', 'max_insert_threads=16';

insert into testX select number from numbers(10) settings
    log_queries=1,
    parallel_view_processing=1,
    optimize_trivial_insert_select=0,
    max_insert_threads=16; -- { serverError FUNCTION_THROW_IF_VALUE_IS_NON_ZERO }
system flush logs;
select arrayUniq(thread_ids) from system.query_log where
    current_database = currentDatabase() and
    type != 'QueryStart' and
    query like '%insert into testX %' and
    Settings['parallel_view_processing'] = '1' and
    Settings['optimize_trivial_insert_select'] = '0' and
    Settings['max_insert_threads'] = '16';

select count() from testX;
select count() from testXA;
select count() from testXB;
select count() from testXC;



select 'optimize_trivial_insert_select=1', 'max_insert_threads=0';

insert into testX select number from numbers(10) settings
    log_queries=1,
    parallel_view_processing=1,
    optimize_trivial_insert_select=1,
    max_insert_threads=0; -- { serverError FUNCTION_THROW_IF_VALUE_IS_NON_ZERO }
system flush logs;
select arrayUniq(thread_ids) from system.query_log where
    current_database = currentDatabase() and
    type != 'QueryStart' and
    query like '%insert into testX %' and
    Settings['parallel_view_processing'] = '1' and
    Settings['optimize_trivial_insert_select'] = '1' and
    Settings['max_insert_threads'] = '0';

select count() from testX;
select count() from testXA;
select count() from testXB;
select count() from testXC;

select 'optimize_trivial_insert_select=1', 'max_insert_threads=16';

insert into testX select number from numbers(10) settings
    log_queries=1,
    parallel_view_processing=1,
    optimize_trivial_insert_select=1,
    max_insert_threads=16; -- { serverError FUNCTION_THROW_IF_VALUE_IS_NON_ZERO }
system flush logs;
select arrayUniq(thread_ids) from system.query_log where
    current_database = currentDatabase() and
    type != 'QueryStart' and
    query like '%insert into testX %' and
    Settings['parallel_view_processing'] = '1' and
    Settings['optimize_trivial_insert_select'] = '1' and
    Settings['max_insert_threads'] = '16';

select count() from testX;
select count() from testXA;
select count() from testXB;
select count() from testXC;



-- { echoOff }

drop table testX;
drop view testXA;
drop view testXB;
drop view testXC;
