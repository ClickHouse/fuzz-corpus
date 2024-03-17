-- Tags: long

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

SET join_algorithm = 'partial_merge';

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(21);
INSERT INTO right SELECT number, toString(number) FROM numbers(25);

SET max_joined_block_size_rows = 8;
SET max_block_size = 10;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(21);
INSERT INTO right SELECT number, toString(number) FROM numbers(25);

SET max_joined_block_size_rows = 9;
SET max_block_size = 10;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(21);
INSERT INTO right SELECT number, toString(number) FROM numbers(25);

SET max_joined_block_size_rows = 10;
SET max_block_size = 10;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(21);
INSERT INTO right SELECT number, toString(number) FROM numbers(25);

SET max_joined_block_size_rows = 11;
SET max_block_size = 10;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(23);
INSERT INTO right SELECT number, toString(number) FROM numbers(27);

SET max_joined_block_size_rows = 9;
SET max_block_size = 11;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(23);
INSERT INTO right SELECT number, toString(number) FROM numbers(27);

SET max_joined_block_size_rows = 10;
SET max_block_size = 11;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(23);
INSERT INTO right SELECT number, toString(number) FROM numbers(27);

SET max_joined_block_size_rows = 11;
SET max_block_size = 11;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(23);
INSERT INTO right SELECT number, toString(number) FROM numbers(27);

SET max_joined_block_size_rows = 12;
SET max_block_size = 11;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(257);
INSERT INTO right SELECT number, toString(number) FROM numbers(261);

SET max_joined_block_size_rows = 126;
SET max_block_size = 128;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(257);
INSERT INTO right SELECT number, toString(number) FROM numbers(261);

SET max_joined_block_size_rows = 127;
SET max_block_size = 128;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(257);
INSERT INTO right SELECT number, toString(number) FROM numbers(261);

SET max_joined_block_size_rows = 128;
SET max_block_size = 128;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(257);
INSERT INTO right SELECT number, toString(number) FROM numbers(261);

SET max_joined_block_size_rows = 129;
SET max_block_size = 128;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(259);
INSERT INTO right SELECT number, toString(number) FROM numbers(263);

SET max_joined_block_size_rows = 127;
SET max_block_size = 129;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(259);
INSERT INTO right SELECT number, toString(number) FROM numbers(263);

SET max_joined_block_size_rows = 128;
SET max_block_size = 129;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(259);
INSERT INTO right SELECT number, toString(number) FROM numbers(263);

SET max_joined_block_size_rows = 129;
SET max_block_size = 129;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(259);
INSERT INTO right SELECT number, toString(number) FROM numbers(263);

SET max_joined_block_size_rows = 130;
SET max_block_size = 129;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(131011);
INSERT INTO right SELECT number, toString(number) FROM numbers(131015);

SET max_joined_block_size_rows = 65503;
SET max_block_size = 65505;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(131011);
INSERT INTO right SELECT number, toString(number) FROM numbers(131015);

SET max_joined_block_size_rows = 65504;
SET max_block_size = 65505;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(131011);
INSERT INTO right SELECT number, toString(number) FROM numbers(131015);

SET max_joined_block_size_rows = 65505;
SET max_block_size = 65505;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(131011);
INSERT INTO right SELECT number, toString(number) FROM numbers(131015);

SET max_joined_block_size_rows = 65506;
SET max_block_size = 65505;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(131013);
INSERT INTO right SELECT number, toString(number) FROM numbers(131017);

SET max_joined_block_size_rows = 65504;
SET max_block_size = 65506;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(131013);
INSERT INTO right SELECT number, toString(number) FROM numbers(131017);

SET max_joined_block_size_rows = 65505;
SET max_block_size = 65506;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(131013);
INSERT INTO right SELECT number, toString(number) FROM numbers(131017);

SET max_joined_block_size_rows = 65506;
SET max_block_size = 65506;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(131013);
INSERT INTO right SELECT number, toString(number) FROM numbers(131017);

SET max_joined_block_size_rows = 65507;
SET max_block_size = 65506;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(140001);
INSERT INTO right SELECT number, toString(number) FROM numbers(140005);

SET max_joined_block_size_rows = 69998;
SET max_block_size = 70000;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(140001);
INSERT INTO right SELECT number, toString(number) FROM numbers(140005);

SET max_joined_block_size_rows = 69999;
SET max_block_size = 70000;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(140001);
INSERT INTO right SELECT number, toString(number) FROM numbers(140005);

SET max_joined_block_size_rows = 70000;
SET max_block_size = 70000;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;

CREATE TABLE left ( key UInt32, value String ) ENGINE = Memory;
CREATE TABLE right (  key UInt32, value String ) ENGINE = Memory;

INSERT INTO left SELECT number, toString(number) FROM numbers(140001);
INSERT INTO right SELECT number, toString(number) FROM numbers(140005);

SET max_joined_block_size_rows = 70001;
SET max_block_size = 70000;

SELECT key, count(1) AS cnt
FROM (
    SELECT *
    FROM ( SELECT key FROM left AS s ) AS data
    ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
) GROUP BY key HAVING count(1) > 1
;

SELECT count() == (SELECT count() from left) AND min(key == promo.key) == 1
FROM ( SELECT key FROM left AS s ) AS data
ALL LEFT JOIN ( SELECT key FROM right GROUP BY key ) AS promo ON promo.key = data.key
;

DROP TABLE IF EXISTS left;
DROP TABLE IF EXISTS right;
