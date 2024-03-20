DROP TABLE IF EXISTS bftest__fuzz_21;

CREATE TABLE bftest__fuzz_21
(
    `k` Int64,
    `x` Array(Int8),
    INDEX ix1 x TYPE bloom_filter GRANULARITY 3
)
ENGINE = MergeTree
ORDER BY k;

INSERT INTO bftest__fuzz_21 (k, x) SELECT
    number,
    arrayMap(i -> (rand64() % 565656), range(10))
FROM numbers(1000);

SELECT count() FROM bftest__fuzz_21 WHERE hasAll(x, [42, -42]) SETTINGS use_skip_indexes=1, force_data_skipping_indices='ix1';
DROP TABLE IF EXISTS bftest__fuzz_21;

DROP TABLE IF EXISTS bftest__fuzz_21;

CREATE TABLE bftest__fuzz_21
(
    `k` Int64,
    `x` Array(Int16),
    INDEX ix1 x TYPE bloom_filter GRANULARITY 3
)
ENGINE = MergeTree
ORDER BY k;

INSERT INTO bftest__fuzz_21 (k, x) SELECT
    number,
    arrayMap(i -> (rand64() % 565656), range(10))
FROM numbers(1000);

SELECT count() FROM bftest__fuzz_21 WHERE hasAll(x, [42, -42]) SETTINGS use_skip_indexes=1, force_data_skipping_indices='ix1';
DROP TABLE IF EXISTS bftest__fuzz_21;

DROP TABLE IF EXISTS bftest__fuzz_21;

CREATE TABLE bftest__fuzz_21
(
    `k` Int64,
    `x` Array(Int32),
    INDEX ix1 x TYPE bloom_filter GRANULARITY 3
)
ENGINE = MergeTree
ORDER BY k;

INSERT INTO bftest__fuzz_21 (k, x) SELECT
    number,
    arrayMap(i -> (rand64() % 565656), range(10))
FROM numbers(1000);

SELECT count() FROM bftest__fuzz_21 WHERE hasAll(x, [42, -42]) SETTINGS use_skip_indexes=1, force_data_skipping_indices='ix1';
DROP TABLE IF EXISTS bftest__fuzz_21;

DROP TABLE IF EXISTS bftest__fuzz_21;

CREATE TABLE bftest__fuzz_21
(
    `k` Int64,
    `x` Array(Int64),
    INDEX ix1 x TYPE bloom_filter GRANULARITY 3
)
ENGINE = MergeTree
ORDER BY k;

INSERT INTO bftest__fuzz_21 (k, x) SELECT
    number,
    arrayMap(i -> (rand64() % 565656), range(10))
FROM numbers(1000);

SELECT count() FROM bftest__fuzz_21 WHERE hasAll(x, [42, -42]) SETTINGS use_skip_indexes=1, force_data_skipping_indices='ix1';
DROP TABLE IF EXISTS bftest__fuzz_21;

DROP TABLE IF EXISTS bftest__fuzz_21;

CREATE TABLE bftest__fuzz_21
(
    `k` Int64,
    `x` Array(UInt8),
    INDEX ix1 x TYPE bloom_filter GRANULARITY 3
)
ENGINE = MergeTree
ORDER BY k;

INSERT INTO bftest__fuzz_21 (k, x) SELECT
    number,
    arrayMap(i -> (rand64() % 565656), range(10))
FROM numbers(1000);

SELECT count() FROM bftest__fuzz_21 WHERE hasAll(x, [42, -42]) SETTINGS use_skip_indexes=1;
    SELECT count() FROM bftest__fuzz_21 WHERE hasAll(x, [42, -42]) SETTINGS use_skip_indexes=1, force_data_skipping_indices='ix1'; -- { serverError INDEX_NOT_USED }
DROP TABLE IF EXISTS bftest__fuzz_21;

DROP TABLE IF EXISTS bftest__fuzz_21;

CREATE TABLE bftest__fuzz_21
(
    `k` Int64,
    `x` Array(UInt16),
    INDEX ix1 x TYPE bloom_filter GRANULARITY 3
)
ENGINE = MergeTree
ORDER BY k;

INSERT INTO bftest__fuzz_21 (k, x) SELECT
    number,
    arrayMap(i -> (rand64() % 565656), range(10))
FROM numbers(1000);

SELECT count() FROM bftest__fuzz_21 WHERE hasAll(x, [42, -42]) SETTINGS use_skip_indexes=1;
    SELECT count() FROM bftest__fuzz_21 WHERE hasAll(x, [42, -42]) SETTINGS use_skip_indexes=1, force_data_skipping_indices='ix1'; -- { serverError INDEX_NOT_USED }
DROP TABLE IF EXISTS bftest__fuzz_21;

DROP TABLE IF EXISTS bftest__fuzz_21;

CREATE TABLE bftest__fuzz_21
(
    `k` Int64,
    `x` Array(UInt32),
    INDEX ix1 x TYPE bloom_filter GRANULARITY 3
)
ENGINE = MergeTree
ORDER BY k;

INSERT INTO bftest__fuzz_21 (k, x) SELECT
    number,
    arrayMap(i -> (rand64() % 565656), range(10))
FROM numbers(1000);

SELECT count() FROM bftest__fuzz_21 WHERE hasAll(x, [42, -42]) SETTINGS use_skip_indexes=1;
    SELECT count() FROM bftest__fuzz_21 WHERE hasAll(x, [42, -42]) SETTINGS use_skip_indexes=1, force_data_skipping_indices='ix1'; -- { serverError INDEX_NOT_USED }
DROP TABLE IF EXISTS bftest__fuzz_21;

