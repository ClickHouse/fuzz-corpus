-- Tags: long, no-debug, no-asan, no-tsan, no-msan

DROP TABLE IF EXISTS xxxx_1;
DROP TABLE IF EXISTS xxxx_2;
DROP TABLE IF EXISTS xxxx_3;
DROP TABLE IF EXISTS xxxx_4;
DROP TABLE IF EXISTS xxxx_5;

CREATE TABLE xxxx_1 (key UInt32, ts DateTime64(3)) ENGINE=MergeTree ORDER BY (toDate(ts));
CREATE TABLE xxxx_2 (key UInt32, ts DateTime64(3)) ENGINE=MergeTree ORDER BY (toDate(ts), ts);
CREATE TABLE xxxx_3 (key UInt32, ts DateTime64(3)) ENGINE=MergeTree ORDER BY (toDate(toDateTime(ts)), ts);
CREATE TABLE xxxx_4 (`key` UInt32, `ts` DateTime64(3)) ENGINE = MergeTree ORDER BY (toDate(ts), key);
CREATE TABLE xxxx_5 (`key` UInt32, `ts` DateTime64(3)) ENGINE = MergeTree ORDER BY (toDate(ts), key, ts);

INSERT INTO xxxx_1 SELECT 1, toDateTime64('2021-08-24 18:00:00', 3) + number/1000 FROM numbers_mt(100000000);
INSERT INTO xxxx_2 SELECT 1, toDateTime64('2021-08-24 18:00:00', 3) + number/1000 FROM numbers_mt(100000000);
INSERT INTO xxxx_3 SELECT 1, toDateTime64('2021-08-24 18:00:00', 3) + number/1000 FROM numbers_mt(100000000);
INSERT INTO xxxx_4 SELECT number, toDateTime64('2021-08-24 18:00:00', 3) + number/500 FROM numbers_mt(100000000);
INSERT INTO xxxx_5 SELECT number, toDateTime64('2021-08-24 18:00:00', 3) + number/500 FROM numbers_mt(100000000);

SET max_rows_to_read = 90000000, force_primary_key = 1;

SELECT count() FROM xxxx_1 WHERE (ts >= '2021-08-24 18:10:00') AND (ts < '2021-08-24 18:40:00');
SELECT count() FROM xxxx_2 WHERE (ts >= '2021-08-24 18:10:00') AND (ts < '2021-08-24 18:40:00');
SELECT count() FROM xxxx_3 WHERE (ts >= '2021-08-24 18:10:00') AND (ts < '2021-08-24 18:40:00');
SELECT count() FROM xxxx_4 WHERE (ts >= '2021-08-24 18:10:00') AND (ts < '2021-08-24 18:40:00');
SELECT count() FROM xxxx_5 WHERE (ts >= '2021-08-24 18:10:00') AND (ts < '2021-08-24 18:40:00');

DROP TABLE xxxx_1;
DROP TABLE xxxx_2;
DROP TABLE xxxx_3;
DROP TABLE xxxx_4;
DROP TABLE xxxx_5;
