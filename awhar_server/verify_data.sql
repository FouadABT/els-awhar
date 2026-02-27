-- Verification queries
SELECT COUNT(*) as total_categories FROM categories WHERE "isActive" = true;
SELECT COUNT(*) as total_services FROM services WHERE "isActive" = true;

-- Show categories with service counts
SELECT 
  c.id,
  c."nameEn",
  c."nameAr",
  c."iconName",
  c."displayOrder",
  COUNT(s.id) as service_count
FROM categories c
LEFT JOIN services s ON s."categoryId" = c.id AND s."isActive" = true
WHERE c."isActive" = true
GROUP BY c.id, c."nameEn", c."nameAr", c."iconName", c."displayOrder"
ORDER BY c."displayOrder";
