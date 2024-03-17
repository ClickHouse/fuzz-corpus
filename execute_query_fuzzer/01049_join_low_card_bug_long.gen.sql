-- Tags: long

DROP TABLE IF EXISTS l;
DROP TABLE IF EXISTS r;
DROP TABLE IF EXISTS nl;
DROP TABLE IF EXISTS nr;
DROP TABLE IF EXISTS l_lc;
DROP TABLE IF EXISTS r_lc;

CREATE TABLE l (x UInt32, lc String) ENGINE = Memory;
CREATE TABLE r (x UInt32, lc String) ENGINE = Memory;
CREATE TABLE nl (x Nullable(UInt32), lc Nullable(String)) ENGINE = Memory;
CREATE TABLE nr (x Nullable(UInt32), lc Nullable(String)) ENGINE = Memory;
CREATE TABLE l_lc (x UInt32, lc LowCardinality(String)) ENGINE = Memory;
CREATE TABLE r_lc (x UInt32, lc LowCardinality(String)) ENGINE = Memory;

INSERT INTO r VALUES (0, 'str'),  (1, 'str_r');
INSERT INTO nr VALUES (0, 'str'),  (1, 'str_r');
INSERT INTO r_lc VALUES (0, 'str'),  (1, 'str_r');

INSERT INTO l VALUES (0, 'str'), (2, 'str_l');
INSERT INTO nl VALUES (0, 'str'), (2, 'str_l');
INSERT INTO l_lc VALUES (0, 'str'), (2, 'str_l');

-- { echoOn }
SET allow_experimental_analyzer = 0;

SET join_algorithm = 'default';

SET join_use_nulls = 0;

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

SET join_use_nulls = 1;

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

SET join_algorithm = 'partial_merge';

SET join_use_nulls = 0;

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

SET join_use_nulls = 1;

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

SET join_algorithm = 'parallel_hash';

SET join_use_nulls = 0;

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

SET join_use_nulls = 1;

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

SELECT '--';

SET join_use_nulls = 0;

SELECT lc, toTypeName(lc)  FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY l.lc;

SET join_algorithm = 'partial_merge';
SET join_use_nulls = 1;

SELECT r.lc, materialize(r.lc), toTypeName(r.lc), toTypeName(materialize(r.lc)) FROM l_lc AS l FULL OUTER JOIN r_lc AS r USING (x) ORDER BY r.lc;

SET allow_experimental_analyzer = 1;

SET join_algorithm = 'default';

SET join_use_nulls = 0;

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

SET join_use_nulls = 1;

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

SET join_algorithm = 'partial_merge';

SET join_use_nulls = 0;

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

SET join_use_nulls = 1;

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

SET join_algorithm = 'parallel_hash';

SET join_use_nulls = 0;

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

SET join_use_nulls = 1;

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l RIGHT JOIN r USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l FULL JOIN r USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc RIGHT JOIN nr USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM l_lc FULL JOIN nr USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l RIGHT JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM l_lc AS l FULL JOIN nr AS r USING (lc) ORDER BY x, r.lc, l.lc;

--

SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl RIGHT JOIN r_lc USING (lc) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (x) ORDER BY x, lc;
SELECT lc, toTypeName(lc) FROM nl FULL JOIN r_lc USING (lc) ORDER BY x, lc;

SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l RIGHT JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (x) ORDER BY x, r.lc, l.lc;
SELECT toTypeName(r.lc), toTypeName(materialize(r.lc)), r.lc, materialize(r.lc), toTypeName(l.lc), toTypeName(materialize(l.lc)), l.lc, materialize(l.lc) FROM nl AS l FULL JOIN r_lc AS r USING (lc) ORDER BY x, r.lc, l.lc;

SELECT '--';

SET join_use_nulls = 0;

SELECT lc, toTypeName(lc)  FROM l_lc AS l RIGHT JOIN r_lc AS r USING (x) ORDER BY l.lc;

SET join_algorithm = 'partial_merge';
SET join_use_nulls = 1;

SELECT r.lc, materialize(r.lc), toTypeName(r.lc), toTypeName(materialize(r.lc)) FROM l_lc AS l FULL OUTER JOIN r_lc AS r USING (x) ORDER BY r.lc;

DROP TABLE l;
DROP TABLE r;
DROP TABLE nl;
DROP TABLE nr;
DROP TABLE l_lc;
DROP TABLE r_lc;
