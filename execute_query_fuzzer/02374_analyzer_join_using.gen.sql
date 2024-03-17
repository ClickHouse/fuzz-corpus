SET allow_experimental_analyzer = 1;

DROP TABLE IF EXISTS test_table_join_1;
CREATE TABLE test_table_join_1
(
    id UInt8,
    value String
) ENGINE = TinyLog;

DROP TABLE IF EXISTS test_table_join_2;
CREATE TABLE test_table_join_2
(
    id UInt16,
    value String
) ENGINE = TinyLog;

DROP TABLE IF EXISTS test_table_join_3;
CREATE TABLE test_table_join_3
(
    id UInt64,
    value String
) ENGINE = TinyLog;

INSERT INTO test_table_join_1 VALUES (0, 'Join_1_Value_0');
INSERT INTO test_table_join_1 VALUES (1, 'Join_1_Value_1');
INSERT INTO test_table_join_1 VALUES (2, 'Join_1_Value_2');

INSERT INTO test_table_join_2 VALUES (0, 'Join_2_Value_0');
INSERT INTO test_table_join_2 VALUES (1, 'Join_2_Value_1');
INSERT INTO test_table_join_2 VALUES (3, 'Join_2_Value_3');

INSERT INTO test_table_join_3 VALUES (0, 'Join_3_Value_0');
INSERT INTO test_table_join_3 VALUES (1, 'Join_3_Value_1');
INSERT INTO test_table_join_3 VALUES (4, 'Join_3_Value_4');

-- { echoOn }

SELECT 'JOIN INNER';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value)
FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 USING (id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value)
FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 USING (id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 USING (id);

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value)
FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 USING (test_value); -- { serverError 47 }

SELECT 'JOIN LEFT';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value)
FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 USING (id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value)
FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 USING (id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 USING (id);

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value)
FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 USING (test_value); -- { serverError 47 }

SELECT 'JOIN RIGHT';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value)
FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 USING (id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value)
FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 USING (id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 USING (id);

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value)
FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 USING (test_value); -- { serverError 47 }

SELECT 'JOIN FULL';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value)
FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 USING (id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value)
FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 USING (id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 USING (id);

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value)
FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 USING (test_value); -- { serverError 47 }



SELECT 'First JOIN INNER second JOIN INNER';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value), t3.id AS t3_id, toTypeName(t3_id), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 USING (id) INNER JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 USING (id) INNER JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 USING (id) INNER JOIN test_table_join_3 AS t3 USING(id);

SELECT id FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 ON t1.id = t2.id INNER JOIN test_table_join_3 AS t3 USING (id); -- { serverError 207 }

SELECT 'First JOIN INNER second JOIN LEFT';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value), t3.id AS t3_id, toTypeName(t3_id), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 USING (id) LEFT JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 USING (id) LEFT JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 USING (id) LEFT JOIN test_table_join_3 AS t3 USING(id);

SELECT id FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 ON t1.id = t2.id LEFT JOIN test_table_join_3 AS t3 USING (id); -- { serverError 207 }

SELECT 'First JOIN INNER second JOIN RIGHT';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value), t3.id AS t3_id, toTypeName(t3_id), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 USING (id) RIGHT JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 USING (id) RIGHT JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 USING (id) RIGHT JOIN test_table_join_3 AS t3 USING(id);

SELECT id FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 ON t1.id = t2.id RIGHT JOIN test_table_join_3 AS t3 USING (id); -- { serverError 207 }

SELECT 'First JOIN INNER second JOIN FULL';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value), t3.id AS t3_id, toTypeName(t3_id), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 USING (id) FULL JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 USING (id) FULL JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 USING (id) FULL JOIN test_table_join_3 AS t3 USING(id);

SELECT id FROM test_table_join_1 AS t1 INNER JOIN test_table_join_2 AS t2 ON t1.id = t2.id FULL JOIN test_table_join_3 AS t3 USING (id); -- { serverError 207 }


SELECT 'First JOIN LEFT second JOIN INNER';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value), t3.id AS t3_id, toTypeName(t3_id), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 USING (id) INNER JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 USING (id) INNER JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 USING (id) INNER JOIN test_table_join_3 AS t3 USING(id);

SELECT id FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 ON t1.id = t2.id INNER JOIN test_table_join_3 AS t3 USING (id); -- { serverError 207 }

SELECT 'First JOIN LEFT second JOIN LEFT';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value), t3.id AS t3_id, toTypeName(t3_id), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 USING (id) LEFT JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 USING (id) LEFT JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 USING (id) LEFT JOIN test_table_join_3 AS t3 USING(id);

SELECT id FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 ON t1.id = t2.id LEFT JOIN test_table_join_3 AS t3 USING (id); -- { serverError 207 }

SELECT 'First JOIN LEFT second JOIN RIGHT';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value), t3.id AS t3_id, toTypeName(t3_id), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 USING (id) RIGHT JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 USING (id) RIGHT JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 USING (id) RIGHT JOIN test_table_join_3 AS t3 USING(id);

SELECT id FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 ON t1.id = t2.id RIGHT JOIN test_table_join_3 AS t3 USING (id); -- { serverError 207 }

SELECT 'First JOIN LEFT second JOIN FULL';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value), t3.id AS t3_id, toTypeName(t3_id), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 USING (id) FULL JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 USING (id) FULL JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 USING (id) FULL JOIN test_table_join_3 AS t3 USING(id);

SELECT id FROM test_table_join_1 AS t1 LEFT JOIN test_table_join_2 AS t2 ON t1.id = t2.id FULL JOIN test_table_join_3 AS t3 USING (id); -- { serverError 207 }


SELECT 'First JOIN RIGHT second JOIN INNER';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value), t3.id AS t3_id, toTypeName(t3_id), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 USING (id) INNER JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 USING (id) INNER JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 USING (id) INNER JOIN test_table_join_3 AS t3 USING(id);

SELECT id FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 ON t1.id = t2.id INNER JOIN test_table_join_3 AS t3 USING (id); -- { serverError 207 }

SELECT 'First JOIN RIGHT second JOIN LEFT';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value), t3.id AS t3_id, toTypeName(t3_id), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 USING (id) LEFT JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 USING (id) LEFT JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 USING (id) LEFT JOIN test_table_join_3 AS t3 USING(id);

SELECT id FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 ON t1.id = t2.id LEFT JOIN test_table_join_3 AS t3 USING (id); -- { serverError 207 }

SELECT 'First JOIN RIGHT second JOIN RIGHT';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value), t3.id AS t3_id, toTypeName(t3_id), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 USING (id) RIGHT JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 USING (id) RIGHT JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 USING (id) RIGHT JOIN test_table_join_3 AS t3 USING(id);

SELECT id FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 ON t1.id = t2.id RIGHT JOIN test_table_join_3 AS t3 USING (id); -- { serverError 207 }

SELECT 'First JOIN RIGHT second JOIN FULL';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value), t3.id AS t3_id, toTypeName(t3_id), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 USING (id) FULL JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 USING (id) FULL JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 USING (id) FULL JOIN test_table_join_3 AS t3 USING(id);

SELECT id FROM test_table_join_1 AS t1 RIGHT JOIN test_table_join_2 AS t2 ON t1.id = t2.id FULL JOIN test_table_join_3 AS t3 USING (id); -- { serverError 207 }


SELECT 'First JOIN FULL second JOIN INNER';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value), t3.id AS t3_id, toTypeName(t3_id), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 USING (id) INNER JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 USING (id) INNER JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 USING (id) INNER JOIN test_table_join_3 AS t3 USING(id);

SELECT id FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 ON t1.id = t2.id INNER JOIN test_table_join_3 AS t3 USING (id); -- { serverError 207 }

SELECT 'First JOIN FULL second JOIN LEFT';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value), t3.id AS t3_id, toTypeName(t3_id), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 USING (id) LEFT JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 USING (id) LEFT JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 USING (id) LEFT JOIN test_table_join_3 AS t3 USING(id);

SELECT id FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 ON t1.id = t2.id LEFT JOIN test_table_join_3 AS t3 USING (id); -- { serverError 207 }

SELECT 'First JOIN FULL second JOIN RIGHT';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value), t3.id AS t3_id, toTypeName(t3_id), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 USING (id) RIGHT JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 USING (id) RIGHT JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 USING (id) RIGHT JOIN test_table_join_3 AS t3 USING(id);

SELECT id FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 ON t1.id = t2.id RIGHT JOIN test_table_join_3 AS t3 USING (id); -- { serverError 207 }

SELECT 'First JOIN FULL second JOIN FULL';

SELECT id AS using_id, toTypeName(using_id), t1.id AS t1_id, toTypeName(t1_id), t1.value AS t1_value, toTypeName(t1_value),
t2.id AS t2_id, toTypeName(t2_id), t2.value AS t2_value, toTypeName(t2_value), t3.id AS t3_id, toTypeName(t3_id), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 USING (id) FULL JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT t1.value AS t1_value, toTypeName(t1_value), t2.value AS t2_value, toTypeName(t2_value), t3.value AS t3_value, toTypeName(t3_value)
FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 USING (id) FULL JOIN test_table_join_3 AS t3 USING(id);

SELECT '--';

SELECT 1 FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 USING (id) FULL JOIN test_table_join_3 AS t3 USING(id);

SELECT id FROM test_table_join_1 AS t1 FULL JOIN test_table_join_2 AS t2 ON t1.id = t2.id FULL JOIN test_table_join_3 AS t3 USING (id); -- { serverError 207 }




-- { echoOff }

DROP TABLE test_table_join_1;
DROP TABLE test_table_join_2;
DROP TABLE test_table_join_3;
