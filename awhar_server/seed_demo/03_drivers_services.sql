-- =====================================================
-- SCRIPT 3: DRIVERS & SERVICES - Taza drivers with service offerings
-- 6 drivers (existing users 2,9,10,11 + 2 new) with varied services
-- =====================================================

BEGIN;

-- ── New driver users (IDs 19-20) ───────────────────
INSERT INTO users (id, "firebaseUid", "fullName", "phoneNumber", email, roles, status, "isPhoneVerified", "isEmailVerified",
  "currentLatitude", "currentLongitude", "lastLocationUpdate")
VALUES
(19, 'demo_driver_user_19', 'Karim Ait Brahim',   '+212661198765', 'karim.driver@awhar.demo',   '[1]', 0, true, true, 34.2160, -4.0040, NOW() - INTERVAL '15 minutes'),
(20, 'demo_driver_user_20', 'Hassan Tazi',         '+212662287654', 'hassan.driver@awhar.demo',  '[1]', 0, true, true, 34.2080, -4.0190, NOW() - INTERVAL '30 minutes');

-- New driver user_clients (not really clients, but some may have dual roles)
-- Wallets for new drivers
INSERT INTO wallets ("userId", "totalEarned", "totalSpent", "pendingEarnings", "totalTransactions", "completedRides", "totalCommissionPaid", currency)
VALUES
(19, 1200.00, 0, 65.00,  10, 8,  63.16, 'MAD'),
(20, 2800.00, 0, 130.00, 20, 16, 147.37, 'MAD');

-- Update existing driver user locations to Taza
UPDATE users SET "currentLatitude" = 34.2145, "currentLongitude" = -4.0095, "lastLocationUpdate" = NOW() - INTERVAL '5 minutes' WHERE id = 2;
UPDATE users SET "currentLatitude" = 34.2170, "currentLongitude" = -4.0030, "lastLocationUpdate" = NOW() - INTERVAL '10 minutes' WHERE id = 9;
UPDATE users SET "currentLatitude" = 34.2050, "currentLongitude" = -4.0170, "lastLocationUpdate" = NOW() - INTERVAL '20 minutes' WHERE id = 10;
UPDATE users SET "currentLatitude" = 34.2190, "currentLongitude" = -4.0060, "lastLocationUpdate" = NOW() - INTERVAL '8 minutes' WHERE id = 11;

-- ── Driver Profiles ────────────────────────────────
-- vehicleType: 0=car, 1=motorcycle, 2=van, 3=bicycle
-- availabilityStatus: 0=available, 1=busy, 2=offline
INSERT INTO driver_profiles (id, "userId", "displayName", bio, "vehicleType", "vehicleMake", "vehicleModel", "vehiclePlate", "vehicleYear",
  "experienceYears", "availabilityStatus", "baseCityId", "isOnline", "lastLocationLat", "lastLocationLng", "lastLocationUpdatedAt",
  "ratingAverage", "ratingCount", "isVerified", "isDocumentsSubmitted", "isFeatured", "isPremium",
  "totalCompletedOrders", "totalEarnings")
VALUES
-- Driver 1: Fouad Driver (user 2) - Car driver, experienced
(1, 2, 'Fouad Abatouy', 'Chauffeur expérimenté à Taza, je connais chaque rue de la ville. Service rapide et fiable.',
  0, 'Toyota', 'Corolla', '12345-A-1', 2020, 5, 0, 1, true,
  34.2145, -4.0095, NOW() - INTERVAL '5 minutes',
  4.8, 45, true, true, true, false, 62, 3200.00),

-- Driver 2: Mohamed El Fassi (user 9) - Car, top rated
(2, 9, 'Mohamed El Fassi', 'Conducteur professionnel, spécialisé dans les trajets interurbains Taza-Fès-Oujda.',
  0, 'Dacia', 'Logan', '67890-B-2', 2021, 4, 0, 1, true,
  34.2170, -4.0030, NOW() - INTERVAL '10 minutes',
  4.9, 78, true, true, true, true, 98, 5800.00),

-- Driver 3: Fatima Zahra (user 10) - Motorcycle, fast delivery
(3, 10, 'Fatima Zahra', 'Livreuse rapide en moto. Spécialisée dans la livraison de repas et colis urgents.',
  1, 'Honda', 'PCX 125', 'M-34521', 2022, 3, 0, 1, true,
  34.2050, -4.0170, NOW() - INTERVAL '20 minutes',
  4.7, 52, true, true, false, false, 45, 2100.00),

-- Driver 4: Omar Bennani (user 11) - Van, moving specialist
(4, 11, 'Omar Bennani', 'Transport et déménagement à Taza. Grand véhicule pour vos gros colis et meubles.',
  2, 'Renault', 'Kangoo', '23456-C-3', 2019, 6, 0, 1, true,
  34.2190, -4.0060, NOW() - INTERVAL '8 minutes',
  4.6, 34, true, true, false, false, 38, 1800.00),

-- Driver 5: Karim Ait Brahim (user 19) - Motorcycle, food delivery
(5, 19, 'Karim Ait Brahim', 'Livreur rapide, courses et colis dans tout Taza. Toujours ponctuel!',
  1, 'Yamaha', 'NMAX', 'M-56789', 2023, 2, 0, 1, true,
  34.2160, -4.0040, NOW() - INTERVAL '15 minutes',
  4.5, 28, true, true, false, false, 25, 1200.00),

-- Driver 6: Hassan Tazi (user 20) - Car, premium service
(6, 20, 'Hassan Tazi', 'Service premium avec véhicule confortable. Transferts aéroport et voyages longue distance.',
  0, 'Hyundai', 'Tucson', '78901-D-4', 2023, 8, 1, 1, false,
  34.2080, -4.0190, NOW() - INTERVAL '30 minutes',
  4.85, 42, true, true, true, true, 55, 2800.00);

SELECT setval('driver_profiles_id_seq', 6);
SELECT setval('users_id_seq', 20);

-- ── Driver Services ────────────────────────────────
-- Link drivers to services they offer with pricing
-- service_categories: 1=Transport, 2=Delivery, 3=Shopping, 4=Moving, 5=Food, 6=Professional
-- services: 1-4 (Transport), 5-8 (Delivery), 9-12 (Shopping), 13-16 (Moving), 17-19 (Food), 20-22 (Professional)

INSERT INTO driver_services ("driverId", "serviceId", "categoryId", "priceType", "basePrice", "pricePerKm", "minPrice",
  title, description, "viewCount", "inquiryCount", "bookingCount", "isAvailable", "isActive", "displayOrder")
VALUES
-- Fouad (driver 1) - City rides + deliveries
(1, 1, 1, 0, 25.00, 3.50, 20.00, 'Course en ville Taza',        'Transport rapide dans Taza et environs',       120, 45, 30, true, true, 1),
(1, 4, 1, 0, 200.00, 2.00, 150.00, 'Taza → Fès / Oujda',       'Voyages interurbains confortables',             85, 30, 15, true, true, 2),
(1, 5, 2, 0, 20.00, 2.50, 15.00, 'Livraison de colis',          'Colis et documents dans Taza',                  90, 35, 22, true, true, 3),

-- Mohamed (driver 2) - Intercity specialist + premium rides
(2, 1,  1, 0, 30.00, 4.00, 25.00, 'Course Premium Taza',         'Service premium, véhicule récent',             180, 65, 48, true, true, 1),
(2, 2,  1, 0, 200.00, 2.50, 180.00, 'Transfert Aéroport Fès',   'Transfert direct Taza-Aéroport Fès Saïss',     95, 40, 25, true, true, 2),
(2, 4,  1, 0, 180.00, 1.80, 150.00, 'Voyage Interurbain',        'Taza-Fès, Taza-Oujda, Taza-Al Hoceima',       150, 55, 35, true, true, 3),
(2, 3,  1, 1, NULL, NULL, NULL,      'Location à l''heure',       'Chauffeur privé à votre disposition',           60, 20, 10, true, true, 4),
-- Mohamed also does professional errands
(2, 20, 6, 0, 50.00, NULL, 30.00,  'Courses professionnelles',   'Documents administratifs, banque, poste',       40, 15, 8,  true, true, 5),

-- Fatima (driver 3) - Fast motorcycle delivery
(3, 5,  2, 0, 15.00, 2.00, 10.00, 'Livraison Express Moto',      'Livraison ultra-rapide en moto',              200, 80, 55, true, true, 1),
(3, 6,  2, 0, 10.00, 1.50, 8.00,  'Coursier Documents',          'Documents urgents, plis confidentiels',         75, 30, 20, true, true, 2),
(3, 17, 5, 0, 12.00, 2.00, 10.00, 'Livraison Restaurant',        'Repas chauds livrés rapidement',              160, 60, 42, true, true, 3),
(3, 10, 3, 0, 20.00, 2.00, 15.00, 'Course à la Pharmacie',       'Médicaments et parapharmacie',                 55, 22, 15, true, true, 4),

-- Omar (driver 4) - Van for moving & large deliveries
(4, 13, 4, 0, 250.00, 5.00, 200.00, 'Déménagement Meubles',     'Transport de meubles et électroménager',        90, 35, 22, true, true, 1),
(4, 14, 4, 0, 80.00,  3.00, 50.00,  'Transport Objets Moyens',  'Articles trop gros pour une voiture',           70, 28, 18, true, true, 2),
(4, 15, 4, 0, 600.00, 4.00, 500.00, 'Déménagement Complet',     'Maison complète, chargement/déchargement',      45, 18, 8,  true, true, 3),
(4, 8,  2, 0, 40.00,  3.50, 30.00,  'Articles Fragiles',        'Transport soigné d''objets fragiles',           50, 20, 12, true, true, 4),

-- Karim (driver 5) - Motorcycle food & package delivery
(5, 17, 5, 0, 10.00, 1.50, 8.00,   'Livraison Nourriture',       'Repas livrés chauds en 20min',               130, 50, 35, true, true, 1),
(5, 18, 5, 0, 8.00,  1.00, 6.00,   'Fast Food Pickup',           'Récupération et livraison fast food',         100, 40, 28, true, true, 2),
(5, 5,  2, 0, 12.00, 1.80, 10.00,  'Petit Colis Express',        'Colis légers, livraison même jour',           80,  32, 20, true, true, 3),
(5, 9,  3, 0, 25.00, 2.00, 20.00,  'Courses au Souk',            'Fruits, légumes, épices du souk de Taza',     45,  18, 10, true, true, 4),

-- Hassan (driver 6) - Premium car service
(6, 1,  1, 0, 40.00, 5.00, 35.00,  'Course VIP Taza',            'Service haut de gamme, SUV climatisé',         95,  38, 25, true, true, 1),
(6, 2,  1, 0, 250.00, 3.00, 220.00,'Transfert Aéroport Premium', 'Véhicule premium, eau et wifi à bord',         75,  30, 18, true, true, 2),
(6, 4,  1, 0, 220.00, 2.50, 200.00,'Voyage Longue Distance',     'Confort premium pour longs trajets',           60,  25, 15, true, true, 3),
(6, 19, 5, 0, 150.00, 3.00, 120.00,'Livraison Traiteur',         'Transport soigné de plateaux traiteur',        30,  12, 6,  true, true, 4);

-- ── Driver Statistics ──────────────────────────────
-- Weekly and monthly stats for the past period
INSERT INTO driver_statistics ("driverId", "periodType", "periodStart", "periodEnd",
  "totalOrders", "completedOrders", "cancelledOrders",
  "totalRevenue", "platformCommission", "netRevenue",
  "averageRating", "averageResponseTime", "averageCompletionTime",
  "hoursOnline", "hoursOffline")
VALUES
-- Fouad - last week
(1, 'weekly', NOW() - INTERVAL '7 days', NOW(),
  12, 10, 1, 850.00, 42.50, 807.50, 4.8, 120, 1800, 42.0, 126.0),
-- Fouad - last month
(1, 'monthly', NOW() - INTERVAL '30 days', NOW(),
  45, 38, 3, 3200.00, 160.00, 3040.00, 4.8, 115, 1750, 168.0, 552.0),

-- Mohamed - last week
(2, 'weekly', NOW() - INTERVAL '7 days', NOW(),
  18, 16, 1, 1450.00, 72.50, 1377.50, 4.9, 90, 2100, 48.0, 120.0),
-- Mohamed - last month
(2, 'monthly', NOW() - INTERVAL '30 days', NOW(),
  65, 58, 3, 5800.00, 290.00, 5510.00, 4.9, 95, 2050, 192.0, 528.0),

-- Fatima - last week
(3, 'weekly', NOW() - INTERVAL '7 days', NOW(),
  15, 14, 0, 620.00, 31.00, 589.00, 4.7, 60, 900, 40.0, 128.0),
-- Fatima - last month
(3, 'monthly', NOW() - INTERVAL '30 days', NOW(),
  52, 48, 2, 2100.00, 105.00, 1995.00, 4.7, 65, 950, 160.0, 560.0),

-- Omar - last week
(4, 'weekly', NOW() - INTERVAL '7 days', NOW(),
  6, 5, 0, 580.00, 29.00, 551.00, 4.6, 180, 3600, 30.0, 138.0),
-- Omar - last month
(4, 'monthly', NOW() - INTERVAL '30 days', NOW(),
  22, 18, 2, 1800.00, 90.00, 1710.00, 4.6, 175, 3500, 120.0, 600.0),

-- Karim - last week
(5, 'weekly', NOW() - INTERVAL '7 days', NOW(),
  14, 13, 1, 480.00, 24.00, 456.00, 4.5, 55, 850, 38.0, 130.0),
-- Karim - last month
(5, 'monthly', NOW() - INTERVAL '30 days', NOW(),
  48, 42, 3, 1200.00, 60.00, 1140.00, 4.5, 58, 870, 152.0, 568.0),

-- Hassan - last week
(6, 'weekly', NOW() - INTERVAL '7 days', NOW(),
  8, 7, 0, 920.00, 46.00, 874.00, 4.85, 100, 2400, 35.0, 133.0),
-- Hassan - last month
(6, 'monthly', NOW() - INTERVAL '30 days', NOW(),
  30, 26, 2, 2800.00, 140.00, 2660.00, 4.85, 105, 2350, 140.0, 580.0);

COMMIT;

-- Verify
SELECT dp.id, dp."displayName", dp."vehicleType", dp."ratingAverage", dp."totalCompletedOrders",
  (SELECT count(*) FROM driver_services ds WHERE ds."driverId" = dp.id) as services_offered
FROM driver_profiles dp ORDER BY dp.id;
