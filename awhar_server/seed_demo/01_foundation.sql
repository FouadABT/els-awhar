-- =====================================================
-- SCRIPT 1: FOUNDATION - Countries, Cities, Wallets, Addresses
-- Taza, Morocco focus + nearby cities
-- =====================================================

BEGIN;

-- ── Countries ──────────────────────────────────────
INSERT INTO countries (id, code, name, "nameAr", "nameFr", "currencyCode", "currencySymbol", "currencyName", "currencyNameAr", "vatRate", "vatName", "phonePrefix", "phonePlaceholder", "defaultLanguage", "minPrice", "commissionRate", "exchangeRateToMAD", "isActive", "isDefault")
VALUES
(1, 'MA', 'Morocco', 'المغرب', 'Maroc', 'MAD', 'DH', 'Moroccan Dirham', 'درهم مغربي', 0.20, 'TVA', '+212', '06XXXXXXXX', 'fr', 15.0, 0.05, 1.0, true, true);

-- ── Cities ─────────────────────────────────────────
-- Taza (main) + nearby cities for intercity routes
INSERT INTO cities (id, "nameEn", "nameAr", "nameFr", "nameEs", "countryCode", latitude, longitude, "isActive", "isPopular", "displayOrder", "defaultDeliveryRadius")
VALUES
(1, 'Taza',       'تازة',       'Taza',       'Taza',       'MA', 34.2100, -4.0100, true, true, 1, 10.0),
(2, 'Fes',        'فاس',       'Fès',        'Fez',        'MA', 34.0181, -5.0078, true, true, 2, 12.0),
(3, 'Oujda',      'وجدة',      'Oujda',      'Oujda',      'MA', 34.6814, -1.9086, true, true, 3, 10.0),
(4, 'Al Hoceima', 'الحسيمة',    'Al Hoceïma', 'Alhucemas',  'MA', 35.2517, -3.9372, true, false, 4, 8.0),
(5, 'Guercif',    'جرسيف',     'Guercif',    'Guercif',    'MA', 34.2265, -3.3532, true, false, 5, 8.0);

-- ── Wallets for all existing users ─────────────────
-- User 1: Fouad (client), User 2: fouad Driver, User 5: Store A
-- Users 6-8: clients, Users 9-11: drivers, Users 12-14: store owners
INSERT INTO wallets ("userId", "totalEarned", "totalSpent", "pendingEarnings", "totalTransactions", "completedRides", "totalCommissionPaid", currency)
VALUES
-- Clients
(1,  0,      1250.00, 0, 8,  0, 0, 'MAD'),
(6,  0,       890.00, 0, 5,  0, 0, 'MAD'),
(7,  0,      2100.00, 0, 12, 0, 0, 'MAD'),
(8,  0,      1500.00, 0, 9,  0, 0, 'MAD'),
-- Drivers
(2,  3200.00, 0, 150.00, 22, 18, 168.42, 'MAD'),
(9,  5800.00, 0, 280.00, 38, 32, 305.26, 'MAD'),
(10, 2100.00, 0,  90.00, 14, 12, 110.53, 'MAD'),
(11, 1800.00, 0, 120.00, 12, 10,  94.74, 'MAD'),
-- Store owners
(5,  4500.00, 0, 200.00, 30, 0, 236.84, 'MAD'),
(12, 8200.00, 0, 350.00, 55, 0, 431.58, 'MAD'),
(13, 6100.00, 0, 180.00, 40, 0, 321.05, 'MAD'),
(14, 3800.00, 0, 160.00, 25, 0, 200.00, 'MAD');

-- ── Addresses in Taza ──────────────────────────────
-- Real Taza neighborhoods and streets
INSERT INTO addresses ("userId", label, "fullAddress", "cityId", latitude, longitude, "buildingNumber", floor, landmark, "isDefault")
VALUES
-- Client addresses (Fouad - user 1)
(1, 'Maison',    'Hay Al Amal, Rue 12, Taza',           1, 34.2150, -4.0080, '12', NULL, 'Près de la mosquée Al Amal', true),
(1, 'Bureau',    'Centre Ville, Avenue Hassan II, Taza', 1, 34.2095, -4.0120, '45', '2', 'Immeuble El Baraka', false),
-- Client 6
(6, 'Maison',    'Quartier Bab Zitoun, Taza',            1, 34.2180, -4.0050, '8',  NULL, 'Face au parc municipal', true),
-- Client 7 (Sarah)
(7, 'Maison',    'Hay Riad, Rue 5, Taza',                1, 34.2070, -4.0150, '22', NULL, 'À côté du lycée Ibn Sina', true),
(7, 'Travail',   'Zone Industrielle, Taza',               1, 34.2200, -3.9950, '3',  NULL, 'Entrée principale ZI', false),
-- Client 8 (Youssef)  
(8, 'Maison',    'Taza Haute, Derb Lakhdar, Taza',       1, 34.2120, -4.0200, '15', NULL, 'Ancienne médina', true),
(8, 'Gym',       'Avenue Mohammed V, Taza',               1, 34.2100, -4.0100, '78', NULL, 'En face du Marjane', false);

-- Update user_clients with city and address references
UPDATE user_clients SET "defaultCityId" = 1, "defaultAddressId" = 1 WHERE "userId" = 1;
UPDATE user_clients SET "defaultCityId" = 1, "defaultAddressId" = 3 WHERE "userId" = 6;
UPDATE user_clients SET "defaultCityId" = 1, "defaultAddressId" = 4 WHERE "userId" = 7;
UPDATE user_clients SET "defaultCityId" = 1, "defaultAddressId" = 6 WHERE "userId" = 8;

-- Update user locations to Taza area
UPDATE users SET "currentLatitude" = 34.2150, "currentLongitude" = -4.0080 WHERE id = 1;
UPDATE users SET "currentLatitude" = 34.2180, "currentLongitude" = -4.0050 WHERE id = 6;
UPDATE users SET "currentLatitude" = 34.2070, "currentLongitude" = -4.0150 WHERE id = 7;
UPDATE users SET "currentLatitude" = 34.2120, "currentLongitude" = -4.0200 WHERE id = 8;

COMMIT;

SELECT 'countries' as tbl, count(*) as cnt FROM countries
UNION ALL SELECT 'cities', count(*) FROM cities
UNION ALL SELECT 'wallets', count(*) FROM wallets
UNION ALL SELECT 'addresses', count(*) FROM addresses;
