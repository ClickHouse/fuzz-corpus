-- Tags: no-s3-storage
-- Tag: no-s3-storage because S3 updates metadata for the virtual link file on metadata disk (see CreateHardlinkOperation::execute() for details)

set mutations_sync=1;






drop table if exists data_wide;
create table data_wide (key Int) engine=MergeTree() order by tuple() settings min_bytes_for_wide_part=0, min_rows_for_wide_part=0;
insert into data_wide values (1);
select sleep(3) format Null;
select part_type, column, now()-modification_time < 10, modification_time - column_modification_time < 5 from system.parts_columns where database = currentDatabase() and table = 'data_wide';
alter table data_wide add column value Int default 0;
alter table data_wide materialize column value;
select part_type, column, now()-modification_time < 10,

modification_time - column_modification_time >= 3

from system.parts_columns where active and database = currentDatabase() and table = 'data_wide' order by column;



drop table if exists data_compact;
create table data_compact (key Int) engine=MergeTree() order by tuple() settings min_bytes_for_wide_part=1000, min_rows_for_wide_part=100;
insert into data_compact values (1);
select sleep(3) format Null;
select part_type, column, now()-modification_time < 10, modification_time - column_modification_time < 5 from system.parts_columns where database = currentDatabase() and table = 'data_compact';
alter table data_compact add column value Int default 0;
alter table data_compact materialize column value;
select part_type, column, now()-modification_time < 10,

modification_time - column_modification_time < 5

from system.parts_columns where active and database = currentDatabase() and table = 'data_compact' order by column;


