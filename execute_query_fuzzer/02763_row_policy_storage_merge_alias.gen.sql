DROP TABLE IF EXISTS 02763_alias;
DROP TABLE IF EXISTS 02763_a_merge;


SELECT '02763_merge_aliases';
CREATE TABLE 02763_alias (x UInt8, y UInt64, z UInt64 ALIAS plus(x,y)) ENGINE = MergeTree ORDER BY x;
INSERT INTO 02763_alias VALUES (1, 11), (2, 12), (3, 13), (4, 14);

CREATE ROW POLICY 02763_filter_7 ON 02763_alias USING z>15 AS permissive TO ALL;

CREATE TABLE 02763_a_merge (x UInt8, y UInt64, z UInt64) ENGINE = Merge(currentDatabase(), '02763_alias');

SELECT 'x, y, z FROM 02763_a_merge';
SELECT x, y, z FROM 02763_a_merge ORDER BY x SETTINGS optimize_move_to_prewhere= 0;
SELECT '* FROM 02763_a_merge';
SELECT * FROM 02763_a_merge ORDER BY x SETTINGS optimize_move_to_prewhere= 0;
SELECT 'x, y FROM 02763_a_merge';
SELECT x, y FROM 02763_a_merge ORDER BY x SETTINGS optimize_move_to_prewhere= 0;
SELECT 'SELECT x, y FROM merge(currentDatabase(), 02763_alias)';
SELECT x, y FROM merge(currentDatabase(), '02763_alias') ORDER BY x SETTINGS optimize_move_to_prewhere= 0;

CREATE ROW POLICY 02763_filter_8 ON 02763_alias USING y>11 AS permissive TO ALL;

SELECT 'SELECT x, y FROM merge(currentDatabase(), 02763_alias)';
SELECT x, y FROM merge(currentDatabase(), '02763_alias') ORDER BY x SETTINGS optimize_move_to_prewhere= 0;
SELECT 'SELECT x FROM merge(currentDatabase(), 02763_alias)';
SELECT y FROM merge(currentDatabase(), '02763_alias') ORDER BY x SETTINGS optimize_move_to_prewhere= 0;
SELECT 'SELECT y FROM merge(currentDatabase(), 02763_alias)';
SELECT x FROM merge(currentDatabase(), '02763_alias') ORDER BY x SETTINGS optimize_move_to_prewhere= 0;

DROP ROW POLICY 02763_filter_8 ON 02763_alias;
SELECT 'x, y, z FROM 02763_a_merge';
SELECT x, y, z FROM 02763_a_merge ORDER BY x SETTINGS optimize_move_to_prewhere= 1;
SELECT '* FROM 02763_a_merge';
SELECT * FROM 02763_a_merge ORDER BY x SETTINGS optimize_move_to_prewhere= 1;
SELECT 'x, y FROM 02763_a_merge';
SELECT x, y FROM 02763_a_merge ORDER BY x SETTINGS optimize_move_to_prewhere= 1;
SELECT 'SELECT x, y FROM merge(currentDatabase(), 02763_alias)';
SELECT x, y FROM merge(currentDatabase(), '02763_alias') ORDER BY x SETTINGS optimize_move_to_prewhere= 1;

CREATE ROW POLICY 02763_filter_8 ON 02763_alias USING y>11 AS permissive TO ALL;

SELECT 'SELECT x, y FROM merge(currentDatabase(), 02763_alias)';
SELECT x, y FROM merge(currentDatabase(), '02763_alias') ORDER BY x SETTINGS optimize_move_to_prewhere= 1;
SELECT 'SELECT x FROM merge(currentDatabase(), 02763_alias)';
SELECT y FROM merge(currentDatabase(), '02763_alias') ORDER BY x SETTINGS optimize_move_to_prewhere= 1;
SELECT 'SELECT y FROM merge(currentDatabase(), 02763_alias)';
SELECT x FROM merge(currentDatabase(), '02763_alias') ORDER BY x SETTINGS optimize_move_to_prewhere= 1;

DROP ROW POLICY 02763_filter_8 ON 02763_alias;


DROP TABLE 02763_alias;
DROP TABLE 02763_a_merge;

DROP ROW POLICY 02763_filter_7 ON 02763_alias;
