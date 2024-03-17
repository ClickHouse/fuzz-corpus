-- Tags: long, no-tsan, no-asan, no-ubsan, no-msan, no-debug
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;

CREATE TABLE t1 (key UInt32, s String) ENGINE = MergeTree ORDER BY key SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
CREATE TABLE t2 (key UInt32, s String) ENGINE = MergeTree ORDER BY key SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';

INSERT INTO t1
    SELECT
        sipHash64(number, 'x') % 10000000 + 1 as key,
        'val' || toString(number) as s
    FROM numbers_mt(10000000)
;

INSERT INTO t2
    SELECT
        sipHash64(number, 'y') % 1000000 + 1 as key,
        'val' || toString(number) as s
    FROM numbers_mt(1000000)
;


SET max_bytes_in_join = '0';

SELECT '-- full_sorting_merge --';
SET join_algorithm = 'full_sorting_merge';



SET max_block_size = 10240;


SELECT 'ALL INNER';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
;

SELECT 'ALL LEFT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
;

SELECT 'ALL RIGHT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
;




SET max_block_size = 32001;


SELECT 'ALL INNER';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
;

SELECT 'ALL LEFT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
;

SELECT 'ALL RIGHT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
;




SET max_block_size = 65536;


SELECT 'ALL INNER';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
;

SELECT 'ALL LEFT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
;

SELECT 'ALL RIGHT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
;




SET max_block_size = 10240;


SELECT 'ANY INNER';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
;

SELECT 'ANY LEFT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
;

SELECT 'ANY RIGHT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
;




SET max_block_size = 32001;


SELECT 'ANY INNER';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
;

SELECT 'ANY LEFT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
;

SELECT 'ANY RIGHT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
;




SET max_block_size = 65536;


SELECT 'ANY INNER';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
;

SELECT 'ANY LEFT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
;

SELECT 'ANY RIGHT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
;


SET max_bytes_in_join = 0;

SET max_bytes_in_join = '16M';

SELECT '-- grace_hash --';
SET join_algorithm = 'grace_hash';



SET max_block_size = 10240;


SELECT 'ALL INNER';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
;

SELECT 'ALL LEFT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
;

SELECT 'ALL RIGHT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
;




SET max_block_size = 32001;


SELECT 'ALL INNER';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
;

SELECT 'ALL LEFT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
;

SELECT 'ALL RIGHT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
;




SET max_block_size = 65536;


SELECT 'ALL INNER';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
;

SELECT 'ALL LEFT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
;

SELECT 'ALL RIGHT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
;




SET max_block_size = 10240;


SELECT 'ANY INNER';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
;

SELECT 'ANY LEFT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
;

SELECT 'ANY RIGHT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
;




SET max_block_size = 32001;


SELECT 'ANY INNER';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
;

SELECT 'ANY LEFT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
;

SELECT 'ANY RIGHT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
;




SET max_block_size = 65536;


SELECT 'ANY INNER';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
;

SELECT 'ANY LEFT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
;

SELECT 'ANY RIGHT';
SELECT sum(t1.key), sum(t2.key), count(), countIf(t1.key != 0), countIf(t2.key != 0) FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
;


SET max_bytes_in_join = 0;

