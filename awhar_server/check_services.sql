-- Check if services table has categoryId column that references categories or service_categories
SELECT s.id, s."nameEn", s."categoryId", c."nameEn" as category_name
FROM services s
LEFT JOIN categories c ON s."categoryId" = c.id
LIMIT 5;
