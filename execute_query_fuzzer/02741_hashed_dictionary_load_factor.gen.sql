


DROP DICTIONARY IF EXISTS test_dictionary_hashed;
DROP DICTIONARY IF EXISTS test_dictionary_hashed_load_factor;
DROP TABLE IF EXISTS test_table;

CREATE TABLE test_table
(
    key UInt64,
    value UInt16
) ENGINE=Memory() AS SELECT number, number FROM numbers(1e6);

CREATE DICTIONARY test_dictionary_hashed
(
    key UInt64,
    value UInt16
) PRIMARY KEY key
SOURCE(CLICKHOUSE(TABLE test_table))
LAYOUT(hashed())
LIFETIME(0);

CREATE DICTIONARY test_dictionary_hashed_load_factor
(
    key UInt64,
    value UInt16
) PRIMARY KEY key
SOURCE(CLICKHOUSE(TABLE test_table))
LAYOUT(hashed(MAX_LOAD_FACTOR 0.98))
LIFETIME(0);

SYSTEM RELOAD DICTIONARY test_dictionary_hashed;
SYSTEM RELOAD DICTIONARY test_dictionary_hashed_load_factor;
SELECT name, element_count, round(load_factor, 4), round(bytes_allocated, -6) FROM system.dictionaries WHERE database = currentDatabase() ORDER BY name;

DROP DICTIONARY IF EXISTS test_dictionary_hashed;
DROP DICTIONARY IF EXISTS test_dictionary_hashed_load_factor;
DROP TABLE test_table;

DROP DICTIONARY IF EXISTS test_dictionary_sparse_hashed;
DROP DICTIONARY IF EXISTS test_dictionary_sparse_hashed_load_factor;
DROP TABLE IF EXISTS test_table;

CREATE TABLE test_table
(
    key UInt64,
    value UInt16
) ENGINE=Memory() AS SELECT number, number FROM numbers(1e6);

CREATE DICTIONARY test_dictionary_sparse_hashed
(
    key UInt64,
    value UInt16
) PRIMARY KEY key
SOURCE(CLICKHOUSE(TABLE test_table))
LAYOUT(sparse_hashed())
LIFETIME(0);

CREATE DICTIONARY test_dictionary_sparse_hashed_load_factor
(
    key UInt64,
    value UInt16
) PRIMARY KEY key
SOURCE(CLICKHOUSE(TABLE test_table))
LAYOUT(sparse_hashed(MAX_LOAD_FACTOR 0.98))
LIFETIME(0);

SYSTEM RELOAD DICTIONARY test_dictionary_sparse_hashed;
SYSTEM RELOAD DICTIONARY test_dictionary_sparse_hashed_load_factor;
SELECT name, element_count, round(load_factor, 4), round(bytes_allocated, -6) FROM system.dictionaries WHERE database = currentDatabase() ORDER BY name;

DROP DICTIONARY IF EXISTS test_dictionary_sparse_hashed;
DROP DICTIONARY IF EXISTS test_dictionary_sparse_hashed_load_factor;
DROP TABLE test_table;

