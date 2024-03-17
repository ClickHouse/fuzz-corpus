
drop table if exists dist_monitor_batch_inserts;
create table dist_monitor_batch_inserts as system.one engine=Distributed(default, system, one) settings monitor_batch_inserts=1;
show create dist_monitor_batch_inserts;
drop table dist_monitor_batch_inserts;

drop table if exists dist_monitor_split_batch_on_failure;
create table dist_monitor_split_batch_on_failure as system.one engine=Distributed(default, system, one) settings monitor_split_batch_on_failure=1;
show create dist_monitor_split_batch_on_failure;
drop table dist_monitor_split_batch_on_failure;

drop table if exists dist_monitor_sleep_time_ms;
create table dist_monitor_sleep_time_ms as system.one engine=Distributed(default, system, one) settings monitor_sleep_time_ms=1;
show create dist_monitor_sleep_time_ms;
drop table dist_monitor_sleep_time_ms;

drop table if exists dist_monitor_max_sleep_time_ms;
create table dist_monitor_max_sleep_time_ms as system.one engine=Distributed(default, system, one) settings monitor_max_sleep_time_ms=1;
show create dist_monitor_max_sleep_time_ms;
drop table dist_monitor_max_sleep_time_ms;

drop table if exists dist_background_insert_batch;
create table dist_background_insert_batch as system.one engine=Distributed(default, system, one) settings background_insert_batch=1;
show create dist_background_insert_batch;
drop table dist_background_insert_batch;

drop table if exists dist_background_insert_split_batch_on_failure;
create table dist_background_insert_split_batch_on_failure as system.one engine=Distributed(default, system, one) settings background_insert_split_batch_on_failure=1;
show create dist_background_insert_split_batch_on_failure;
drop table dist_background_insert_split_batch_on_failure;

drop table if exists dist_background_insert_sleep_time_ms;
create table dist_background_insert_sleep_time_ms as system.one engine=Distributed(default, system, one) settings background_insert_sleep_time_ms=1;
show create dist_background_insert_sleep_time_ms;
drop table dist_background_insert_sleep_time_ms;

drop table if exists dist_background_insert_max_sleep_time_ms;
create table dist_background_insert_max_sleep_time_ms as system.one engine=Distributed(default, system, one) settings background_insert_max_sleep_time_ms=1;
show create dist_background_insert_max_sleep_time_ms;
drop table dist_background_insert_max_sleep_time_ms;


create table data (key Int) engine=Null();
create table dist (key Int) engine=Distributed(default, currentDatabase(), data, key);

insert into dist settings distributed_directory_monitor_sleep_time_ms=1 values (1);
system flush distributed dist;

insert into dist settings distributed_directory_monitor_max_sleep_time_ms=1 values (1);
system flush distributed dist;

insert into dist settings distributed_directory_monitor_batch_inserts=1 values (1);
system flush distributed dist;

insert into dist settings distributed_directory_monitor_split_batch_on_failure=1 values (1);
system flush distributed dist;

insert into dist settings insert_distributed_sync=1 values (1);
system flush distributed dist;

insert into dist settings insert_distributed_timeout=1 values (1);
system flush distributed dist;

