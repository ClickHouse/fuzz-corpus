-- Tags: use-rocksdb, long

SET join_algorithm = 'direct';

DROP TABLE IF EXISTS rdb_10;
DROP TABLE IF EXISTS rdb_65555;
DROP TABLE IF EXISTS rdb_100000;
CREATE TABLE rdb_10 (key UInt64, value String) ENGINE = EmbeddedRocksDB PRIMARY KEY (key);
INSERT INTO rdb_10
    SELECT (sipHash64(number) % 10) as key, ('val' || toString(key)) AS value
    FROM numbers_mt(10);

SET max_block_size = 10;

SELECT count() == (SELECT count() FROM rdb_10 WHERE key < 5)
FROM (SELECT number as k FROM numbers_mt(5)) as t1
INNER JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == 5 and countIf(value != '') == (SELECT count() FROM rdb_10 WHERE key < 5)
FROM (SELECT number as k FROM numbers_mt(5)) as t1
LEFT JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == (SELECT count() FROM rdb_10 WHERE key < 13)
FROM (SELECT number as k FROM numbers_mt(13)) as t1
INNER JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == 13 and countIf(value != '') == (SELECT count() FROM rdb_10 WHERE key < 13)
FROM (SELECT number as k FROM numbers_mt(13)) as t1
LEFT JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SET max_block_size = 11;

SELECT count() == (SELECT count() FROM rdb_10 WHERE key < 5)
FROM (SELECT number as k FROM numbers_mt(5)) as t1
INNER JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == 5 and countIf(value != '') == (SELECT count() FROM rdb_10 WHERE key < 5)
FROM (SELECT number as k FROM numbers_mt(5)) as t1
LEFT JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == (SELECT count() FROM rdb_10 WHERE key < 13)
FROM (SELECT number as k FROM numbers_mt(13)) as t1
INNER JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == 13 and countIf(value != '') == (SELECT count() FROM rdb_10 WHERE key < 13)
FROM (SELECT number as k FROM numbers_mt(13)) as t1
LEFT JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SET max_block_size = 128;

SELECT count() == (SELECT count() FROM rdb_10 WHERE key < 5)
FROM (SELECT number as k FROM numbers_mt(5)) as t1
INNER JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == 5 and countIf(value != '') == (SELECT count() FROM rdb_10 WHERE key < 5)
FROM (SELECT number as k FROM numbers_mt(5)) as t1
LEFT JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == (SELECT count() FROM rdb_10 WHERE key < 13)
FROM (SELECT number as k FROM numbers_mt(13)) as t1
INNER JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == 13 and countIf(value != '') == (SELECT count() FROM rdb_10 WHERE key < 13)
FROM (SELECT number as k FROM numbers_mt(13)) as t1
LEFT JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SET max_block_size = 129;

SELECT count() == (SELECT count() FROM rdb_10 WHERE key < 5)
FROM (SELECT number as k FROM numbers_mt(5)) as t1
INNER JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == 5 and countIf(value != '') == (SELECT count() FROM rdb_10 WHERE key < 5)
FROM (SELECT number as k FROM numbers_mt(5)) as t1
LEFT JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == (SELECT count() FROM rdb_10 WHERE key < 13)
FROM (SELECT number as k FROM numbers_mt(13)) as t1
INNER JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == 13 and countIf(value != '') == (SELECT count() FROM rdb_10 WHERE key < 13)
FROM (SELECT number as k FROM numbers_mt(13)) as t1
LEFT JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SET max_block_size = 65505;

SELECT count() == (SELECT count() FROM rdb_10 WHERE key < 5)
FROM (SELECT number as k FROM numbers_mt(5)) as t1
INNER JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == 5 and countIf(value != '') == (SELECT count() FROM rdb_10 WHERE key < 5)
FROM (SELECT number as k FROM numbers_mt(5)) as t1
LEFT JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == (SELECT count() FROM rdb_10 WHERE key < 13)
FROM (SELECT number as k FROM numbers_mt(13)) as t1
INNER JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == 13 and countIf(value != '') == (SELECT count() FROM rdb_10 WHERE key < 13)
FROM (SELECT number as k FROM numbers_mt(13)) as t1
LEFT JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SET max_block_size = 65506;

SELECT count() == (SELECT count() FROM rdb_10 WHERE key < 5)
FROM (SELECT number as k FROM numbers_mt(5)) as t1
INNER JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == 5 and countIf(value != '') == (SELECT count() FROM rdb_10 WHERE key < 5)
FROM (SELECT number as k FROM numbers_mt(5)) as t1
LEFT JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == (SELECT count() FROM rdb_10 WHERE key < 13)
FROM (SELECT number as k FROM numbers_mt(13)) as t1
INNER JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == 13 and countIf(value != '') == (SELECT count() FROM rdb_10 WHERE key < 13)
FROM (SELECT number as k FROM numbers_mt(13)) as t1
LEFT JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SET max_block_size = 70000;

SELECT count() == (SELECT count() FROM rdb_10 WHERE key < 5)
FROM (SELECT number as k FROM numbers_mt(5)) as t1
INNER JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == 5 and countIf(value != '') == (SELECT count() FROM rdb_10 WHERE key < 5)
FROM (SELECT number as k FROM numbers_mt(5)) as t1
LEFT JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == (SELECT count() FROM rdb_10 WHERE key < 13)
FROM (SELECT number as k FROM numbers_mt(13)) as t1
INNER JOIN rdb_10 as rdb
ON rdb.key == t1.k;

SELECT count() == 13 and countIf(value != '') == (SELECT count() FROM rdb_10 WHERE key < 13)
FROM (SELECT number as k FROM numbers_mt(13)) as t1
LEFT JOIN rdb_10 as rdb
ON rdb.key == t1.k;

CREATE TABLE rdb_65555 (key UInt64, value String) ENGINE = EmbeddedRocksDB PRIMARY KEY (key);
INSERT INTO rdb_65555
    SELECT (sipHash64(number) % 65555) as key, ('val' || toString(key)) AS value
    FROM numbers_mt(65555);

SET max_block_size = 128;

SELECT count() == (SELECT count() FROM rdb_65555 WHERE key < 32777)
FROM (SELECT number as k FROM numbers_mt(32777)) as t1
INNER JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

SELECT count() == 32777 and countIf(value != '') == (SELECT count() FROM rdb_65555 WHERE key < 32777)
FROM (SELECT number as k FROM numbers_mt(32777)) as t1
LEFT JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

SELECT count() == (SELECT count() FROM rdb_65555 WHERE key < 81944)
FROM (SELECT number as k FROM numbers_mt(81944)) as t1
INNER JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

SELECT count() == 81944 and countIf(value != '') == (SELECT count() FROM rdb_65555 WHERE key < 81944)
FROM (SELECT number as k FROM numbers_mt(81944)) as t1
LEFT JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

SET max_block_size = 129;

SELECT count() == (SELECT count() FROM rdb_65555 WHERE key < 32777)
FROM (SELECT number as k FROM numbers_mt(32777)) as t1
INNER JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

SELECT count() == 32777 and countIf(value != '') == (SELECT count() FROM rdb_65555 WHERE key < 32777)
FROM (SELECT number as k FROM numbers_mt(32777)) as t1
LEFT JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

SELECT count() == (SELECT count() FROM rdb_65555 WHERE key < 81944)
FROM (SELECT number as k FROM numbers_mt(81944)) as t1
INNER JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

SELECT count() == 81944 and countIf(value != '') == (SELECT count() FROM rdb_65555 WHERE key < 81944)
FROM (SELECT number as k FROM numbers_mt(81944)) as t1
LEFT JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

SET max_block_size = 65505;

SELECT count() == (SELECT count() FROM rdb_65555 WHERE key < 32777)
FROM (SELECT number as k FROM numbers_mt(32777)) as t1
INNER JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

SELECT count() == 32777 and countIf(value != '') == (SELECT count() FROM rdb_65555 WHERE key < 32777)
FROM (SELECT number as k FROM numbers_mt(32777)) as t1
LEFT JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

SELECT count() == (SELECT count() FROM rdb_65555 WHERE key < 81944)
FROM (SELECT number as k FROM numbers_mt(81944)) as t1
INNER JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

SELECT count() == 81944 and countIf(value != '') == (SELECT count() FROM rdb_65555 WHERE key < 81944)
FROM (SELECT number as k FROM numbers_mt(81944)) as t1
LEFT JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

SET max_block_size = 65506;

SELECT count() == (SELECT count() FROM rdb_65555 WHERE key < 32777)
FROM (SELECT number as k FROM numbers_mt(32777)) as t1
INNER JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

SELECT count() == 32777 and countIf(value != '') == (SELECT count() FROM rdb_65555 WHERE key < 32777)
FROM (SELECT number as k FROM numbers_mt(32777)) as t1
LEFT JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

SELECT count() == (SELECT count() FROM rdb_65555 WHERE key < 81944)
FROM (SELECT number as k FROM numbers_mt(81944)) as t1
INNER JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

SELECT count() == 81944 and countIf(value != '') == (SELECT count() FROM rdb_65555 WHERE key < 81944)
FROM (SELECT number as k FROM numbers_mt(81944)) as t1
LEFT JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

SET max_block_size = 70000;

SELECT count() == (SELECT count() FROM rdb_65555 WHERE key < 32777)
FROM (SELECT number as k FROM numbers_mt(32777)) as t1
INNER JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

SELECT count() == 32777 and countIf(value != '') == (SELECT count() FROM rdb_65555 WHERE key < 32777)
FROM (SELECT number as k FROM numbers_mt(32777)) as t1
LEFT JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

SELECT count() == (SELECT count() FROM rdb_65555 WHERE key < 81944)
FROM (SELECT number as k FROM numbers_mt(81944)) as t1
INNER JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

SELECT count() == 81944 and countIf(value != '') == (SELECT count() FROM rdb_65555 WHERE key < 81944)
FROM (SELECT number as k FROM numbers_mt(81944)) as t1
LEFT JOIN rdb_65555 as rdb
ON rdb.key == t1.k;

CREATE TABLE rdb_100000 (key UInt64, value String) ENGINE = EmbeddedRocksDB PRIMARY KEY (key);
INSERT INTO rdb_100000
    SELECT (sipHash64(number) % 100000) as key, ('val' || toString(key)) AS value
    FROM numbers_mt(100000);

SET max_block_size = 128;

SELECT count() == (SELECT count() FROM rdb_100000 WHERE key < 50000)
FROM (SELECT number as k FROM numbers_mt(50000)) as t1
INNER JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

SELECT count() == 50000 and countIf(value != '') == (SELECT count() FROM rdb_100000 WHERE key < 50000)
FROM (SELECT number as k FROM numbers_mt(50000)) as t1
LEFT JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

SELECT count() == (SELECT count() FROM rdb_100000 WHERE key < 125001)
FROM (SELECT number as k FROM numbers_mt(125001)) as t1
INNER JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

SELECT count() == 125001 and countIf(value != '') == (SELECT count() FROM rdb_100000 WHERE key < 125001)
FROM (SELECT number as k FROM numbers_mt(125001)) as t1
LEFT JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

SET max_block_size = 129;

SELECT count() == (SELECT count() FROM rdb_100000 WHERE key < 50000)
FROM (SELECT number as k FROM numbers_mt(50000)) as t1
INNER JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

SELECT count() == 50000 and countIf(value != '') == (SELECT count() FROM rdb_100000 WHERE key < 50000)
FROM (SELECT number as k FROM numbers_mt(50000)) as t1
LEFT JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

SELECT count() == (SELECT count() FROM rdb_100000 WHERE key < 125001)
FROM (SELECT number as k FROM numbers_mt(125001)) as t1
INNER JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

SELECT count() == 125001 and countIf(value != '') == (SELECT count() FROM rdb_100000 WHERE key < 125001)
FROM (SELECT number as k FROM numbers_mt(125001)) as t1
LEFT JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

SET max_block_size = 65505;

SELECT count() == (SELECT count() FROM rdb_100000 WHERE key < 50000)
FROM (SELECT number as k FROM numbers_mt(50000)) as t1
INNER JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

SELECT count() == 50000 and countIf(value != '') == (SELECT count() FROM rdb_100000 WHERE key < 50000)
FROM (SELECT number as k FROM numbers_mt(50000)) as t1
LEFT JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

SELECT count() == (SELECT count() FROM rdb_100000 WHERE key < 125001)
FROM (SELECT number as k FROM numbers_mt(125001)) as t1
INNER JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

SELECT count() == 125001 and countIf(value != '') == (SELECT count() FROM rdb_100000 WHERE key < 125001)
FROM (SELECT number as k FROM numbers_mt(125001)) as t1
LEFT JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

SET max_block_size = 65506;

SELECT count() == (SELECT count() FROM rdb_100000 WHERE key < 50000)
FROM (SELECT number as k FROM numbers_mt(50000)) as t1
INNER JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

SELECT count() == 50000 and countIf(value != '') == (SELECT count() FROM rdb_100000 WHERE key < 50000)
FROM (SELECT number as k FROM numbers_mt(50000)) as t1
LEFT JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

SELECT count() == (SELECT count() FROM rdb_100000 WHERE key < 125001)
FROM (SELECT number as k FROM numbers_mt(125001)) as t1
INNER JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

SELECT count() == 125001 and countIf(value != '') == (SELECT count() FROM rdb_100000 WHERE key < 125001)
FROM (SELECT number as k FROM numbers_mt(125001)) as t1
LEFT JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

SET max_block_size = 70000;

SELECT count() == (SELECT count() FROM rdb_100000 WHERE key < 50000)
FROM (SELECT number as k FROM numbers_mt(50000)) as t1
INNER JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

SELECT count() == 50000 and countIf(value != '') == (SELECT count() FROM rdb_100000 WHERE key < 50000)
FROM (SELECT number as k FROM numbers_mt(50000)) as t1
LEFT JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

SELECT count() == (SELECT count() FROM rdb_100000 WHERE key < 125001)
FROM (SELECT number as k FROM numbers_mt(125001)) as t1
INNER JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

SELECT count() == 125001 and countIf(value != '') == (SELECT count() FROM rdb_100000 WHERE key < 125001)
FROM (SELECT number as k FROM numbers_mt(125001)) as t1
LEFT JOIN rdb_100000 as rdb
ON rdb.key == t1.k;

DROP TABLE IF EXISTS rdb_10;
DROP TABLE IF EXISTS rdb_65555;
DROP TABLE IF EXISTS rdb_100000;
