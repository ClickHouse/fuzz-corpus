-- Tags: long, no-random-settings

DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;

CREATE TABLE t1 (key UInt32, key1 UInt32, key2 Nullable(UInt32), key3 UInt32, s String) engine = TinyLog;
CREATE TABLE t2 (key UInt32, key1 UInt32, key2 UInt32, key3 Nullable(UInt32), s String) engine = TinyLog;



INSERT INTO t1
    SELECT
        sipHash64(number, 't1') % 15 + 1 as key,
        sipHash64(number, 'x') % 2 + 1 as key1,
        if(number % 5 == 0, NULL, sipHash64(number, 'y') % 2 + 1) as key2,
        sipHash64(number, 'z') % 2 + 1 as key3,
        'val' || toString(number) as s
    FROM numbers_mt(15);

INSERT INTO t2
    SELECT
        sipHash64(number, 't2') % 15 + 1 as key,
        sipHash64(number, 'a') % 2 + 1 as key1,
        sipHash64(number, 'b') % 2 + 1 as key2,
        if(number % 3 == 0, NULL, sipHash64(number, 'c') % 2 + 1) as key3,
        'val' || toString(number) as s
    FROM numbers_mt(12);

SET max_bytes_in_join = '0';

SELECT '-- default --';
SET join_algorithm = 'default';

SET max_block_size = 1;

SELECT 'ALL INNER USING | bs = 1';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ALL INNER | bs = 1';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ALL LEFT | bs = 1';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ALL RIGHT | bs = 1';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ALL INNER | bs = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ALL LEFT | bs = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ALL RIGHT | bs = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 1;

SELECT 'ANY INNER USING | bs = 1';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ANY INNER | bs = 1';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ANY LEFT | bs = 1';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ANY RIGHT | bs = 1';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ANY INNER | bs = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ANY LEFT | bs = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ANY RIGHT | bs = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 5;

SELECT 'ALL INNER USING | bs = 5';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ALL INNER | bs = 5';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ALL LEFT | bs = 5';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ALL RIGHT | bs = 5';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ALL INNER | bs = 5 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ALL LEFT | bs = 5 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ALL RIGHT | bs = 5 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 5;

SELECT 'ANY INNER USING | bs = 5';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ANY INNER | bs = 5';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ANY LEFT | bs = 5';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ANY RIGHT | bs = 5';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ANY INNER | bs = 5 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ANY LEFT | bs = 5 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ANY RIGHT | bs = 5 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 9;

SELECT 'ALL INNER USING | bs = 9';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ALL INNER | bs = 9';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ALL LEFT | bs = 9';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ALL RIGHT | bs = 9';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ALL INNER | bs = 9 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ALL LEFT | bs = 9 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ALL RIGHT | bs = 9 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 9;

SELECT 'ANY INNER USING | bs = 9';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ANY INNER | bs = 9';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ANY LEFT | bs = 9';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ANY RIGHT | bs = 9';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ANY INNER | bs = 9 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ANY LEFT | bs = 9 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ANY RIGHT | bs = 9 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 13;

SELECT 'ALL INNER USING | bs = 13';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ALL INNER | bs = 13';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ALL LEFT | bs = 13';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ALL RIGHT | bs = 13';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ALL INNER | bs = 13 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ALL LEFT | bs = 13 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ALL RIGHT | bs = 13 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 13;

SELECT 'ANY INNER USING | bs = 13';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ANY INNER | bs = 13';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ANY LEFT | bs = 13';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ANY RIGHT | bs = 13';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ANY INNER | bs = 13 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ANY LEFT | bs = 13 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ANY RIGHT | bs = 13 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET join_use_nulls = 1;

SELECT 'ALL INNER | join_use_nulls = 1';
SELECT t1.key, t2.key, isNull(t1.s), isNull(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ALL LEFT | join_use_nulls = 1';
SELECT t1.key, t2.key, t1.s, isNull(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ALL RIGHT | join_use_nulls = 1';
SELECT t1.key, t2.key, isNull(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ALL INNER | join_use_nulls = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ALL LEFT | join_use_nulls = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ALL RIGHT | join_use_nulls = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET join_use_nulls = 0;
SET max_bytes_in_join = 0;

SET join_use_nulls = 1;

SELECT 'ANY INNER | join_use_nulls = 1';
SELECT t1.key, t2.key, isNull(t1.s), isNull(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ANY LEFT | join_use_nulls = 1';
SELECT t1.key, t2.key, t1.s, isNull(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ANY RIGHT | join_use_nulls = 1';
SELECT t1.key, t2.key, isNull(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ANY INNER | join_use_nulls = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ANY LEFT | join_use_nulls = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ANY RIGHT | join_use_nulls = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET join_use_nulls = 0;
SET max_bytes_in_join = 0;

SET max_bytes_in_join = '0';

SELECT '-- full_sorting_merge --';
SET join_algorithm = 'full_sorting_merge';

SET max_block_size = 1;

SELECT 'ALL INNER USING | bs = 1';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ALL INNER | bs = 1';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ALL LEFT | bs = 1';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ALL RIGHT | bs = 1';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ALL INNER | bs = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ALL LEFT | bs = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ALL RIGHT | bs = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 1;

SELECT 'ANY INNER USING | bs = 1';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ANY INNER | bs = 1';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ANY LEFT | bs = 1';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ANY RIGHT | bs = 1';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ANY INNER | bs = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ANY LEFT | bs = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ANY RIGHT | bs = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 5;

SELECT 'ALL INNER USING | bs = 5';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ALL INNER | bs = 5';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ALL LEFT | bs = 5';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ALL RIGHT | bs = 5';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ALL INNER | bs = 5 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ALL LEFT | bs = 5 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ALL RIGHT | bs = 5 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 5;

SELECT 'ANY INNER USING | bs = 5';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ANY INNER | bs = 5';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ANY LEFT | bs = 5';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ANY RIGHT | bs = 5';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ANY INNER | bs = 5 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ANY LEFT | bs = 5 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ANY RIGHT | bs = 5 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 9;

SELECT 'ALL INNER USING | bs = 9';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ALL INNER | bs = 9';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ALL LEFT | bs = 9';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ALL RIGHT | bs = 9';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ALL INNER | bs = 9 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ALL LEFT | bs = 9 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ALL RIGHT | bs = 9 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 9;

SELECT 'ANY INNER USING | bs = 9';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ANY INNER | bs = 9';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ANY LEFT | bs = 9';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ANY RIGHT | bs = 9';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ANY INNER | bs = 9 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ANY LEFT | bs = 9 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ANY RIGHT | bs = 9 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 13;

SELECT 'ALL INNER USING | bs = 13';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ALL INNER | bs = 13';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ALL LEFT | bs = 13';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ALL RIGHT | bs = 13';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ALL INNER | bs = 13 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ALL LEFT | bs = 13 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ALL RIGHT | bs = 13 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 13;

SELECT 'ANY INNER USING | bs = 13';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ANY INNER | bs = 13';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ANY LEFT | bs = 13';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ANY RIGHT | bs = 13';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ANY INNER | bs = 13 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ANY LEFT | bs = 13 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ANY RIGHT | bs = 13 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET join_use_nulls = 1;

SELECT 'ALL INNER | join_use_nulls = 1';
SELECT t1.key, t2.key, isNull(t1.s), isNull(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ALL LEFT | join_use_nulls = 1';
SELECT t1.key, t2.key, t1.s, isNull(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ALL RIGHT | join_use_nulls = 1';
SELECT t1.key, t2.key, isNull(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ALL INNER | join_use_nulls = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ALL LEFT | join_use_nulls = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ALL RIGHT | join_use_nulls = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET join_use_nulls = 0;
SET max_bytes_in_join = 0;

SET join_use_nulls = 1;

SELECT 'ANY INNER | join_use_nulls = 1';
SELECT t1.key, t2.key, isNull(t1.s), isNull(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ANY LEFT | join_use_nulls = 1';
SELECT t1.key, t2.key, t1.s, isNull(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ANY RIGHT | join_use_nulls = 1';
SELECT t1.key, t2.key, isNull(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ANY INNER | join_use_nulls = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ANY LEFT | join_use_nulls = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ANY RIGHT | join_use_nulls = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET join_use_nulls = 0;
SET max_bytes_in_join = 0;

SET max_bytes_in_join = '10K';

SELECT '-- grace_hash --';
SET join_algorithm = 'grace_hash';

SET max_block_size = 1;

SELECT 'ALL INNER USING | bs = 1';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ALL INNER | bs = 1';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ALL LEFT | bs = 1';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ALL RIGHT | bs = 1';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ALL INNER | bs = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ALL LEFT | bs = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ALL RIGHT | bs = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 1;

SELECT 'ANY INNER USING | bs = 1';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ANY INNER | bs = 1';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ANY LEFT | bs = 1';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ANY RIGHT | bs = 1';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ANY INNER | bs = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ANY LEFT | bs = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ANY RIGHT | bs = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 5;

SELECT 'ALL INNER USING | bs = 5';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ALL INNER | bs = 5';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ALL LEFT | bs = 5';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ALL RIGHT | bs = 5';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ALL INNER | bs = 5 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ALL LEFT | bs = 5 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ALL RIGHT | bs = 5 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 5;

SELECT 'ANY INNER USING | bs = 5';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ANY INNER | bs = 5';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ANY LEFT | bs = 5';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ANY RIGHT | bs = 5';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ANY INNER | bs = 5 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ANY LEFT | bs = 5 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ANY RIGHT | bs = 5 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 9;

SELECT 'ALL INNER USING | bs = 9';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ALL INNER | bs = 9';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ALL LEFT | bs = 9';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ALL RIGHT | bs = 9';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ALL INNER | bs = 9 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ALL LEFT | bs = 9 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ALL RIGHT | bs = 9 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 9;

SELECT 'ANY INNER USING | bs = 9';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ANY INNER | bs = 9';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ANY LEFT | bs = 9';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ANY RIGHT | bs = 9';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ANY INNER | bs = 9 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ANY LEFT | bs = 9 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ANY RIGHT | bs = 9 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 13;

SELECT 'ALL INNER USING | bs = 13';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ALL INNER | bs = 13';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ALL LEFT | bs = 13';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ALL RIGHT | bs = 13';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ALL INNER | bs = 13 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ALL LEFT | bs = 13 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ALL RIGHT | bs = 13 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET max_block_size = 13;

SELECT 'ANY INNER USING | bs = 13';
SELECT key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
USING (key)
ORDER BY t1.key, t2.key
;

SELECT 'ANY INNER | bs = 13';
SELECT t1.key, t2.key, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ANY LEFT | bs = 13';
SELECT t1.key, t2.key, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ANY RIGHT | bs = 13';
SELECT t1.key, t2.key, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ANY INNER | bs = 13 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ANY LEFT | bs = 13 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ANY RIGHT | bs = 13 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET join_use_nulls = 1;

SELECT 'ALL INNER | join_use_nulls = 1';
SELECT t1.key, t2.key, isNull(t1.s), isNull(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ALL LEFT | join_use_nulls = 1';
SELECT t1.key, t2.key, t1.s, isNull(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ALL RIGHT | join_use_nulls = 1';
SELECT t1.key, t2.key, isNull(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ALL INNER | join_use_nulls = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ALL INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ALL LEFT | join_use_nulls = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ALL LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ALL RIGHT | join_use_nulls = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ALL RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET join_use_nulls = 0;
SET max_bytes_in_join = 0;

SET join_use_nulls = 1;

SELECT 'ANY INNER | join_use_nulls = 1';
SELECT t1.key, t2.key, isNull(t1.s), isNull(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key
;

SELECT 'ANY LEFT | join_use_nulls = 1';
SELECT t1.key, t2.key, t1.s, isNull(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t1.s
;

SELECT 'ANY RIGHT | join_use_nulls = 1';
SELECT t1.key, t2.key, isNull(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key == t2.key
ORDER BY t1.key, t2.key, t2.s
; 

SELECT 'ANY INNER | join_use_nulls = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), empty(t2.s) FROM t1
ANY INNER JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3
;

SELECT 'ANY LEFT | join_use_nulls = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s, empty(t2.s) FROM t1
ANY LEFT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t1.s
;

SELECT 'ANY RIGHT | join_use_nulls = 1 | copmosite key';
SELECT t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, empty(t1.s), t2.s FROM t1
ANY RIGHT JOIN t2
ON t1.key1 == t2.key1 AND t1.key2 == t2.key2 AND t1.key3 == t2.key3 AND t1.key1 == t2.key3
ORDER BY t1.key1, t1.key2, t1.key3, t2.key1, t2.key2, t2.key3, t2.s
; 

SET join_use_nulls = 0;
SET max_bytes_in_join = 0;

DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
