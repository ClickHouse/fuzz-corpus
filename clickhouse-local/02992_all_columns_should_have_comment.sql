SYSTEM FLUSH LOGS;
SELECT 'Column ' || name || ' from table ' || concat(database, '.', table) || ' should have a comment'
FROM system.columns
WHERE (database = 'system') AND (comment = '') AND (table NOT ILIKE '%_log_%') AND (table NOT IN ('numbers', 'numbers_mt', 'one')) AND (default_kind != 'ALIAS');
