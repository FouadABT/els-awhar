-- ===================================================
-- TEST DATA VERIFICATION SCRIPT
-- Run this to verify all test data is present
-- ===================================================

\echo '========================================='
\echo 'TEST USERS'
\echo '========================================='
SELECT 
  id,
  email,
  "fullName",
  roles::text as roles
FROM users 
WHERE id IN (1, 2)
ORDER BY id;

\echo ''
\echo '========================================='
\echo 'DRIVER PROFILE'
\echo '========================================='
SELECT 
  id as profile_id,
  "userId",
  "displayName",
  "vehicleMake" || ' ' || "vehicleModel" as vehicle,
  "totalCompletedOrders",
  "totalEarnings",
  "ratingAverage"
FROM driver_profiles
WHERE "userId" = 2;

\echo ''
\echo '========================================='
\echo 'CLIENT SERVICE REQUESTS (User ID 1)'
\echo '========================================='
SELECT 
  id,
  "serviceType",
  status,
  "agreedPrice",
  to_char("createdAt", 'YYYY-MM-DD HH24:MI') as created
FROM service_requests
WHERE "clientId" = 1
ORDER BY "createdAt" DESC;

\echo ''
\echo '========================================='
\echo 'DRIVER SERVICE REQUESTS (User ID 2)'
\echo '========================================='
SELECT 
  id,
  "serviceType",
  status,
  "agreedPrice",
  to_char("createdAt", 'YYYY-MM-DD HH24:MI') as created
FROM service_requests
WHERE "driverId" = 2
ORDER BY "acceptedAt" DESC NULLS LAST;

\echo ''
\echo '========================================='
\echo 'DRIVER TRANSACTIONS (User ID 2)'
\echo '========================================='
SELECT 
  id,
  "requestId",
  "amount",
  "driverEarnings",
  "platformCommission",
  type::text as type,
  status::text as status
FROM transactions
WHERE "userId" = 2
ORDER BY "createdAt" DESC;

\echo ''
\echo '========================================='
\echo 'SUMMARY COUNTS'
\echo '========================================='
SELECT 
  'Client Total Requests' as metric,
  COUNT(*)::text as value
FROM service_requests WHERE "clientId" = 1
UNION ALL
SELECT 
  'Driver Total Requests',
  COUNT(*)::text
FROM service_requests WHERE "driverId" = 2
UNION ALL
SELECT 
  'Driver Active Requests',
  COUNT(*)::text
FROM service_requests WHERE "driverId" = 2 AND status IN ('pending', 'accepted', 'in_progress')
UNION ALL
SELECT 
  'Driver Transactions',
  COUNT(*)::text
FROM transactions WHERE "userId" = 2
UNION ALL
SELECT 
  'Driver Total Earnings',
  ROUND(SUM("driverEarnings")::numeric, 2)::text || ' MAD'
FROM transactions WHERE "userId" = 2;
