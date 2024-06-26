select value from system.settings where name = 'interval_output_format';

select 'kusto';
set interval_output_format = 'kusto';
select toIntervalNanosecond(99);
select toIntervalNanosecond(100);
select toIntervalMillisecond(1);
select toIntervalSecond(42);
select toIntervalMinute(66);
select toIntervalHour(66);
select toIntervalDay(5);
select toIntervalWeek(1);
select toIntervalWeek(2);
select toIntervalSecond(72) + toIntervalWeek(3) + toIntervalNanosecond(200);
select 'numeric';
set interval_output_format = 'numeric';
select toIntervalNanosecond(99);
select toIntervalNanosecond(100);
select toIntervalMillisecond(1);
select toIntervalSecond(42);
select toIntervalMinute(66);
select toIntervalHour(66);
select toIntervalDay(5);
select toIntervalWeek(1);
select toIntervalWeek(2);
select toIntervalSecond(72) + toIntervalWeek(3) + toIntervalNanosecond(200);
