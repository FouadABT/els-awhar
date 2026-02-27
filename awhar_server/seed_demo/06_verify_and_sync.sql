-- =====================================================
-- SCRIPT 6: RUN ALL SEED SCRIPTS + ES SYNC GUIDE
-- Master runner script
-- =====================================================

-- ═══════════════════════════════════════════════════════
-- HOW TO RUN ALL SCRIPTS IN ORDER:
-- ═══════════════════════════════════════════════════════
--
-- Option A: Run from psql (recommended):
--   cd awhar_server/seed_demo
--   psql -h localhost -p 8090 -U postgres -d awhar <<EOF
--     \i 00_cleanup.sql
--     \i 01_foundation.sql
--     \i 02_stores_products.sql
--     \i 03_drivers_services.sql
--     \i 04_orders_transactions.sql
--     \i 05_reviews_ratings.sql
--   EOF
--
-- Option B: Run each file individually in order via any SQL client
--
-- ═══════════════════════════════════════════════════════
-- AFTER SEEDING: SYNC TO ELASTICSEARCH
-- ═══════════════════════════════════════════════════════
--
-- Start the Serverpod server first:
--   cd awhar_server
--   dart run bin/main.dart
--
-- Then trigger full ES migration from Flutter/Dart:
--   await client.elasticsearch.migrateAll();
--
-- Or call individual migrations:
--   await client.elasticsearch.migrateUsers();
--   await client.elasticsearch.migrateStores();
--   await client.elasticsearch.migrateProducts();
--   await client.elasticsearch.migrateDrivers();
--   await client.elasticsearch.migrateDriverServices();
--   await client.elasticsearch.migrateServices();
--   await client.elasticsearch.migrateStoreOrders();
--   await client.elasticsearch.migrateTransactions();
--   await client.elasticsearch.migrateRatings();
--   await client.elasticsearch.migrateWallets();
--
-- Or use the admin panel if available.
--
-- ═══════════════════════════════════════════════════════
-- VERIFICATION QUERIES
-- ═══════════════════════════════════════════════════════

-- Summary of all seeded data
SELECT '1. Users' as item, count(*) as count FROM users
UNION ALL SELECT '2. Cities', count(*) FROM cities
UNION ALL SELECT '3. Store Categories', count(*) FROM store_categories
UNION ALL SELECT '4. Stores', count(*) FROM stores
UNION ALL SELECT '5. Product Categories', count(*) FROM product_categories
UNION ALL SELECT '6. Products', count(*) FROM store_products
UNION ALL SELECT '7. Service Categories', count(*) FROM service_categories
UNION ALL SELECT '8. Services', count(*) FROM services
UNION ALL SELECT '9. Driver Profiles', count(*) FROM driver_profiles
UNION ALL SELECT '10. Driver Services', count(*) FROM driver_services
UNION ALL SELECT '11. Driver Statistics', count(*) FROM driver_statistics
UNION ALL SELECT '12. Store Orders', count(*) FROM store_orders
UNION ALL SELECT '13. Service Orders', count(*) FROM orders
UNION ALL SELECT '14. Store Order Items', count(*) FROM store_order_items
UNION ALL SELECT '15. Store Reviews', count(*) FROM store_reviews
UNION ALL SELECT '16. Service Ratings', count(*) FROM ratings
UNION ALL SELECT '17. Transactions', count(*) FROM transactions
UNION ALL SELECT '18. Wallets', count(*) FROM wallets
UNION ALL SELECT '19. Addresses', count(*) FROM addresses
UNION ALL SELECT '20. Delivery Requests', count(*) FROM store_delivery_requests
ORDER BY item;

-- Store details with product counts
SELECT s.id, s.name, sc."nameEn" as category, s.city, s.rating,
  s."totalOrders", s."isOpen",
  (SELECT count(*) FROM store_products sp WHERE sp."storeId" = s.id) as products
FROM stores s
JOIN store_categories sc ON s."storeCategoryId" = sc.id
ORDER BY s.id;

-- Driver details with service counts
SELECT dp.id, dp."displayName",
  CASE dp."vehicleType" WHEN 0 THEN 'Car' WHEN 1 THEN 'Motorcycle' WHEN 2 THEN 'Van' ELSE 'Other' END as vehicle,
  dp."ratingAverage", dp."totalCompletedOrders", dp."isOnline",
  (SELECT count(*) FROM driver_services ds WHERE ds."driverId" = dp.id) as services
FROM driver_profiles dp
ORDER BY dp.id;

-- Recent orders status breakdown
SELECT
  CASE status WHEN 0 THEN 'Pending' WHEN 1 THEN 'Confirmed' WHEN 2 THEN 'Preparing'
    WHEN 3 THEN 'Ready' WHEN 4 THEN 'Picked Up' WHEN 5 THEN 'Delivered' WHEN 6 THEN 'Cancelled' END as status,
  count(*) as count,
  round(avg(total)::numeric, 2) as avg_total
FROM store_orders
GROUP BY status ORDER BY status;
