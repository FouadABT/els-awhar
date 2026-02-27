-- Fix empty phoneNumber strings by setting them to NULL
-- This allows multiple users without phone numbers due to nullable unique constraint

UPDATE users 
SET "phoneNumber" = NULL 
WHERE "phoneNumber" = '' OR TRIM("phoneNumber") = '';

-- Check results
SELECT id, "fullName", "phoneNumber", email 
FROM users 
ORDER BY id;
