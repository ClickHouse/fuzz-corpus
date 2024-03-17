-- Tags: no-parallel, no-fasttest

system drop schema cache for file;
set input_format_json_try_infer_numbers_from_strings=1;
select 'TSV';
insert into function file(02404_data.TSV) select number, toDate(number) from numbers(10);
desc file(02404_data.TSV);
desc file(02404_data.TSV) settings input_format_try_infer_integers=0;
desc file(02404_data.TSV) settings input_format_try_infer_dates=0;
desc file(02404_data.TSV) settings schema_inference_hints='c1 UInt8';
select count() from system.schema_inference_cache where countSubstrings(source, '02404_data.TSV') > 0;

select 'TSVWithNames';
insert into function file(02404_data.TSVWithNames) select number, toDate(number) from numbers(10);
desc file(02404_data.TSVWithNames);
desc file(02404_data.TSVWithNames) settings input_format_try_infer_integers=0;
desc file(02404_data.TSVWithNames) settings input_format_try_infer_dates=0;
desc file(02404_data.TSVWithNames) settings schema_inference_hints='c1 UInt8';
select count() from system.schema_inference_cache where countSubstrings(source, '02404_data.TSVWithNames') > 0;

select 'CSV';
insert into function file(02404_data.CSV) select number, toDate(number) from numbers(10);
desc file(02404_data.CSV);
desc file(02404_data.CSV) settings input_format_try_infer_integers=0;
desc file(02404_data.CSV) settings input_format_try_infer_dates=0;
desc file(02404_data.CSV) settings schema_inference_hints='c1 UInt8';
select count() from system.schema_inference_cache where countSubstrings(source, '02404_data.CSV') > 0;

select 'CSVWithNames';
insert into function file(02404_data.CSVWithNames) select number, toDate(number) from numbers(10);
desc file(02404_data.CSVWithNames);
desc file(02404_data.CSVWithNames) settings input_format_try_infer_integers=0;
desc file(02404_data.CSVWithNames) settings input_format_try_infer_dates=0;
desc file(02404_data.CSVWithNames) settings schema_inference_hints='c1 UInt8';
select count() from system.schema_inference_cache where countSubstrings(source, '02404_data.CSVWithNames') > 0;

select 'TSKV';
insert into function file(02404_data.TSKV) select number, toDate(number) from numbers(10);
desc file(02404_data.TSKV);
desc file(02404_data.TSKV) settings input_format_try_infer_integers=0;
desc file(02404_data.TSKV) settings input_format_try_infer_dates=0;
desc file(02404_data.TSKV) settings schema_inference_hints='c1 UInt8';
select count() from system.schema_inference_cache where countSubstrings(source, '02404_data.TSKV') > 0;

select 'CustomSeparated';
insert into function file(02404_data.CustomSeparated) select number, toDate(number) from numbers(10);
desc file(02404_data.CustomSeparated);
desc file(02404_data.CustomSeparated) settings input_format_try_infer_integers=0;
desc file(02404_data.CustomSeparated) settings input_format_try_infer_dates=0;
desc file(02404_data.CustomSeparated) settings schema_inference_hints='c1 UInt8';
select count() from system.schema_inference_cache where countSubstrings(source, '02404_data.CustomSeparated') > 0;

select 'JSONEachRow';
insert into function file(02404_data.JSONEachRow) select number, toDate(number) from numbers(10);
desc file(02404_data.JSONEachRow);
desc file(02404_data.JSONEachRow) settings input_format_try_infer_integers=0;
desc file(02404_data.JSONEachRow) settings input_format_try_infer_dates=0;
desc file(02404_data.JSONEachRow) settings schema_inference_hints='c1 UInt8';
select count() from system.schema_inference_cache where countSubstrings(source, '02404_data.JSONEachRow') > 0;

select 'JSONCompactEachRow';
insert into function file(02404_data.JSONCompactEachRow) select number, toDate(number) from numbers(10);
desc file(02404_data.JSONCompactEachRow);
desc file(02404_data.JSONCompactEachRow) settings input_format_try_infer_integers=0;
desc file(02404_data.JSONCompactEachRow) settings input_format_try_infer_dates=0;
desc file(02404_data.JSONCompactEachRow) settings schema_inference_hints='c1 UInt8';
select count() from system.schema_inference_cache where countSubstrings(source, '02404_data.JSONCompactEachRow') > 0;

select 'Values';
insert into function file(02404_data.Values) select number, toDate(number) from numbers(10);
desc file(02404_data.Values);
desc file(02404_data.Values) settings input_format_try_infer_integers=0;
desc file(02404_data.Values) settings input_format_try_infer_dates=0;
desc file(02404_data.Values) settings schema_inference_hints='c1 UInt8';
select count() from system.schema_inference_cache where countSubstrings(source, '02404_data.Values') > 0;

