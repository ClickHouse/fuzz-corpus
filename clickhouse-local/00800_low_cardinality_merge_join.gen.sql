SET allow_experimental_analyzer = 1;

SET join_algorithm = 'partial_merge';

SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(dummy) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(dummy) AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(dummy) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(dummy) AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(dummy) AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(dummy) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s2 USING val ORDER BY val;
SELECT '-';
SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS val FROM system.one) s2 ON val + 0 = val * 1 ORDER BY val; -- { serverError 403 }
SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(dummy) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(dummy) AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(dummy) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(dummy) AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(dummy)) AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(dummy) AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(dummy) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(dummy)) AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(dummy)) AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT '-';
SELECT * FROM (SELECT number AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT number AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;
SELECT * FROM (SELECT toLowCardinality(number) AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT number AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;
SELECT * FROM (SELECT number AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT toLowCardinality(number) AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;
SELECT * FROM (SELECT toLowCardinality(number) AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT toLowCardinality(number) AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;
SELECT * FROM (SELECT toLowCardinality(toNullable(number)) AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT toLowCardinality(number) AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;
SELECT * FROM (SELECT toLowCardinality(number) AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(number)) AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;
SELECT * FROM (SELECT toLowCardinality(toNullable(number)) AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(number)) AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;

SET join_algorithm = 'full_sorting_merge';

SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(dummy) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(dummy) AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(dummy) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(dummy) AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(dummy) AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(dummy) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s2 USING val ORDER BY val;
SELECT '-';
SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS val FROM system.one) s2 ON val + 0 = val * 1 ORDER BY val; -- { serverError 403 }
SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(dummy) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(dummy) AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(dummy) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(dummy) AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(dummy)) AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(dummy) AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(dummy) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(dummy)) AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(dummy)) AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT '-';
SELECT * FROM (SELECT number AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT number AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;
SELECT * FROM (SELECT toLowCardinality(number) AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT number AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;
SELECT * FROM (SELECT number AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT toLowCardinality(number) AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;
SELECT * FROM (SELECT toLowCardinality(number) AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT toLowCardinality(number) AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;
SELECT * FROM (SELECT toLowCardinality(toNullable(number)) AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT toLowCardinality(number) AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;
SELECT * FROM (SELECT toLowCardinality(number) AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(number)) AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;
SELECT * FROM (SELECT toLowCardinality(toNullable(number)) AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(number)) AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;

SET join_algorithm = 'grace_hash';

SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(dummy) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(dummy) AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(dummy) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(dummy) AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(dummy) AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(dummy) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s2 USING val ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s2 USING val ORDER BY val;
SELECT '-';
SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS val FROM system.one) s2 ON val + 0 = val * 1 ORDER BY val; -- { serverError 403 }
SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(dummy) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(dummy) AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(dummy) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(dummy) AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT dummy AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT dummy AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(dummy)) AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(dummy) AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(dummy) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(dummy)) AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT * FROM (SELECT toLowCardinality(toNullable(dummy)) AS val FROM system.one) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(dummy)) AS rval FROM system.one) s2 ON val + 0 = rval * 1 ORDER BY val;
SELECT '-';
SELECT * FROM (SELECT number AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT number AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;
SELECT * FROM (SELECT toLowCardinality(number) AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT number AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;
SELECT * FROM (SELECT number AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT toLowCardinality(number) AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;
SELECT * FROM (SELECT toLowCardinality(number) AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT toLowCardinality(number) AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;
SELECT * FROM (SELECT toLowCardinality(toNullable(number)) AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT toLowCardinality(number) AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;
SELECT * FROM (SELECT toLowCardinality(number) AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(number)) AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;
SELECT * FROM (SELECT toLowCardinality(toNullable(number)) AS l FROM system.numbers LIMIT 3) s1 ANY LEFT JOIN (SELECT toLowCardinality(toNullable(number)) AS r FROM system.numbers LIMIT 3) s2 ON l + 1 = r * 1 ORDER BY l;

