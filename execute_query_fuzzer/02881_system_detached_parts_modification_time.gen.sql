set mutations_sync=1;



drop table if exists data_wide;
create table data_wide (key Int) engine=MergeTree() order by tuple() settings min_bytes_for_wide_part=0, min_rows_for_wide_part=0;
insert into data_wide values (1);
select 'before detach', now()-modification_time < 10 from system.detached_parts where database = currentDatabase() and table = 'data_wide';
alter table data_wide detach partition all;
select 'after detach', now()-modification_time < 10 from system.detached_parts where database = currentDatabase() and table = 'data_wide';



drop table if exists data_compact;
create table data_compact (key Int) engine=MergeTree() order by tuple() settings min_bytes_for_wide_part=1000, min_rows_for_wide_part=100;
insert into data_compact values (1);
select 'before detach', now()-modification_time < 10 from system.detached_parts where database = currentDatabase() and table = 'data_compact';
alter table data_compact detach partition all;
select 'after detach', now()-modification_time < 10 from system.detached_parts where database = currentDatabase() and table = 'data_compact';


