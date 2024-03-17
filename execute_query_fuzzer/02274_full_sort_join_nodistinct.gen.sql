-- Tags: long

DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP TABLE IF EXISTS tn1;
DROP TABLE IF EXISTS tn2;

CREATE TABLE t1 (key UInt32, s String) engine = TinyLog;
CREATE TABLE tn1 (key Nullable(UInt32), s String) engine = TinyLog;
CREATE TABLE t2 (key UInt32, s String) engine = TinyLog;
CREATE TABLE tn2 (key Nullable(UInt32), s String) engine = TinyLog;

INSERT INTO t1 VALUES (1, 'val1'), (2, 'val21'), (2, 'val22'), (2, 'val23'), (2, 'val24'), (2, 'val25'), (2, 'val26'), (2, 'val27'), (3, 'val3');
INSERT INTO tn1 VALUES (1, 'val1'), (NULL, 'val21'), (NULL, 'val22'), (NULL, 'val23'), (NULL, 'val24'), (NULL, 'val25'), (NULL, 'val26'), (NULL, 'val27'), (3, 'val3');
INSERT INTO t2 VALUES (1, 'val11'), (1, 'val12'), (2, 'val22'), (2, 'val23'), (2, 'val24'), (2, 'val25'), (2, 'val26'), (2, 'val27'), (2, 'val28'), (3, 'val3');
INSERT INTO tn2 VALUES (1, 'val11'), (1, 'val12'), (NULL, 'val22'), (NULL, 'val23'), (NULL, 'val24'), (NULL, 'val25'), (NULL, 'val26'), (NULL, 'val27'), (NULL, 'val28'), (3, 'val3');

SET max_bytes_in_join = '0';

SET join_algorithm = 'full_sorting_merge';

SELECT '--- full_sorting_merge ---';

SET max_block_size = 1;

SELECT 't1 ALL INNER JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ALL LEFT JOIN t2 | bs = 1';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ALL LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ALL RIGHT JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ALL RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ANY INNER JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ANY INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ANY LEFT JOIN t2 | bs = 1';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ANY LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ANY RIGHT JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ANY RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ALL FULL JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1  FULL JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 't1 ALL FULL JOIN USING t2 | bs = 1';
SELECT key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL FULL JOIN t2 AS t2 USING (key) ORDER BY key, length(t1.s), length(t2.s); 
SELECT 't1 ALL INNER JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ALL LEFT JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ALL LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ALL RIGHT JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ALL RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ANY INNER JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ANY INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ANY LEFT JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ANY LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ANY RIGHT JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ANY RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ALL FULL JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1  FULL JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 't1 ALL FULL JOIN USING tn2 | bs = 1';
SELECT key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL FULL JOIN tn2 AS t2 USING (key) ORDER BY key, length(t1.s), length(t2.s); 
SELECT 'tn1 ALL INNER JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ALL LEFT JOIN t2 | bs = 1';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ALL LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ALL RIGHT JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ALL RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ANY INNER JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ANY INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ANY LEFT JOIN t2 | bs = 1';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ANY LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ANY RIGHT JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ANY RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ALL FULL JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1  FULL JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 'tn1 ALL FULL JOIN USING t2 | bs = 1';
SELECT key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL FULL JOIN t2 AS t2 USING (key) ORDER BY key, length(t1.s), length(t2.s); 
SELECT 'tn1 ALL INNER JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ALL LEFT JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ALL LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ALL RIGHT JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ALL RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ANY INNER JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ANY INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ANY LEFT JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ANY LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ANY RIGHT JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ANY RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ALL FULL JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1  FULL JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 'tn1 ALL FULL JOIN USING tn2 | bs = 1';
SELECT key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL FULL JOIN tn2 AS t2 USING (key) ORDER BY key, length(t1.s), length(t2.s); 
SET max_block_size = 5;

SELECT 't1 ALL INNER JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ALL LEFT JOIN t2 | bs = 5';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ALL LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ALL RIGHT JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ALL RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ANY INNER JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ANY INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ANY LEFT JOIN t2 | bs = 5';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ANY LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ANY RIGHT JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ANY RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ALL FULL JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1  FULL JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 't1 ALL FULL JOIN USING t2 | bs = 5';
SELECT key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL FULL JOIN t2 AS t2 USING (key) ORDER BY key, length(t1.s), length(t2.s); 
SELECT 't1 ALL INNER JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ALL LEFT JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ALL LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ALL RIGHT JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ALL RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ANY INNER JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ANY INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ANY LEFT JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ANY LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ANY RIGHT JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ANY RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ALL FULL JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1  FULL JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 't1 ALL FULL JOIN USING tn2 | bs = 5';
SELECT key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL FULL JOIN tn2 AS t2 USING (key) ORDER BY key, length(t1.s), length(t2.s); 
SELECT 'tn1 ALL INNER JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ALL LEFT JOIN t2 | bs = 5';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ALL LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ALL RIGHT JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ALL RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ANY INNER JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ANY INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ANY LEFT JOIN t2 | bs = 5';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ANY LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ANY RIGHT JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ANY RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ALL FULL JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1  FULL JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 'tn1 ALL FULL JOIN USING t2 | bs = 5';
SELECT key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL FULL JOIN t2 AS t2 USING (key) ORDER BY key, length(t1.s), length(t2.s); 
SELECT 'tn1 ALL INNER JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ALL LEFT JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ALL LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ALL RIGHT JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ALL RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ANY INNER JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ANY INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ANY LEFT JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ANY LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ANY RIGHT JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ANY RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ALL FULL JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1  FULL JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 'tn1 ALL FULL JOIN USING tn2 | bs = 5';
SELECT key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL FULL JOIN tn2 AS t2 USING (key) ORDER BY key, length(t1.s), length(t2.s); 
SET max_block_size = 9;

SELECT 't1 ALL INNER JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ALL LEFT JOIN t2 | bs = 9';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ALL LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ALL RIGHT JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ALL RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ANY INNER JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ANY INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ANY LEFT JOIN t2 | bs = 9';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ANY LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ANY RIGHT JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ANY RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ALL FULL JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1  FULL JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 't1 ALL FULL JOIN USING t2 | bs = 9';
SELECT key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL FULL JOIN t2 AS t2 USING (key) ORDER BY key, length(t1.s), length(t2.s); 
SELECT 't1 ALL INNER JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ALL LEFT JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ALL LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ALL RIGHT JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ALL RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ANY INNER JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ANY INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ANY LEFT JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ANY LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ANY RIGHT JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ANY RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ALL FULL JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1  FULL JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 't1 ALL FULL JOIN USING tn2 | bs = 9';
SELECT key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL FULL JOIN tn2 AS t2 USING (key) ORDER BY key, length(t1.s), length(t2.s); 
SELECT 'tn1 ALL INNER JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ALL LEFT JOIN t2 | bs = 9';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ALL LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ALL RIGHT JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ALL RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ANY INNER JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ANY INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ANY LEFT JOIN t2 | bs = 9';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ANY LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ANY RIGHT JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ANY RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ALL FULL JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1  FULL JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 'tn1 ALL FULL JOIN USING t2 | bs = 9';
SELECT key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL FULL JOIN t2 AS t2 USING (key) ORDER BY key, length(t1.s), length(t2.s); 
SELECT 'tn1 ALL INNER JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ALL LEFT JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ALL LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ALL RIGHT JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ALL RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ANY INNER JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ANY INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ANY LEFT JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ANY LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ANY RIGHT JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ANY RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ALL FULL JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1  FULL JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 'tn1 ALL FULL JOIN USING tn2 | bs = 9';
SELECT key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL FULL JOIN tn2 AS t2 USING (key) ORDER BY key, length(t1.s), length(t2.s); 
SET max_bytes_in_join = 0;

SET max_bytes_in_join = '10K';

SET join_algorithm = 'grace_hash';

SELECT '--- grace_hash ---';

SET max_block_size = 1;

SELECT 't1 ALL INNER JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ALL LEFT JOIN t2 | bs = 1';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ALL LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ALL RIGHT JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ALL RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ANY INNER JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ANY INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ANY LEFT JOIN t2 | bs = 1';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ANY LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ANY RIGHT JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ANY RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ALL FULL JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1  FULL JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 't1 ALL FULL JOIN USING t2 | bs = 1';
SELECT key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL FULL JOIN t2 AS t2 USING (key) ORDER BY key, length(t1.s), length(t2.s); 
SELECT 't1 ALL INNER JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ALL LEFT JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ALL LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ALL RIGHT JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ALL RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ANY INNER JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ANY INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ANY LEFT JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ANY LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ANY RIGHT JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ANY RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ALL FULL JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1  FULL JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 'tn1 ALL INNER JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ALL LEFT JOIN t2 | bs = 1';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ALL LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ALL RIGHT JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ALL RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ANY INNER JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ANY INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ANY LEFT JOIN t2 | bs = 1';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ANY LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ANY RIGHT JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ANY RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ALL FULL JOIN t2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1  FULL JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 'tn1 ALL FULL JOIN USING t2 | bs = 1';
SELECT key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL FULL JOIN t2 AS t2 USING (key) ORDER BY key, length(t1.s), length(t2.s); 
SELECT 'tn1 ALL INNER JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ALL LEFT JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ALL LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ALL RIGHT JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ALL RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ANY INNER JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ANY INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ANY LEFT JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ANY LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ANY RIGHT JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ANY RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ALL FULL JOIN tn2 | bs = 1';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1  FULL JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SET max_block_size = 5;

SELECT 't1 ALL INNER JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ALL LEFT JOIN t2 | bs = 5';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ALL LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ALL RIGHT JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ALL RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ANY INNER JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ANY INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ANY LEFT JOIN t2 | bs = 5';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ANY LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ANY RIGHT JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ANY RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ALL FULL JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1  FULL JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 't1 ALL FULL JOIN USING t2 | bs = 5';
SELECT key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL FULL JOIN t2 AS t2 USING (key) ORDER BY key, length(t1.s), length(t2.s); 
SELECT 't1 ALL INNER JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ALL LEFT JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ALL LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ALL RIGHT JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ALL RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ANY INNER JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ANY INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ANY LEFT JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ANY LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ANY RIGHT JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ANY RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ALL FULL JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1  FULL JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 'tn1 ALL INNER JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ALL LEFT JOIN t2 | bs = 5';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ALL LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ALL RIGHT JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ALL RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ANY INNER JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ANY INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ANY LEFT JOIN t2 | bs = 5';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ANY LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ANY RIGHT JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ANY RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ALL FULL JOIN t2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1  FULL JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 'tn1 ALL FULL JOIN USING t2 | bs = 5';
SELECT key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL FULL JOIN t2 AS t2 USING (key) ORDER BY key, length(t1.s), length(t2.s); 
SELECT 'tn1 ALL INNER JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ALL LEFT JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ALL LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ALL RIGHT JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ALL RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ANY INNER JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ANY INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ANY LEFT JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ANY LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ANY RIGHT JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ANY RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ALL FULL JOIN tn2 | bs = 5';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1  FULL JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SET max_block_size = 9;

SELECT 't1 ALL INNER JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ALL LEFT JOIN t2 | bs = 9';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ALL LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ALL RIGHT JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ALL RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ANY INNER JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ANY INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ANY LEFT JOIN t2 | bs = 9';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ANY LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ANY RIGHT JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ANY RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ALL FULL JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1  FULL JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 't1 ALL FULL JOIN USING t2 | bs = 9';
SELECT key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL FULL JOIN t2 AS t2 USING (key) ORDER BY key, length(t1.s), length(t2.s); 
SELECT 't1 ALL INNER JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ALL INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ALL LEFT JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ALL LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ALL RIGHT JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ALL RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ANY INNER JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1 ANY INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 't1 ANY LEFT JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM t1 AS t1 ANY LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 't1 ANY RIGHT JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM t1 AS t1 ANY RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 't1 ALL FULL JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM t1 AS t1  FULL JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 'tn1 ALL INNER JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ALL LEFT JOIN t2 | bs = 9';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ALL LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ALL RIGHT JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ALL RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ANY INNER JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ANY INNER JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ANY LEFT JOIN t2 | bs = 9';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ANY LEFT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ANY RIGHT JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ANY RIGHT JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ALL FULL JOIN t2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1  FULL JOIN t2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SELECT 'tn1 ALL FULL JOIN USING t2 | bs = 9';
SELECT key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL FULL JOIN t2 AS t2 USING (key) ORDER BY key, length(t1.s), length(t2.s); 
SELECT 'tn1 ALL INNER JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ALL INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ALL LEFT JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ALL LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ALL RIGHT JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ALL RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ANY INNER JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1 ANY INNER JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key;

SELECT 'tn1 ANY LEFT JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, t1.s, length(t2.s) FROM tn1 AS t1 ANY LEFT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t1.s;

SELECT 'tn1 ANY RIGHT JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), t2.s FROM tn1 AS t1 ANY RIGHT JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, t2.s; 

SELECT 'tn1 ALL FULL JOIN tn2 | bs = 9';
SELECT t1.key, t2.key, length(t1.s), length(t2.s) FROM tn1 AS t1  FULL JOIN tn2 AS t2 ON t1.key == t2.key ORDER BY t1.key, t2.key, length(t1.s), length(t2.s); 

SET max_bytes_in_join = 0;

DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP TABLE IF EXISTS tn1;
DROP TABLE IF EXISTS tn2;
