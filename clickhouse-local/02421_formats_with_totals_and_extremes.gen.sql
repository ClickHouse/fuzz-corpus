-- Tags: no-fasttest

set output_format_pretty_color=1;
set output_format_write_statistics=0;

select 'CSV';
select sum(number) from numbers(10) group by number % 2 with totals format CSV settings extremes=1;
select '';

select 'TSV';
select sum(number) from numbers(10) group by number % 2 with totals format TSV settings extremes=1;
select '';

select 'XML';
select sum(number) from numbers(10) group by number % 2 with totals format XML settings extremes=1;
select '';

select 'Vertical';
select sum(number) from numbers(10) group by number % 2 with totals format Vertical settings extremes=1;
select '';

select 'Pretty';
select sum(number) from numbers(10) group by number % 2 with totals format Pretty settings extremes=1;
select '';

select 'JSON';
select sum(number) from numbers(10) group by number % 2 with totals format JSON settings extremes=1;
select '';

select 'JSONCompact';
select sum(number) from numbers(10) group by number % 2 with totals format JSONCompact settings extremes=1;
select '';

select 'Formats without totals and extremes:';

select 'CustomSeparated';
select sum(number) from numbers(10) group by number % 2 with totals format CustomSeparated settings extremes=1;
select '';

select 'JSONEachRow';
select sum(number) from numbers(10) group by number % 2 with totals format JSONEachRow settings extremes=1;
select '';

select 'JSONCompactEachRow';
select sum(number) from numbers(10) group by number % 2 with totals format JSONCompactEachRow settings extremes=1;
select '';

select 'RowBinary';
select sum(number) from numbers(10) group by number % 2 with totals format RowBinary settings extremes=1;
select '';

select 'MsgPack';
select sum(number) from numbers(10) group by number % 2 with totals format MsgPack settings extremes=1;
select '';

select 'Markdown';
select sum(number) from numbers(10) group by number % 2 with totals format Markdown settings extremes=1;
select '';

select 'SQLInsert';
select sum(number) from numbers(10) group by number % 2 with totals format SQLInsert settings extremes=1;
select '';

select 'Values';
select sum(number) from numbers(10) group by number % 2 with totals format Values settings extremes=1;
select '';

select 'TSKV';
select sum(number) from numbers(10) group by number % 2 with totals format TSKV settings extremes=1;
select '';

