-- Tags: long



drop table if exists data_02052_1_wide0;
create table data_02052_1_wide0 (key Int, value String)
engine=MergeTree()
order by key
settings
    min_bytes_for_wide_part=0
as select number, repeat(toString(number), 5) from numbers(1);

-- avoid any optimizations with ignore(*)
select * apply max from data_02052_1_wide0 settings max_read_buffer_size=1, max_threads=1;
select * apply max from data_02052_1_wide0 settings max_read_buffer_size=0, max_threads=1; -- { serverError INVALID_SETTING_VALUE }

drop table data_02052_1_wide0;

drop table if exists data_02052_1_wide100000000;
create table data_02052_1_wide100000000 (key Int, value String)
engine=MergeTree()
order by key
settings
    min_bytes_for_wide_part=100000000
as select number, repeat(toString(number), 5) from numbers(1);

-- avoid any optimizations with ignore(*)
select * apply max from data_02052_1_wide100000000 settings max_read_buffer_size=1, max_threads=1;
select * apply max from data_02052_1_wide100000000 settings max_read_buffer_size=0, max_threads=1; -- { serverError INVALID_SETTING_VALUE }

drop table data_02052_1_wide100000000;



drop table if exists data_02052_10_wide0;
create table data_02052_10_wide0 (key Int, value String)
engine=MergeTree()
order by key
settings
    min_bytes_for_wide_part=0
as select number, repeat(toString(number), 5) from numbers(10);

-- avoid any optimizations with ignore(*)
select * apply max from data_02052_10_wide0 settings max_read_buffer_size=1, max_threads=1;
select * apply max from data_02052_10_wide0 settings max_read_buffer_size=0, max_threads=1; -- { serverError INVALID_SETTING_VALUE }

drop table data_02052_10_wide0;

drop table if exists data_02052_10_wide100000000;
create table data_02052_10_wide100000000 (key Int, value String)
engine=MergeTree()
order by key
settings
    min_bytes_for_wide_part=100000000
as select number, repeat(toString(number), 5) from numbers(10);

-- avoid any optimizations with ignore(*)
select * apply max from data_02052_10_wide100000000 settings max_read_buffer_size=1, max_threads=1;
select * apply max from data_02052_10_wide100000000 settings max_read_buffer_size=0, max_threads=1; -- { serverError INVALID_SETTING_VALUE }

drop table data_02052_10_wide100000000;



drop table if exists data_02052_100_wide0;
create table data_02052_100_wide0 (key Int, value String)
engine=MergeTree()
order by key
settings
    min_bytes_for_wide_part=0
as select number, repeat(toString(number), 5) from numbers(100);

-- avoid any optimizations with ignore(*)
select * apply max from data_02052_100_wide0 settings max_read_buffer_size=1, max_threads=1;
select * apply max from data_02052_100_wide0 settings max_read_buffer_size=0, max_threads=1; -- { serverError INVALID_SETTING_VALUE }

drop table data_02052_100_wide0;

drop table if exists data_02052_100_wide100000000;
create table data_02052_100_wide100000000 (key Int, value String)
engine=MergeTree()
order by key
settings
    min_bytes_for_wide_part=100000000
as select number, repeat(toString(number), 5) from numbers(100);

-- avoid any optimizations with ignore(*)
select * apply max from data_02052_100_wide100000000 settings max_read_buffer_size=1, max_threads=1;
select * apply max from data_02052_100_wide100000000 settings max_read_buffer_size=0, max_threads=1; -- { serverError INVALID_SETTING_VALUE }

drop table data_02052_100_wide100000000;



drop table if exists data_02052_10000_wide0;
create table data_02052_10000_wide0 (key Int, value String)
engine=MergeTree()
order by key
settings
    min_bytes_for_wide_part=0
as select number, repeat(toString(number), 5) from numbers(10000);

-- avoid any optimizations with ignore(*)
select * apply max from data_02052_10000_wide0 settings max_read_buffer_size=1, max_threads=1;
select * apply max from data_02052_10000_wide0 settings max_read_buffer_size=0, max_threads=1; -- { serverError INVALID_SETTING_VALUE }

drop table data_02052_10000_wide0;

drop table if exists data_02052_10000_wide100000000;
create table data_02052_10000_wide100000000 (key Int, value String)
engine=MergeTree()
order by key
settings
    min_bytes_for_wide_part=100000000
as select number, repeat(toString(number), 5) from numbers(10000);

-- avoid any optimizations with ignore(*)
select * apply max from data_02052_10000_wide100000000 settings max_read_buffer_size=1, max_threads=1;
select * apply max from data_02052_10000_wide100000000 settings max_read_buffer_size=0, max_threads=1; -- { serverError INVALID_SETTING_VALUE }

drop table data_02052_10000_wide100000000;


