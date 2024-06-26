DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;

CREATE TABLE t1 (`a` Int64, `b` Int64) ENGINE = MergeTree() ORDER BY a;
CREATE TABLE t2 (`key` Int32, `val` Int64) ENGINE = MergeTree() ORDER BY key;

INSERT INTO t1 SELECT number + 500 as a, -a as b from numbers(1000);
INSERT INTO t2 SELECT if(number % 2 == 0, toInt64(number), -number) as key, number as val from numbers(1000);

SET max_block_size = 99;

SET join_use_nulls = 1;

SELECT count() == 500 AND count(a) == 500 AND sum(a) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 INNER JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(val) == 500 AND sum(val) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 LEFT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(a) == 500 AND sum(val) == 999 * 1000 / 2  FROM (
    SELECT * FROM t1 RIGHT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1500 AND count(a) == 1000 AND count(val) = 1000 AND sum(val) == 999 * 1000 / 2 AND sum(a) == 1999 * 1000 / 2 FROM (
    SELECT a, b, val FROM t1 FULL JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SET join_use_nulls = 0;

SELECT count() == 500 AND count(a) == 500 AND sum(a) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 INNER JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(val) == 1000 AND sum(val) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 LEFT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(a) == 1000 AND sum(val) == 999 * 1000 / 2  FROM (
    SELECT * FROM t1 RIGHT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1500 AND count(a) == 1500 AND count(val) = 1500 AND sum(val) == 999 * 1000 / 2 AND sum(a) == 1999 * 1000 / 2 FROM (
    SELECT a, b, val FROM t1 FULL JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);


SET max_block_size = 100;

SET join_use_nulls = 1;

SELECT count() == 500 AND count(a) == 500 AND sum(a) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 INNER JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(val) == 500 AND sum(val) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 LEFT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(a) == 500 AND sum(val) == 999 * 1000 / 2  FROM (
    SELECT * FROM t1 RIGHT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1500 AND count(a) == 1000 AND count(val) = 1000 AND sum(val) == 999 * 1000 / 2 AND sum(a) == 1999 * 1000 / 2 FROM (
    SELECT a, b, val FROM t1 FULL JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SET join_use_nulls = 0;

SELECT count() == 500 AND count(a) == 500 AND sum(a) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 INNER JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(val) == 1000 AND sum(val) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 LEFT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(a) == 1000 AND sum(val) == 999 * 1000 / 2  FROM (
    SELECT * FROM t1 RIGHT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1500 AND count(a) == 1500 AND count(val) = 1500 AND sum(val) == 999 * 1000 / 2 AND sum(a) == 1999 * 1000 / 2 FROM (
    SELECT a, b, val FROM t1 FULL JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);


SET max_block_size = 101;

SET join_use_nulls = 1;

SELECT count() == 500 AND count(a) == 500 AND sum(a) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 INNER JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(val) == 500 AND sum(val) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 LEFT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(a) == 500 AND sum(val) == 999 * 1000 / 2  FROM (
    SELECT * FROM t1 RIGHT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1500 AND count(a) == 1000 AND count(val) = 1000 AND sum(val) == 999 * 1000 / 2 AND sum(a) == 1999 * 1000 / 2 FROM (
    SELECT a, b, val FROM t1 FULL JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SET join_use_nulls = 0;

SELECT count() == 500 AND count(a) == 500 AND sum(a) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 INNER JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(val) == 1000 AND sum(val) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 LEFT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(a) == 1000 AND sum(val) == 999 * 1000 / 2  FROM (
    SELECT * FROM t1 RIGHT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1500 AND count(a) == 1500 AND count(val) = 1500 AND sum(val) == 999 * 1000 / 2 AND sum(a) == 1999 * 1000 / 2 FROM (
    SELECT a, b, val FROM t1 FULL JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);


SET max_block_size = 127;

SET join_use_nulls = 1;

SELECT count() == 500 AND count(a) == 500 AND sum(a) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 INNER JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(val) == 500 AND sum(val) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 LEFT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(a) == 500 AND sum(val) == 999 * 1000 / 2  FROM (
    SELECT * FROM t1 RIGHT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1500 AND count(a) == 1000 AND count(val) = 1000 AND sum(val) == 999 * 1000 / 2 AND sum(a) == 1999 * 1000 / 2 FROM (
    SELECT a, b, val FROM t1 FULL JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SET join_use_nulls = 0;

SELECT count() == 500 AND count(a) == 500 AND sum(a) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 INNER JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(val) == 1000 AND sum(val) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 LEFT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(a) == 1000 AND sum(val) == 999 * 1000 / 2  FROM (
    SELECT * FROM t1 RIGHT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1500 AND count(a) == 1500 AND count(val) = 1500 AND sum(val) == 999 * 1000 / 2 AND sum(a) == 1999 * 1000 / 2 FROM (
    SELECT a, b, val FROM t1 FULL JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);


SET max_block_size = 128;

SET join_use_nulls = 1;

SELECT count() == 500 AND count(a) == 500 AND sum(a) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 INNER JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(val) == 500 AND sum(val) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 LEFT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(a) == 500 AND sum(val) == 999 * 1000 / 2  FROM (
    SELECT * FROM t1 RIGHT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1500 AND count(a) == 1000 AND count(val) = 1000 AND sum(val) == 999 * 1000 / 2 AND sum(a) == 1999 * 1000 / 2 FROM (
    SELECT a, b, val FROM t1 FULL JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SET join_use_nulls = 0;

SELECT count() == 500 AND count(a) == 500 AND sum(a) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 INNER JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(val) == 1000 AND sum(val) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 LEFT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(a) == 1000 AND sum(val) == 999 * 1000 / 2  FROM (
    SELECT * FROM t1 RIGHT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1500 AND count(a) == 1500 AND count(val) = 1500 AND sum(val) == 999 * 1000 / 2 AND sum(a) == 1999 * 1000 / 2 FROM (
    SELECT a, b, val FROM t1 FULL JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);


SET max_block_size = 129;

SET join_use_nulls = 1;

SELECT count() == 500 AND count(a) == 500 AND sum(a) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 INNER JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(val) == 500 AND sum(val) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 LEFT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(a) == 500 AND sum(val) == 999 * 1000 / 2  FROM (
    SELECT * FROM t1 RIGHT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1500 AND count(a) == 1000 AND count(val) = 1000 AND sum(val) == 999 * 1000 / 2 AND sum(a) == 1999 * 1000 / 2 FROM (
    SELECT a, b, val FROM t1 FULL JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SET join_use_nulls = 0;

SELECT count() == 500 AND count(a) == 500 AND sum(a) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 INNER JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(val) == 1000 AND sum(val) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 LEFT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(a) == 1000 AND sum(val) == 999 * 1000 / 2  FROM (
    SELECT * FROM t1 RIGHT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1500 AND count(a) == 1500 AND count(val) = 1500 AND sum(val) == 999 * 1000 / 2 AND sum(a) == 1999 * 1000 / 2 FROM (
    SELECT a, b, val FROM t1 FULL JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);


SET max_block_size = 256;

SET join_use_nulls = 1;

SELECT count() == 500 AND count(a) == 500 AND sum(a) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 INNER JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(val) == 500 AND sum(val) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 LEFT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(a) == 500 AND sum(val) == 999 * 1000 / 2  FROM (
    SELECT * FROM t1 RIGHT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1500 AND count(a) == 1000 AND count(val) = 1000 AND sum(val) == 999 * 1000 / 2 AND sum(a) == 1999 * 1000 / 2 FROM (
    SELECT a, b, val FROM t1 FULL JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SET join_use_nulls = 0;

SELECT count() == 500 AND count(a) == 500 AND sum(a) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 INNER JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(val) == 1000 AND sum(val) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 LEFT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(a) == 1000 AND sum(val) == 999 * 1000 / 2  FROM (
    SELECT * FROM t1 RIGHT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1500 AND count(a) == 1500 AND count(val) = 1500 AND sum(val) == 999 * 1000 / 2 AND sum(a) == 1999 * 1000 / 2 FROM (
    SELECT a, b, val FROM t1 FULL JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);


SET max_block_size = 2048;

SET join_use_nulls = 1;

SELECT count() == 500 AND count(a) == 500 AND sum(a) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 INNER JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(val) == 500 AND sum(val) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 LEFT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(a) == 500 AND sum(val) == 999 * 1000 / 2  FROM (
    SELECT * FROM t1 RIGHT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1500 AND count(a) == 1000 AND count(val) = 1000 AND sum(val) == 999 * 1000 / 2 AND sum(a) == 1999 * 1000 / 2 FROM (
    SELECT a, b, val FROM t1 FULL JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SET join_use_nulls = 0;

SELECT count() == 500 AND count(a) == 500 AND sum(a) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 INNER JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(val) == 1000 AND sum(val) == 1499 * 500 / 2 FROM (
    SELECT a, b, val FROM t1 LEFT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1000 AND count(a) == 1000 AND sum(val) == 999 * 1000 / 2  FROM (
    SELECT * FROM t1 RIGHT JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);

SELECT count() == 1500 AND count(a) == 1500 AND count(val) = 1500 AND sum(val) == 999 * 1000 / 2 AND sum(a) == 1999 * 1000 / 2 FROM (
    SELECT a, b, val FROM t1 FULL JOIN t2 ON t1.a = t2.key OR t1.b = t2.key);



