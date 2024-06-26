
SELECT '--- Memory ---';

DROP TABLE IF EXISTS t_nested_offsets;

CREATE TABLE t_nested_offsets
(
    `a` String,
    `e.n` Array(String),
    `e.t` Array(Int64)
)
ENGINE = Log;

SYSTEM STOP MERGES t_nested_offsets;

INSERT INTO t_nested_offsets SELECT number, range(number % 10), range(number % 10) FROM numbers(1000);

SELECT sum(e.n.size0) FROM t_nested_offsets;
SELECT sum(e.n.size0), sum(e.t.size0) FROM t_nested_offsets;

SELECT sum(length(e.n)) FROM t_nested_offsets SETTINGS optimize_functions_to_subcolumns = 1;
SELECT sum(length(e.n)), sum(length(e.t)) FROM t_nested_offsets SETTINGS optimize_functions_to_subcolumns = 1;

INSERT INTO t_nested_offsets SELECT number, range(number % 10), range(number % 10) FROM numbers(20000);

SELECT sum(e.n.size0) FROM t_nested_offsets;
SELECT sum(e.n.size0), sum(e.t.size0) FROM t_nested_offsets;

SELECT sum(length(e.n)) FROM t_nested_offsets SETTINGS optimize_functions_to_subcolumns = 1;
SELECT sum(length(e.n)), sum(length(e.t)) FROM t_nested_offsets SETTINGS optimize_functions_to_subcolumns = 1;

DROP TABLE t_nested_offsets;

SELECT '--- Log ---';

DROP TABLE IF EXISTS t_nested_offsets;

CREATE TABLE t_nested_offsets
(
    `a` String,
    `e.n` Array(String),
    `e.t` Array(Int64)
)
ENGINE = Log;

SYSTEM STOP MERGES t_nested_offsets;

INSERT INTO t_nested_offsets SELECT number, range(number % 10), range(number % 10) FROM numbers(1000);

SELECT sum(e.n.size0) FROM t_nested_offsets;
SELECT sum(e.n.size0), sum(e.t.size0) FROM t_nested_offsets;

SELECT sum(length(e.n)) FROM t_nested_offsets SETTINGS optimize_functions_to_subcolumns = 1;
SELECT sum(length(e.n)), sum(length(e.t)) FROM t_nested_offsets SETTINGS optimize_functions_to_subcolumns = 1;

INSERT INTO t_nested_offsets SELECT number, range(number % 10), range(number % 10) FROM numbers(20000);

SELECT sum(e.n.size0) FROM t_nested_offsets;
SELECT sum(e.n.size0), sum(e.t.size0) FROM t_nested_offsets;

SELECT sum(length(e.n)) FROM t_nested_offsets SETTINGS optimize_functions_to_subcolumns = 1;
SELECT sum(length(e.n)), sum(length(e.t)) FROM t_nested_offsets SETTINGS optimize_functions_to_subcolumns = 1;

DROP TABLE t_nested_offsets;

SELECT '--- TinyLog ---';

DROP TABLE IF EXISTS t_nested_offsets;

CREATE TABLE t_nested_offsets
(
    `a` String,
    `e.n` Array(String),
    `e.t` Array(Int64)
)
ENGINE = Log;

SYSTEM STOP MERGES t_nested_offsets;

INSERT INTO t_nested_offsets SELECT number, range(number % 10), range(number % 10) FROM numbers(1000);

SELECT sum(e.n.size0) FROM t_nested_offsets;
SELECT sum(e.n.size0), sum(e.t.size0) FROM t_nested_offsets;

SELECT sum(length(e.n)) FROM t_nested_offsets SETTINGS optimize_functions_to_subcolumns = 1;
SELECT sum(length(e.n)), sum(length(e.t)) FROM t_nested_offsets SETTINGS optimize_functions_to_subcolumns = 1;

INSERT INTO t_nested_offsets SELECT number, range(number % 10), range(number % 10) FROM numbers(20000);

SELECT sum(e.n.size0) FROM t_nested_offsets;
SELECT sum(e.n.size0), sum(e.t.size0) FROM t_nested_offsets;

SELECT sum(length(e.n)) FROM t_nested_offsets SETTINGS optimize_functions_to_subcolumns = 1;
SELECT sum(length(e.n)), sum(length(e.t)) FROM t_nested_offsets SETTINGS optimize_functions_to_subcolumns = 1;

DROP TABLE t_nested_offsets;

SELECT '--- MergeTree ORDER BY (a) SETTINGS min_bytes_for_wide_part = 0, min_rows_for_wide_part = 2000 ---';

DROP TABLE IF EXISTS t_nested_offsets;

CREATE TABLE t_nested_offsets
(
    `a` String,
    `e.n` Array(String),
    `e.t` Array(Int64)
)
ENGINE = Log;

SYSTEM STOP MERGES t_nested_offsets;

INSERT INTO t_nested_offsets SELECT number, range(number % 10), range(number % 10) FROM numbers(1000);

SELECT sum(e.n.size0) FROM t_nested_offsets;
SELECT sum(e.n.size0), sum(e.t.size0) FROM t_nested_offsets;

SELECT sum(length(e.n)) FROM t_nested_offsets SETTINGS optimize_functions_to_subcolumns = 1;
SELECT sum(length(e.n)), sum(length(e.t)) FROM t_nested_offsets SETTINGS optimize_functions_to_subcolumns = 1;

INSERT INTO t_nested_offsets SELECT number, range(number % 10), range(number % 10) FROM numbers(20000);

SELECT sum(e.n.size0) FROM t_nested_offsets;
SELECT sum(e.n.size0), sum(e.t.size0) FROM t_nested_offsets;

SELECT sum(length(e.n)) FROM t_nested_offsets SETTINGS optimize_functions_to_subcolumns = 1;
SELECT sum(length(e.n)), sum(length(e.t)) FROM t_nested_offsets SETTINGS optimize_functions_to_subcolumns = 1;

DROP TABLE t_nested_offsets;

