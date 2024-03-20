DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;

CREATE TABLE t1 (a Int32) ENGINE = TinyLog;
CREATE TABLE t2 (a UInt32, key UInt32) ENGINE = TinyLog;

INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2, 2);

SET join_use_nulls = 1;
SET allow_experimental_analyzer = 1;

-- { echoOn }

SELECT '============ LEFT JOIN ============' FORMAT Null;

SELECT a, toTypeName(a)
FROM (
    SELECT *
    FROM (SELECT 1 :: Int32 as a) t1
    LEFT JOIN (SELECT 2 :: UInt32 as a) t2
    ON t1.a = t2.a
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT a
    FROM (SELECT 1 :: Int32 as a) t1
    LEFT JOIN (SELECT 2 :: UInt32 as a) t2
    ON t1.a = t2.a
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT *
    FROM (SELECT 1 :: Int32 as a) t1
    LEFT JOIN (SELECT 2 :: UInt32 as a) t2
    ON t1.a = t2.a
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t1.*
    FROM (SELECT 1 :: Int32 as a) t1
    LEFT JOIN (SELECT 2 :: UInt32 as a) t2
    ON t1.a = t2.a
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t2.*
    FROM (SELECT 1 :: Int32 as a) t1
    LEFT JOIN (SELECT 2 :: UInt32 as a) t2
    ON t1.a = t2.a
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t2.*
    FROM t1
    LEFT JOIN t2
    ON t1.a = t2.a
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT a
    FROM (SELECT 1 :: Int32 as a) t1
    LEFT JOIN (SELECT 2 :: UInt32 as a) t2
    USING (a)
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT *
    FROM (SELECT 1 :: Int32 as a) t1
    LEFT JOIN (SELECT 2 :: UInt32 as a) t2
    USING (a)
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t1.*
    FROM (SELECT 1 :: Int32 as a) t1
    LEFT JOIN (SELECT 2 :: UInt32 as a) t2
    USING (a)
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t2.*
    FROM (SELECT 1 :: Int32 as a) t1
    LEFT JOIN (SELECT 2 :: UInt32 as a) t2
    USING (a)
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT *
    FROM t1
    LEFT JOIN t2
    USING (a)
) ORDER BY 1;

SELECT a, toTypeName(a)
FROM (
    SELECT *
    FROM (SELECT 1 :: Int32 as a) t1
    LEFT JOIN (SELECT 2 :: UInt32 as key) t2
    ON t1.a = t2.key
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT a
    FROM (SELECT 1 :: Int32 as a) t1
    LEFT JOIN (SELECT 2 :: UInt32 as key) t2
    ON t1.a = t2.key
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT *
    FROM (SELECT 1 :: Int32 as a) t1
    LEFT JOIN (SELECT 2 :: UInt32 as key) t2
    ON t1.a = t2.key
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t1.*
    FROM (SELECT 1 :: Int32 as a) t1
    LEFT JOIN (SELECT 2 :: UInt32 as key) t2
    ON t1.a = t2.key
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t2.*
    FROM (SELECT 1 :: Int32 as a) t1
    LEFT JOIN (SELECT 2 :: UInt32 as key) t2
    ON t1.a = t2.key
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t2.*
    FROM t1
    LEFT JOIN t2
    ON t1.a = t2.key
) ORDER BY 1;

SELECT '============ RIGHT JOIN ============' FORMAT Null;

SELECT a, toTypeName(a)
FROM (
    SELECT *
    FROM (SELECT 1 :: Int32 as a) t1
    RIGHT JOIN (SELECT 2 :: UInt32 as a) t2
    ON t1.a = t2.a
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT a
    FROM (SELECT 1 :: Int32 as a) t1
    RIGHT JOIN (SELECT 2 :: UInt32 as a) t2
    ON t1.a = t2.a
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT *
    FROM (SELECT 1 :: Int32 as a) t1
    RIGHT JOIN (SELECT 2 :: UInt32 as a) t2
    ON t1.a = t2.a
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t1.*
    FROM (SELECT 1 :: Int32 as a) t1
    RIGHT JOIN (SELECT 2 :: UInt32 as a) t2
    ON t1.a = t2.a
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t2.*
    FROM (SELECT 1 :: Int32 as a) t1
    RIGHT JOIN (SELECT 2 :: UInt32 as a) t2
    ON t1.a = t2.a
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t2.*
    FROM t1
    RIGHT JOIN t2
    ON t1.a = t2.a
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT a
    FROM (SELECT 1 :: Int32 as a) t1
    RIGHT JOIN (SELECT 2 :: UInt32 as a) t2
    USING (a)
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT *
    FROM (SELECT 1 :: Int32 as a) t1
    RIGHT JOIN (SELECT 2 :: UInt32 as a) t2
    USING (a)
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t1.*
    FROM (SELECT 1 :: Int32 as a) t1
    RIGHT JOIN (SELECT 2 :: UInt32 as a) t2
    USING (a)
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t2.*
    FROM (SELECT 1 :: Int32 as a) t1
    RIGHT JOIN (SELECT 2 :: UInt32 as a) t2
    USING (a)
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT *
    FROM t1
    RIGHT JOIN t2
    USING (a)
) ORDER BY 1;

SELECT a, toTypeName(a)
FROM (
    SELECT *
    FROM (SELECT 1 :: Int32 as a) t1
    RIGHT JOIN (SELECT 2 :: UInt32 as key) t2
    ON t1.a = t2.key
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT a
    FROM (SELECT 1 :: Int32 as a) t1
    RIGHT JOIN (SELECT 2 :: UInt32 as key) t2
    ON t1.a = t2.key
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT *
    FROM (SELECT 1 :: Int32 as a) t1
    RIGHT JOIN (SELECT 2 :: UInt32 as key) t2
    ON t1.a = t2.key
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t1.*
    FROM (SELECT 1 :: Int32 as a) t1
    RIGHT JOIN (SELECT 2 :: UInt32 as key) t2
    ON t1.a = t2.key
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t2.*
    FROM (SELECT 1 :: Int32 as a) t1
    RIGHT JOIN (SELECT 2 :: UInt32 as key) t2
    ON t1.a = t2.key
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t2.*
    FROM t1
    RIGHT JOIN t2
    ON t1.a = t2.key
) ORDER BY 1;

SELECT '============ FULL JOIN ============' FORMAT Null;

SELECT a, toTypeName(a)
FROM (
    SELECT *
    FROM (SELECT 1 :: Int32 as a) t1
    FULL JOIN (SELECT 2 :: UInt32 as a) t2
    ON t1.a = t2.a
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT a
    FROM (SELECT 1 :: Int32 as a) t1
    FULL JOIN (SELECT 2 :: UInt32 as a) t2
    ON t1.a = t2.a
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT *
    FROM (SELECT 1 :: Int32 as a) t1
    FULL JOIN (SELECT 2 :: UInt32 as a) t2
    ON t1.a = t2.a
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t1.*
    FROM (SELECT 1 :: Int32 as a) t1
    FULL JOIN (SELECT 2 :: UInt32 as a) t2
    ON t1.a = t2.a
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t2.*
    FROM (SELECT 1 :: Int32 as a) t1
    FULL JOIN (SELECT 2 :: UInt32 as a) t2
    ON t1.a = t2.a
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t2.*
    FROM t1
    FULL JOIN t2
    ON t1.a = t2.a
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT a
    FROM (SELECT 1 :: Int32 as a) t1
    FULL JOIN (SELECT 2 :: UInt32 as a) t2
    USING (a)
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT *
    FROM (SELECT 1 :: Int32 as a) t1
    FULL JOIN (SELECT 2 :: UInt32 as a) t2
    USING (a)
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t1.*
    FROM (SELECT 1 :: Int32 as a) t1
    FULL JOIN (SELECT 2 :: UInt32 as a) t2
    USING (a)
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t2.*
    FROM (SELECT 1 :: Int32 as a) t1
    FULL JOIN (SELECT 2 :: UInt32 as a) t2
    USING (a)
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT *
    FROM t1
    FULL JOIN t2
    USING (a)
) ORDER BY 1;

SELECT a, toTypeName(a)
FROM (
    SELECT *
    FROM (SELECT 1 :: Int32 as a) t1
    FULL JOIN (SELECT 2 :: UInt32 as key) t2
    ON t1.a = t2.key
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT a
    FROM (SELECT 1 :: Int32 as a) t1
    FULL JOIN (SELECT 2 :: UInt32 as key) t2
    ON t1.a = t2.key
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT *
    FROM (SELECT 1 :: Int32 as a) t1
    FULL JOIN (SELECT 2 :: UInt32 as key) t2
    ON t1.a = t2.key
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t1.*
    FROM (SELECT 1 :: Int32 as a) t1
    FULL JOIN (SELECT 2 :: UInt32 as key) t2
    ON t1.a = t2.key
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t2.*
    FROM (SELECT 1 :: Int32 as a) t1
    FULL JOIN (SELECT 2 :: UInt32 as key) t2
    ON t1.a = t2.key
) ORDER BY 1;

SELECT *, * APPLY toTypeName
FROM (
    SELECT t2.*
    FROM t1
    FULL JOIN t2
    ON t1.a = t2.key
) ORDER BY 1;

-- { echoOff }

DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
