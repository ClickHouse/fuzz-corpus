DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;

CREATE TABLE t1 (a Nullable(UInt32), b Nullable(Int16), val UInt32) ENGINE = MergeTree ORDER BY tuple() SETTINGS ratio_of_defaults_for_sparse_serialization = 1;
INSERT INTO t1 SELECT if(number % 2 == 0, NULL, number), if(number % 6 == 0, NULL, number), number, FROM numbers(1, 20);

CREATE TABLE t2 (a Nullable(UInt32), b Nullable(UInt16), val UInt32) ENGINE = MergeTree ORDER BY tuple() SETTINGS ratio_of_defaults_for_sparse_serialization = 1;
INSERT INTO t2 SELECT if(number % 4 == 0, NULL, number), if(number % 3 == 0, NULL, number), number, FROM numbers(1, 20);

CREATE TABLE t3 (a Nullable(UInt32), b UInt16, val UInt32) ENGINE = MergeTree ORDER BY tuple() SETTINGS ratio_of_defaults_for_sparse_serialization = 1;
INSERT INTO t3 SELECT if(number % 4 == 0, NULL, number), if(number % 3 == 0, NULL, number), number, FROM numbers(1, 20);

CREATE TABLE t4 (a UInt32, b UInt16, val UInt32) ENGINE = MergeTree ORDER BY tuple() SETTINGS ratio_of_defaults_for_sparse_serialization = 1;
INSERT INTO t4 SELECT if(number % 4 == 0, NULL, number), if(number % 3 == 0, NULL, number), number, FROM numbers(1, 20);

SET join_algorithm = 'default';
SET join_use_nulls = 0;

SELECT 'join_algorithm = default, join_use_nulls = 0, t1 JOIN t2';

SELECT '--';

SELECT t1.a, t1.val, t2.a, t2.val FROM t1 FULL JOIN t2
ON t1.a <=> t2.a
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
;

SELECT '--';

SELECT * FROM t1 FULL JOIN t2
ON t1.a <=> t2.a AND t1.b <=> t2.b
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
;

SELECT '--';

SELECT * FROM t1 FULL JOIN t2
ON t1.a == t2.a AND t1.b <=> t2.b
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
;

SELECT '--';

SELECT * FROM t1 FULL JOIN t2
ON t1.a <=> t2.a AND t1.b == t2.b
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
;

SET join_algorithm = 'grace_hash';
SET join_use_nulls = 0;

SELECT 'join_algorithm = grace_hash, join_use_nulls = 0, t1 JOIN t2';

SELECT '--';

SELECT t1.a, t1.val, t2.a, t2.val FROM t1 FULL JOIN t2
ON t1.a <=> t2.a
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
;

SELECT '--';

SELECT * FROM t1 FULL JOIN t2
ON t1.a <=> t2.a AND t1.b <=> t2.b
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
;

SELECT '--';

SELECT * FROM t1 FULL JOIN t2
ON t1.a == t2.a AND t1.b <=> t2.b
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
;

SELECT '--';

SELECT * FROM t1 FULL JOIN t2
ON t1.a <=> t2.a AND t1.b == t2.b
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
;

SET join_algorithm = 'full_sorting_merge';
SET join_use_nulls = 0;

SELECT 'join_algorithm = full_sorting_merge, join_use_nulls = 0, t1 JOIN t2';

SELECT '--';

SELECT t1.a, t1.val, t2.a, t2.val FROM t1 FULL JOIN t2
ON t1.a <=> t2.a
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
;

SELECT '--';

SELECT * FROM t1 FULL JOIN t2
ON t1.a <=> t2.a AND t1.b <=> t2.b
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
;

SELECT '--';

SELECT * FROM t1 FULL JOIN t2
ON t1.a == t2.a AND t1.b <=> t2.b
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
;

SELECT '--';

SELECT * FROM t1 FULL JOIN t2
ON t1.a <=> t2.a AND t1.b == t2.b
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
;

SET join_algorithm = 'default';
SET join_use_nulls = 1;

SELECT 'join_algorithm = default, join_use_nulls = 1, t1 JOIN t2';

SELECT '--';

SELECT t1.a, t1.val, t2.a, t2.val FROM t1 FULL JOIN t2
ON t1.a <=> t2.a
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
;

SELECT '--';

SELECT * FROM t1 FULL JOIN t2
ON t1.a <=> t2.a AND t1.b <=> t2.b
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
;

SELECT '--';

SELECT * FROM t1 FULL JOIN t2
ON t1.a == t2.a AND t1.b <=> t2.b
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
;

SELECT '--';

SELECT * FROM t1 FULL JOIN t2
ON t1.a <=> t2.a AND t1.b == t2.b
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
;

SET join_algorithm = 'default';
SET join_use_nulls = 0;

SELECT 'join_algorithm = default, join_use_nulls = 0, t1 JOIN t3';

SELECT '--';

SELECT t1.a, t1.val, t3.a, t3.val FROM t1 FULL JOIN t3
ON t1.a <=> t3.a
ORDER BY t1.val NULLS FIRST, t3.val NULLS FIRST
;

SELECT '--';

SELECT * FROM t1 FULL JOIN t3
ON t1.a <=> t3.a AND t1.b <=> t3.b
ORDER BY t1.val NULLS FIRST, t3.val NULLS FIRST
;

SELECT '--';

SELECT * FROM t1 FULL JOIN t3
ON t1.a == t3.a AND t1.b <=> t3.b
ORDER BY t1.val NULLS FIRST, t3.val NULLS FIRST
;

SELECT '--';

SELECT * FROM t1 FULL JOIN t3
ON t1.a <=> t3.a AND t1.b == t3.b
ORDER BY t1.val NULLS FIRST, t3.val NULLS FIRST
;

SET join_algorithm = 'default';
SET join_use_nulls = 0;

SELECT 'join_algorithm = default, join_use_nulls = 0, t1 JOIN t4';

SELECT '--';

SELECT t1.a, t1.val, t4.a, t4.val FROM t1 FULL JOIN t4
ON t1.a <=> t4.a
ORDER BY t1.val NULLS FIRST, t4.val NULLS FIRST
;

SELECT '--';

SELECT * FROM t1 FULL JOIN t4
ON t1.a <=> t4.a AND t1.b <=> t4.b
ORDER BY t1.val NULLS FIRST, t4.val NULLS FIRST
;

SELECT '--';

SELECT * FROM t1 FULL JOIN t4
ON t1.a == t4.a AND t1.b <=> t4.b
ORDER BY t1.val NULLS FIRST, t4.val NULLS FIRST
;

SELECT '--';

SELECT * FROM t1 FULL JOIN t4
ON t1.a <=> t4.a AND t1.b == t4.b
ORDER BY t1.val NULLS FIRST, t4.val NULLS FIRST
;

SELECT '--';

SET join_use_nulls = 0;
SET join_algorithm = 'hash';
SELECT t1.a, t1.val, t2.a, t2.val FROM t1 FULL JOIN t2
ON t1.a <=> t2.a AND t1.b < 2 OR t1.a == t2.a
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
;

SELECT '--';

SELECT t1.a, t1.val, t2.a, t2.val FROM t1 FULL JOIN t2
ON t1.a IS NOT DISTINCT FROM t2.a AND t1.b < 2 OR t1.a == t2.a
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
;

SELECT '--';

SET join_algorithm = 'default';
SET join_use_nulls = 1;

-- try to cause column name clash intentionally using internal name

SELECT *
FROM (SELECT a, 42 as `__wrapNullsafe(a)`, 420 as `tuple(a)`, val FROM t1) t1
JOIN (SELECT a, 43 as `__wrapNullsafe(t2.a)`, 430 as `tuple(t2.a)`, val FROM t2) t2
ON t1.a <=> t2.a
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
LIMIT 10;

SELECT '--';

SELECT a, 42 as `__wrapNullsafe(a)`, 420 as `tuple(a)`, val, t2.a, 43 as `__wrapNullsafe(t2.a)`, 430 as `tuple(t2.a)`, t2.val
FROM (SELECT a, val, 111 as `__wrapNullsafe(a)_0` FROM t1) t1
JOIN (SELECT a, val, 111 as `__wrapNullsafe(t2.a)_0` FROM t2) t2
ON t1.a <=> t2.a
ORDER BY t1.val NULLS FIRST, t2.val NULLS FIRST
LIMIT 10;

SELECT '--';

-- check illegal queries

SELECT * FROM t1 JOIN t2 ON isNotDistinctFrom(); -- { serverError SYNTAX_ERROR,NUMBER_OF_ARGUMENTS_DOESNT_MATCH }
SELECT * FROM t1 JOIN t2 ON isNotDistinctFrom(t1.a); -- { serverError SYNTAX_ERROR,NUMBER_OF_ARGUMENTS_DOESNT_MATCH }
SELECT * FROM t1 JOIN t2 ON isNotDistinctFrom(t1.a, t2.a, t2.b); -- { serverError SYNTAX_ERROR,NUMBER_OF_ARGUMENTS_DOESNT_MATCH }

SELECT isNotDistinctFrom(a) from t1; -- { serverError NUMBER_OF_ARGUMENTS_DOESNT_MATCH }
SELECT isNotDistinctFrom(a, b) from t1; -- { serverError NOT_IMPLEMENTED }
SELECT a <=> b from t1; -- { serverError NOT_IMPLEMENTED }
SELECT a IS NOT DISTINCT FROM b from t1; -- { serverError NOT_IMPLEMENTED }
