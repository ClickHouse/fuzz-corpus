select 'Pretty';
select number as x, number + 1 as y from numbers(4) settings max_block_size=2, output_format_pretty_color=1 format Pretty;

select 'PrettyNoEscapes';
select number as x, number + 1 as y from numbers(4) settings max_block_size=2, output_format_pretty_color=1 format PrettyNoEscapes;

select 'PrettyMonoBlock';
select number as x, number + 1 as y from numbers(4) settings max_block_size=2, output_format_pretty_color=1 format PrettyMonoBlock;

select 'PrettyNoEscapesMonoBlock';
select number as x, number + 1 as y from numbers(4) settings max_block_size=2, output_format_pretty_color=1 format PrettyNoEscapesMonoBlock;

select 'PrettyCompact';
select number as x, number + 1 as y from numbers(4) settings max_block_size=2, output_format_pretty_color=1 format PrettyCompact;

select 'PrettyCompactNoEscapes';
select number as x, number + 1 as y from numbers(4) settings max_block_size=2, output_format_pretty_color=1 format PrettyCompactNoEscapes;

select 'PrettyCompactMonoBlock';
select number as x, number + 1 as y from numbers(4) settings max_block_size=2, output_format_pretty_color=1 format PrettyCompactMonoBlock;

select 'PrettyCompactNoEscapesMonoBlock';
select number as x, number + 1 as y from numbers(4) settings max_block_size=2, output_format_pretty_color=1 format PrettyCompactNoEscapesMonoBlock;

select 'PrettySpace';
select number as x, number + 1 as y from numbers(4) settings max_block_size=2, output_format_pretty_color=1 format PrettySpace;

select 'PrettySpaceNoEscapes';
select number as x, number + 1 as y from numbers(4) settings max_block_size=2, output_format_pretty_color=1 format PrettySpaceNoEscapes;

select 'PrettySpaceMonoBlock';
select number as x, number + 1 as y from numbers(4) settings max_block_size=2, output_format_pretty_color=1 format PrettySpaceMonoBlock;

select 'PrettySpaceNoEscapesMonoBlock';
select number as x, number + 1 as y from numbers(4) settings max_block_size=2, output_format_pretty_color=1 format PrettySpaceNoEscapesMonoBlock;

