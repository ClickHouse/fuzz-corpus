SET join_algorithm = 'default';

SELECT deleted
FROM (
    SELECT 1 AS deleted, 'k' AS a, 'v' AS b
) AS q
INNER JOIN (
    SELECT 'k' AS a, 'v' AS c
) AS s
ON q.a = s.a
WHERE deleted AND (b = c);

SET join_algorithm = 'full_sorting_merge';

SELECT deleted
FROM (
    SELECT 1 AS deleted, 'k' AS a, 'v' AS b
) AS q
INNER JOIN (
    SELECT 'k' AS a, 'v' AS c
) AS s
ON q.a = s.a
WHERE deleted AND (b = c);

SET join_algorithm = 'hash';

SELECT deleted
FROM (
    SELECT 1 AS deleted, 'k' AS a, 'v' AS b
) AS q
INNER JOIN (
    SELECT 'k' AS a, 'v' AS c
) AS s
ON q.a = s.a
WHERE deleted AND (b = c);

SET join_algorithm = 'partial_merge';

SELECT deleted
FROM (
    SELECT 1 AS deleted, 'k' AS a, 'v' AS b
) AS q
INNER JOIN (
    SELECT 'k' AS a, 'v' AS c
) AS s
ON q.a = s.a
WHERE deleted AND (b = c);

SET join_algorithm = 'grace_hash';

SELECT deleted
FROM (
    SELECT 1 AS deleted, 'k' AS a, 'v' AS b
) AS q
INNER JOIN (
    SELECT 'k' AS a, 'v' AS c
) AS s
ON q.a = s.a
WHERE deleted AND (b = c);

