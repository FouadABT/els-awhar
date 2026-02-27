-- =====================================================
-- SCRIPT 4: ORDERS & TRANSACTIONS
-- Store orders (with items, chats, delivery requests) + Service orders
-- Mix of completed, in-progress, and cancelled
-- =====================================================

BEGIN;

-- ══════════════════════════════════════════════════════
-- PART A: STORE ORDERS
-- ══════════════════════════════════════════════════════
-- store_orders.status: 0=pending, 1=confirmed, 2=preparing, 3=ready, 4=picked_up, 5=delivered, 6=cancelled

-- ── Store Order Chats (created before orders that reference them) ──
INSERT INTO store_order_chats (id, "storeOrderId", "clientId", "storeId", "driverId", "isActive")
VALUES
-- We'll set storeOrderId after creating orders. For now use placeholder IDs
-- Actually store_orders has chatId FK → store_order_chats. And store_order_chats has storeOrderId FK → store_orders.
-- This is a circular FK! Let's create chats first without storeOrderId, then update.
(1,  1, 1, 1, 2, true),  -- Will link to order 1
(2,  2, 7, 1, 9, true),
(3,  3, 8, 2, 10, true),
(4,  4, 6, 3, 19, true),
(5,  5, 7, 3, 5, true),  -- driver user 19, profile 5
(6,  6, 1, 4, 9, true),
(7,  7, 8, 2, 10, true),
(8,  8, 7, 5, 9, true),
(9,  9, 6, 1, 11, true),
(10, 10, 1, 3, 19, true),
(11, 11, 8, 4, 20, true),
(12, 12, 7, 7, 10, true),
(13, 13, 1, 2, 9, true),
(14, 14, 6, 6, 11, true),
(15, 15, 8, 1, 2, true),
-- Recent/active orders
(16, 16, 7, 3, NULL, true),
(17, 17, 1, 5, 19, true),
(18, 18, 8, 1, 9, true),
(19, 19, 6, 2, NULL, true),
(20, 20, 7, 4, 20, true);

SELECT setval('store_order_chats_id_seq', 20);

-- ── Store Orders ───────────────────────────────────
-- 20 orders across 8 stores, 4 clients, various drivers
-- Realistic Taza addresses and prices in MAD

INSERT INTO store_orders (id, "orderNumber", "storeId", "clientId", "driverId", status,
  "itemsJson", subtotal, "deliveryFee", total, "platformCommission", "driverEarnings",
  "deliveryAddress", "deliveryLatitude", "deliveryLongitude", "deliveryDistance",
  "clientNotes", "chatId", currency, "currencySymbol",
  "createdAt", "confirmedAt", "readyAt", "pickedUpAt", "deliveredAt", "cancelledAt", "cancelledBy", "cancellationReason")
VALUES
-- ── COMPLETED orders (status=5) ─────
-- Order 1: Riad Taza → Fouad (client 1), delivered by Fouad Driver (user 2)
(1, 'SO-20260201-001', 1, 1, 2, 5,
  '[{"name":"Tajine Poulet Citron","qty":1,"price":55},{"name":"Salade Marocaine","qty":1,"price":20},{"name":"Thé à la Menthe","qty":2,"price":10}]',
  95.00, 15.00, 110.00, 5.50, 12.75,
  'Hay Al Amal, Rue 12, Taza', 34.2150, -4.0080, 2.3,
  'Merci de sonner à la porte s''il vous plaît', 1, 'MAD', 'DH',
  NOW() - INTERVAL '14 days', NOW() - INTERVAL '14 days' + INTERVAL '5 minutes',
  NOW() - INTERVAL '14 days' + INTERVAL '25 minutes', NOW() - INTERVAL '14 days' + INTERVAL '30 minutes',
  NOW() - INTERVAL '14 days' + INTERVAL '45 minutes', NULL, NULL, NULL),

-- Order 2: Riad Taza → Sarah (user 7), delivered by Mohamed (user 9)
(2, 'SO-20260202-001', 1, 7, 9, 5,
  '[{"name":"Couscous Royal","qty":1,"price":80},{"name":"Jus d Orange Pressé","qty":2,"price":15}]',
  110.00, 18.00, 128.00, 6.40, 15.30,
  'Hay Riad, Rue 5, Taza', 34.2070, -4.0150, 3.1,
  NULL, 2, 'MAD', 'DH',
  NOW() - INTERVAL '12 days', NOW() - INTERVAL '12 days' + INTERVAL '3 minutes',
  NOW() - INTERVAL '12 days' + INTERVAL '30 minutes', NOW() - INTERVAL '12 days' + INTERVAL '35 minutes',
  NOW() - INTERVAL '12 days' + INTERVAL '50 minutes', NULL, NULL, NULL),

-- Order 3: Pâtisserie → Youssef (user 8), delivered by Fatima (user 10)
(3, 'SO-20260203-001', 2, 8, 10, 5,
  '[{"name":"Cornes de Gazelle","qty":1,"price":60},{"name":"Croissant au Beurre","qty":3,"price":8},{"name":"Cappuccino","qty":2,"price":18}]',
  120.00, 12.00, 132.00, 6.60, 10.20,
  'Taza Haute, Derb Lakhdar', 34.2120, -4.0200, 1.8,
  'Attention fragile', 3, 'MAD', 'DH',
  NOW() - INTERVAL '11 days', NOW() - INTERVAL '11 days' + INTERVAL '4 minutes',
  NOW() - INTERVAL '11 days' + INTERVAL '15 minutes', NOW() - INTERVAL '11 days' + INTERVAL '18 minutes',
  NOW() - INTERVAL '11 days' + INTERVAL '30 minutes', NULL, NULL, NULL),

-- Order 4: Snack El Baraka → client a (user 6), delivered by Karim (user 19)
(4, 'SO-20260204-001', 3, 6, 19, 5,
  '[{"name":"Chawarma Mixte","qty":2,"price":35},{"name":"Pizza Viande Hachée","qty":1,"price":50},{"name":"Coca-Cola 33cl","qty":2,"price":8}]',
  136.00, 10.00, 146.00, 7.30, 8.50,
  'Quartier Bab Zitoun, Taza', 34.2180, -4.0050, 1.5,
  NULL, 4, 'MAD', 'DH',
  NOW() - INTERVAL '10 days', NOW() - INTERVAL '10 days' + INTERVAL '2 minutes',
  NOW() - INTERVAL '10 days' + INTERVAL '18 minutes', NOW() - INTERVAL '10 days' + INTERVAL '20 minutes',
  NOW() - INTERVAL '10 days' + INTERVAL '32 minutes', NULL, NULL, NULL),

-- Order 5: Snack → Sarah (user 7), by Karim/profile 5
(5, 'SO-20260205-001', 3, 7, 19, 5,
  '[{"name":"Burger Classic","qty":2,"price":35},{"name":"Tacos Classique","qty":1,"price":30},{"name":"Jus Raibi","qty":3,"price":6}]',
  118.00, 12.00, 130.00, 6.50, 10.20,
  'Hay Riad, Rue 5, Taza', 34.2070, -4.0150, 2.5,
  'Sans oignons dans les burgers SVP', 5, 'MAD', 'DH',
  NOW() - INTERVAL '9 days', NOW() - INTERVAL '9 days' + INTERVAL '3 minutes',
  NOW() - INTERVAL '9 days' + INTERVAL '20 minutes', NOW() - INTERVAL '9 days' + INTERVAL '22 minutes',
  NOW() - INTERVAL '9 days' + INTERVAL '35 minutes', NULL, NULL, NULL),

-- Order 6: Marché Frais → Fouad (user 1), by Mohamed (user 9)
(6, 'SO-20260206-001', 4, 1, 9, 5,
  '[{"name":"Tomates (1kg)","qty":2,"price":8},{"name":"Poulet Entier","qty":1,"price":45},{"name":"Huile d Olive (1L)","qty":1,"price":60},{"name":"Lait Centrale (1L)","qty":4,"price":7}]',
  149.00, 15.00, 164.00, 8.20, 12.75,
  'Hay Al Amal, Rue 12, Taza', 34.2150, -4.0080, 3.5,
  'Bien choisir les tomates mûres SVP', 6, 'MAD', 'DH',
  NOW() - INTERVAL '8 days', NOW() - INTERVAL '8 days' + INTERVAL '4 minutes',
  NOW() - INTERVAL '8 days' + INTERVAL '12 minutes', NOW() - INTERVAL '8 days' + INTERVAL '15 minutes',
  NOW() - INTERVAL '8 days' + INTERVAL '30 minutes', NULL, NULL, NULL),

-- Order 7: Pâtisserie → Youssef (user 8), by Fatima (user 10)
(7, 'SO-20260207-001', 2, 8, 10, 5,
  '[{"name":"Gâteau au Chocolat","qty":1,"price":35},{"name":"Cheesecake","qty":1,"price":38},{"name":"Café Espresso","qty":1,"price":12}]',
  85.00, 10.00, 95.00, 4.75, 8.50,
  'Taza Haute, Derb Lakhdar', 34.2120, -4.0200, 1.8,
  NULL, 7, 'MAD', 'DH',
  NOW() - INTERVAL '7 days', NOW() - INTERVAL '7 days' + INTERVAL '3 minutes',
  NOW() - INTERVAL '7 days' + INTERVAL '15 minutes', NOW() - INTERVAL '7 days' + INTERVAL '18 minutes',
  NOW() - INTERVAL '7 days' + INTERVAL '28 minutes', NULL, NULL, NULL),

-- Order 8: Pharmacie → Sarah (user 7), by Mohamed (user 9)
(8, 'SO-20260208-001', 5, 7, 9, 5,
  '[{"name":"Doliprane 1000mg","qty":2,"price":15},{"name":"Vitamine C 1000mg","qty":1,"price":35}]',
  65.00, 10.00, 75.00, 3.75, 8.50,
  'Hay Riad, Rue 5, Taza', 34.2070, -4.0150, 2.0,
  'Urgent SVP', 8, 'MAD', 'DH',
  NOW() - INTERVAL '6 days', NOW() - INTERVAL '6 days' + INTERVAL '2 minutes',
  NOW() - INTERVAL '6 days' + INTERVAL '8 minutes', NOW() - INTERVAL '6 days' + INTERVAL '10 minutes',
  NOW() - INTERVAL '6 days' + INTERVAL '20 minutes', NULL, NULL, NULL),

-- Order 9: Riad Taza → client a (user 6), by Omar (user 11)
(9, 'SO-20260209-001', 1, 6, 11, 5,
  '[{"name":"Tajine Agneau Pruneaux","qty":1,"price":75},{"name":"Harira","qty":2,"price":18},{"name":"Eau Minérale","qty":2,"price":8}]',
  127.00, 15.00, 142.00, 7.10, 12.75,
  'Quartier Bab Zitoun, Taza', 34.2180, -4.0050, 2.8,
  NULL, 9, 'MAD', 'DH',
  NOW() - INTERVAL '5 days', NOW() - INTERVAL '5 days' + INTERVAL '5 minutes',
  NOW() - INTERVAL '5 days' + INTERVAL '28 minutes', NOW() - INTERVAL '5 days' + INTERVAL '32 minutes',
  NOW() - INTERVAL '5 days' + INTERVAL '48 minutes', NULL, NULL, NULL),

-- Order 10: Snack → Fouad (user 1), by Karim (user 19)
(10, 'SO-20260210-001', 3, 1, 19, 5,
  '[{"name":"Chawarma Poulet","qty":2,"price":25},{"name":"Burger Double","qty":1,"price":50}]',
  100.00, 10.00, 110.00, 5.50, 8.50,
  'Centre Ville, Avenue Hassan II, Taza', 34.2095, -4.0120, 1.2,
  NULL, 10, 'MAD', 'DH',
  NOW() - INTERVAL '4 days', NOW() - INTERVAL '4 days' + INTERVAL '2 minutes',
  NOW() - INTERVAL '4 days' + INTERVAL '15 minutes', NOW() - INTERVAL '4 days' + INTERVAL '17 minutes',
  NOW() - INTERVAL '4 days' + INTERVAL '25 minutes', NULL, NULL, NULL),

-- Order 11: Marché Frais → Youssef (user 8), by Hassan (user 20)
(11, 'SO-20260211-001', 4, 8, 20, 5,
  '[{"name":"Oranges (1kg)","qty":3,"price":10},{"name":"Bananes (1kg)","qty":2,"price":15},{"name":"Yaourt Danone (x6)","qty":2,"price":18},{"name":"Merguez (500g)","qty":1,"price":35}]',
  131.00, 15.00, 146.00, 7.30, 12.75,
  'Taza Haute, Derb Lakhdar', 34.2120, -4.0200, 3.2,
  NULL, 11, 'MAD', 'DH',
  NOW() - INTERVAL '3 days', NOW() - INTERVAL '3 days' + INTERVAL '3 minutes',
  NOW() - INTERVAL '3 days' + INTERVAL '10 minutes', NOW() - INTERVAL '3 days' + INTERVAL '13 minutes',
  NOW() - INTERVAL '3 days' + INTERVAL '28 minutes', NULL, NULL, NULL),

-- Order 12: Fleuriste → Sarah (user 7), by Fatima (user 10)
(12, 'SO-20260212-001', 7, 7, 10, 5,
  '[{"name":"Bouquet Romantique","qty":1,"price":120},{"name":"Boîte Chocolats + Fleurs","qty":1,"price":200}]',
  320.00, 15.00, 335.00, 16.75, 12.75,
  'Hay Riad, Rue 5, Taza', 34.2070, -4.0150, 2.4,
  'C''est pour un anniversaire, merci d''emballer joliment', 12, 'MAD', 'DH',
  NOW() - INTERVAL '2 days', NOW() - INTERVAL '2 days' + INTERVAL '5 minutes',
  NOW() - INTERVAL '2 days' + INTERVAL '20 minutes', NOW() - INTERVAL '2 days' + INTERVAL '25 minutes',
  NOW() - INTERVAL '2 days' + INTERVAL '40 minutes', NULL, NULL, NULL),

-- Order 13: Pâtisserie → Fouad (user 1), by Mohamed (user 9)
(13, 'SO-20260213-001', 2, 1, 9, 5,
  '[{"name":"Chebakia","qty":2,"price":45},{"name":"Msemen","qty":5,"price":5},{"name":"Thé à la Menthe","qty":2,"price":10}]',
  135.00, 12.00, 147.00, 7.35, 10.20,
  'Hay Al Amal, Rue 12, Taza', 34.2150, -4.0080, 2.0,
  NULL, 13, 'MAD', 'DH',
  NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day' + INTERVAL '3 minutes',
  NOW() - INTERVAL '1 day' + INTERVAL '12 minutes', NOW() - INTERVAL '1 day' + INTERVAL '15 minutes',
  NOW() - INTERVAL '1 day' + INTERVAL '25 minutes', NULL, NULL, NULL),

-- Order 14: Tech Center → client a (user 6), by Omar (user 11)
(14, 'SO-20260214-001', 6, 6, 11, 5,
  '[{"name":"Coque Silicone Universelle","qty":1,"price":30},{"name":"Chargeur USB-C Rapide","qty":1,"price":60},{"name":"Protection Écran Verre","qty":2,"price":25}]',
  140.00, 10.00, 150.00, 7.50, 8.50,
  'Quartier Bab Zitoun, Taza', 34.2180, -4.0050, 1.5,
  NULL, 14, 'MAD', 'DH',
  NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day' + INTERVAL '4 minutes',
  NOW() - INTERVAL '1 day' + INTERVAL '8 minutes', NOW() - INTERVAL '1 day' + INTERVAL '12 minutes',
  NOW() - INTERVAL '1 day' + INTERVAL '22 minutes', NULL, NULL, NULL),

-- Order 15: Riad Taza → Youssef (user 8), by Fouad driver (user 2)
(15, 'SO-20260215-001', 1, 8, 2, 5,
  '[{"name":"Brochettes Mixtes","qty":2,"price":60},{"name":"Tajine Légumes","qty":1,"price":40},{"name":"Jus d Orange Pressé","qty":2,"price":15}]',
  190.00, 18.00, 208.00, 10.40, 15.30,
  'Taza Haute, Derb Lakhdar', 34.2120, -4.0200, 3.0,
  NULL, 15, 'MAD', 'DH',
  NOW() - INTERVAL '12 hours', NOW() - INTERVAL '12 hours' + INTERVAL '3 minutes',
  NOW() - INTERVAL '12 hours' + INTERVAL '22 minutes', NOW() - INTERVAL '12 hours' + INTERVAL '25 minutes',
  NOW() - INTERVAL '12 hours' + INTERVAL '40 minutes', NULL, NULL, NULL),

-- ── IN-PROGRESS orders ─────
-- Order 16: Snack → Sarah (user 7), NO driver yet (status=1 confirmed)
(16, 'SO-20260216-001', 3, 7, NULL, 1,
  '[{"name":"Pizza 4 Fromages","qty":1,"price":55},{"name":"Burger Poulet Crispy","qty":1,"price":40},{"name":"Coca-Cola 33cl","qty":2,"price":8}]',
  111.00, 12.00, 123.00, 6.15, 10.20,
  'Hay Riad, Rue 5, Taza', 34.2070, -4.0150, 2.1,
  NULL, 16, 'MAD', 'DH',
  NOW() - INTERVAL '25 minutes', NOW() - INTERVAL '22 minutes',
  NULL, NULL, NULL, NULL, NULL, NULL),

-- Order 17: Pharmacie → Fouad (user 1), Karim delivering (status=4 picked_up)
(17, 'SO-20260217-001', 5, 1, 19, 4,
  '[{"name":"Couches Pampers Taille 3","qty":1,"price":85},{"name":"Lait Infantile 1er Âge","qty":1,"price":110},{"name":"Dentifrice Signal","qty":2,"price":15}]',
  225.00, 15.00, 240.00, 12.00, 12.75,
  'Hay Al Amal, Rue 12, Taza', 34.2150, -4.0080, 2.5,
  'Merci, c''est urgent pour bébé', 17, 'MAD', 'DH',
  NOW() - INTERVAL '30 minutes', NOW() - INTERVAL '28 minutes',
  NOW() - INTERVAL '20 minutes', NOW() - INTERVAL '15 minutes',
  NULL, NULL, NULL, NULL),

-- Order 18: Riad Taza → Youssef (user 8), Mohamed preparing (status=2)
(18, 'SO-20260218-001', 1, 8, 9, 2,
  '[{"name":"Couscous Tfaya","qty":1,"price":65},{"name":"Côtelettes d Agneau","qty":1,"price":70},{"name":"Salade Marocaine","qty":1,"price":20}]',
  155.00, 18.00, 173.00, 8.65, 15.30,
  'Taza Haute, Derb Lakhdar', 34.2120, -4.0200, 3.0,
  NULL, 18, 'MAD', 'DH',
  NOW() - INTERVAL '15 minutes', NOW() - INTERVAL '12 minutes',
  NULL, NULL, NULL, NULL, NULL, NULL),

-- Order 19: Pâtisserie → client a (user 6), just placed (status=0 pending)
(19, 'SO-20260219-001', 2, 6, NULL, 0,
  '[{"name":"Tarte aux Fruits","qty":1,"price":40},{"name":"Baghrir","qty":4,"price":5},{"name":"Cappuccino","qty":1,"price":18}]',
  78.00, 10.00, 88.00, 4.40, 8.50,
  'Quartier Bab Zitoun, Taza', 34.2180, -4.0050, 1.8,
  NULL, 19, 'MAD', 'DH',
  NOW() - INTERVAL '5 minutes', NULL, NULL, NULL, NULL, NULL, NULL, NULL),

-- ── CANCELLED order ─────
-- Order 20: Marché Frais → Sarah (user 7), cancelled by client
(20, 'SO-20260220-001', 4, 7, 20, 6,
  '[{"name":"Viande Hachée (500g)","qty":2,"price":40},{"name":"Riz Basmati (1kg)","qty":1,"price":18}]',
  98.00, 12.00, 110.00, 0, 0,
  'Hay Riad, Rue 5, Taza', 34.2070, -4.0150, 3.5,
  NULL, 20, 'MAD', 'DH',
  NOW() - INTERVAL '2 days', NOW() - INTERVAL '2 days' + INTERVAL '2 minutes',
  NULL, NULL, NULL,
  NOW() - INTERVAL '2 days' + INTERVAL '10 minutes', 'client', 'J''ai changé d''avis, désolé');

SELECT setval('store_orders_id_seq', 20);

-- ── Store Order Items ──────────────────────────────
-- Denormalized items for each completed order
INSERT INTO store_order_items ("storeOrderId", "productId", "productName", "productPrice", quantity, "itemTotal", notes)
VALUES
-- Order 1
(1, 1,  'Tajine Poulet Citron', 55.00, 1, 55.00, NULL),
(1, 7,  'Salade Marocaine',     20.00, 1, 20.00, NULL),
(1, 12, 'Thé à la Menthe',      10.00, 2, 20.00, NULL),
-- Order 2
(2, 5,  'Couscous Royal',        80.00, 1, 80.00, NULL),
(2, 13, 'Jus d''Orange Pressé',  15.00, 2, 30.00, NULL),
-- Order 3
(3, 15, 'Cornes de Gazelle',     60.00, 1, 60.00, NULL),
(3, 19, 'Croissant au Beurre',   8.00,  3, 24.00, NULL),
(3, 26, 'Cappuccino',            18.00, 2, 36.00, NULL),
-- Order 4
(4, 32, 'Chawarma Mixte',        35.00, 2, 70.00, NULL),
(4, 34, 'Pizza Viande Hachée',   50.00, 1, 50.00, NULL),
(4, 41, 'Coca-Cola 33cl',        8.00,  2, 16.00, NULL),
-- Order 5
(5, 36, 'Burger Classic',        35.00, 2, 70.00, NULL),
(5, 39, 'Tacos Classique',       30.00, 1, 30.00, NULL),
(5, 42, 'Jus Raibi',             6.00,  3, 18.00, NULL),
-- Order 6
(6, 44, 'Tomates (1kg)',         8.00,  2, 16.00, 'Bien mûres'),
(6, 56, 'Poulet Entier',         45.00, 1, 45.00, NULL),
(6, 49, 'Huile d''Olive (1L)',   60.00, 1, 60.00, NULL),
(6, 53, 'Lait Centrale (1L)',    7.00,  4, 28.00, NULL);

-- ── Store Delivery Requests ────────────────────────
-- For completed orders, create matching delivery requests
INSERT INTO store_delivery_requests ("storeOrderId", "storeId", "requestType", "targetDriverId",
  "pickupAddress", "pickupLatitude", "pickupLongitude",
  "deliveryAddress", "deliveryLatitude", "deliveryLongitude",
  "distanceKm", "deliveryFee", "driverEarnings", status, "assignedDriverId",
  "createdAt", "acceptedAt")
VALUES
(1,  1, 'broadcast', NULL, 'Rue de la Kasbah, Taza Haute', 34.2130, -4.0180, 'Hay Al Amal, Rue 12, Taza', 34.2150, -4.0080, 2.3, 15.00, 12.75, 'delivered', 2, NOW() - INTERVAL '14 days', NOW() - INTERVAL '14 days' + INTERVAL '3 minutes'),
(2,  1, 'broadcast', NULL, 'Rue de la Kasbah, Taza Haute', 34.2130, -4.0180, 'Hay Riad, Rue 5, Taza', 34.2070, -4.0150, 3.1, 18.00, 15.30, 'delivered', 9, NOW() - INTERVAL '12 days', NOW() - INTERVAL '12 days' + INTERVAL '2 minutes'),
(4,  3, 'broadcast', NULL, 'Place de l''Indépendance, Taza', 34.2110, -4.0090, 'Quartier Bab Zitoun, Taza', 34.2180, -4.0050, 1.5, 10.00, 8.50, 'delivered', 19, NOW() - INTERVAL '10 days', NOW() - INTERVAL '10 days' + INTERVAL '1 minute'),
(17, 5, 'broadcast', NULL, 'Avenue Hassan II, Centre Ville, Taza', 34.2098, -4.0110, 'Hay Al Amal, Rue 12, Taza', 34.2150, -4.0080, 2.5, 15.00, 12.75, 'picked_up', 19, NOW() - INTERVAL '30 minutes', NOW() - INTERVAL '25 minutes');

-- ══════════════════════════════════════════════════════
-- PART B: SERVICE ORDERS (rides, deliveries, errands)
-- ══════════════════════════════════════════════════════
-- orders.status: 0=pending, 1=accepted, 2=in_progress, 3=completed, 4=cancelled

INSERT INTO orders (id, "clientId", "driverId", "serviceId",
  "pickupLatitude", "pickupLongitude", "pickupAddress",
  "dropoffLatitude", "dropoffLongitude", "dropoffAddress",
  "estimatedDistanceKm", "estimatedPrice", "agreedPrice", "finalPrice",
  notes, status, currency, "currencySymbol",
  "createdAt", "acceptedAt", "startedAt", "completedAt", "cancelledAt", "cancellationReason")
VALUES
-- Completed city rides
(1, 1, 1, 1, -- client 1 (user_client), driver profile 1 (Fouad), City Ride
  34.2150, -4.0080, 'Hay Al Amal, Taza',
  34.2095, -4.0120, 'Centre Ville, Avenue Hassan II, Taza',
  2.5, 35.00, 30.00, 30.00,
  'Course rapide au centre ville', 3, 'MAD', 'DH',
  NOW() - INTERVAL '13 days', NOW() - INTERVAL '13 days' + INTERVAL '2 minutes',
  NOW() - INTERVAL '13 days' + INTERVAL '8 minutes', NOW() - INTERVAL '13 days' + INTERVAL '20 minutes',
  NULL, NULL),

-- Intercity trip Taza → Fès
(2, 3, 2, 4, -- client 3 (Sarah/user 7), driver 2 (Mohamed), Intercity
  34.2100, -4.0100, 'Centre Ville, Taza',
  34.0181, -5.0078, 'Gare Routière, Fès',
  120.0, 280.00, 250.00, 250.00,
  'Voyage Taza-Fès, 2 valises', 3, 'MAD', 'DH',
  NOW() - INTERVAL '10 days', NOW() - INTERVAL '10 days' + INTERVAL '5 minutes',
  NOW() - INTERVAL '10 days' + INTERVAL '15 minutes', NOW() - INTERVAL '10 days' + INTERVAL '2 hours',
  NULL, NULL),

-- Package delivery
(3, 4, 3, 5, -- client 4 (Youssef/user 8), driver 3 (Fatima), Package Delivery
  34.2120, -4.0200, 'Taza Haute, Derb Lakhdar',
  34.2110, -4.0090, 'Place de l''Indépendance, Taza',
  1.8, 20.00, 18.00, 18.00,
  'Petit colis, documents administratifs', 3, 'MAD', 'DH',
  NOW() - INTERVAL '9 days', NOW() - INTERVAL '9 days' + INTERVAL '1 minute',
  NOW() - INTERVAL '9 days' + INTERVAL '5 minutes', NOW() - INTERVAL '9 days' + INTERVAL '18 minutes',
  NULL, NULL),

-- Furniture moving
(4, 4, 4, 13, -- Youssef, Omar, Furniture Moving
  34.2120, -4.0200, 'Taza Haute, ancien appartement',
  34.2060, -4.0160, 'Hay Al Massira, nouvel appartement',
  3.5, 300.00, 280.00, 280.00,
  'Salon complet + frigo + machine à laver', 3, 'MAD', 'DH',
  NOW() - INTERVAL '8 days', NOW() - INTERVAL '8 days' + INTERVAL '10 minutes',
  NOW() - INTERVAL '8 days' + INTERVAL '30 minutes', NOW() - INTERVAL '8 days' + INTERVAL '3 hours',
  NULL, NULL),

-- Grocery shopping errand
(5, 1, 5, 9, -- Fouad (client), Karim, Grocery Shopping
  34.2100, -4.0100, 'Souk de Taza, Centre',
  34.2150, -4.0080, 'Hay Al Amal, Rue 12',
  2.0, 35.00, 30.00, 30.00,
  'Liste de courses: tomates, oignons, herbes fraîches', 3, 'MAD', 'DH',
  NOW() - INTERVAL '6 days', NOW() - INTERVAL '6 days' + INTERVAL '3 minutes',
  NOW() - INTERVAL '6 days' + INTERVAL '10 minutes', NOW() - INTERVAL '6 days' + INTERVAL '45 minutes',
  NULL, NULL),

-- Airport transfer
(6, 3, 6, 2, -- Sarah, Hassan, Airport Transfer
  34.2070, -4.0150, 'Hay Riad, Taza',
  33.9272, -4.9778, 'Aéroport Fès-Saïss',
  115.0, 280.00, 260.00, 260.00,
  'Vol à 14h, départ à 10h SVP', 3, 'MAD', 'DH',
  NOW() - INTERVAL '5 days', NOW() - INTERVAL '5 days' + INTERVAL '5 minutes',
  NOW() - INTERVAL '5 days' + INTERVAL '10 minutes', NOW() - INTERVAL '5 days' + INTERVAL '2 hours 15 minutes',
  NULL, NULL),

-- Restaurant delivery
(7, 2, 3, 17, -- client a (user 6), Fatima, Restaurant Delivery
  34.2130, -4.0180, 'Riad Taza, Rue de la Kasbah',
  34.2180, -4.0050, 'Quartier Bab Zitoun',
  2.2, 18.00, 15.00, 15.00,
  NULL, 3, 'MAD', 'DH',
  NOW() - INTERVAL '4 days', NOW() - INTERVAL '4 days' + INTERVAL '2 minutes',
  NOW() - INTERVAL '4 days' + INTERVAL '5 minutes', NOW() - INTERVAL '4 days' + INTERVAL '25 minutes',
  NULL, NULL),

-- Pharmacy run
(8, 1, 3, 10, -- Fouad, Fatima, Pharmacy Run
  34.2098, -4.0110, 'Pharmacie Centrale, Avenue Hassan II',
  34.2150, -4.0080, 'Hay Al Amal, Rue 12',
  1.5, 22.00, 20.00, 20.00,
  'Ordonnance en photo dans le chat', 3, 'MAD', 'DH',
  NOW() - INTERVAL '3 days', NOW() - INTERVAL '3 days' + INTERVAL '1 minute',
  NOW() - INTERVAL '3 days' + INTERVAL '5 minutes', NOW() - INTERVAL '3 days' + INTERVAL '22 minutes',
  NULL, NULL),

-- In-progress ride
(9, 3, 1, 1, -- Sarah, Fouad driver, City Ride
  34.2070, -4.0150, 'Hay Riad, Taza',
  34.2100, -4.0100, 'Centre Ville, Taza',
  2.0, 30.00, 25.00, NULL,
  NULL, 2, 'MAD', 'DH',
  NOW() - INTERVAL '10 minutes', NOW() - INTERVAL '8 minutes',
  NOW() - INTERVAL '5 minutes', NULL, NULL, NULL),

-- Pending delivery
(10, 4, NULL, 5, -- Youssef, no driver yet, Package Delivery
  34.2120, -4.0200, 'Taza Haute',
  34.2085, -4.0135, 'Rue Ibn Khaldoun, Taza',
  1.2, 18.00, NULL, NULL,
  'Petite boîte de livres', 0, 'MAD', 'DH',
  NOW() - INTERVAL '3 minutes', NULL, NULL, NULL, NULL, NULL),

-- Cancelled ride
(11, 2, 2, 4, -- client a, Mohamed, Intercity
  34.2100, -4.0100, 'Taza Centre',
  34.6814, -1.9086, 'Oujda',
  200.0, 400.00, 380.00, NULL,
  'Voyage Taza-Oujda', 4, 'MAD', 'DH',
  NOW() - INTERVAL '7 days', NOW() - INTERVAL '7 days' + INTERVAL '5 minutes',
  NULL, NULL,
  NOW() - INTERVAL '7 days' + INTERVAL '30 minutes', 'Client a annulé - imprévu familial'),

-- Another completed ride
(12, 1, 2, 1, -- Fouad client, Mohamed, City Ride
  34.2150, -4.0080, 'Hay Al Amal, Taza',
  34.2140, -4.0060, 'Boulevard Mohammed VI',
  1.8, 28.00, 25.00, 25.00,
  NULL, 3, 'MAD', 'DH',
  NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day' + INTERVAL '3 minutes',
  NOW() - INTERVAL '1 day' + INTERVAL '8 minutes', NOW() - INTERVAL '1 day' + INTERVAL '18 minutes',
  NULL, NULL);

SELECT setval('orders_id_seq', 12);

-- ── Order Status History ───────────────────────────
-- For completed orders, track status transitions
INSERT INTO order_status_history ("orderId", "fromStatus", "toStatus", "changedByUserId", notes)
VALUES
-- Order 1 (City Ride)
(1, NULL, 0, 1,  'Commande créée'),
(1, 0,    1, 2,  'Acceptée par le chauffeur'),
(1, 1,    2, 2,  'Course démarrée'),
(1, 2,    3, 2,  'Course terminée'),
-- Order 2 (Intercity)
(2, NULL, 0, 7,  'Commande créée'),
(2, 0,    1, 9,  'Acceptée'),
(2, 1,    2, 9,  'Départ'),
(2, 2,    3, 9,  'Arrivée à Fès');

-- ── Transactions ───────────────────────────────────
-- Payment records for completed orders
INSERT INTO transactions ("userId", "requestId", amount, type, status, "paymentMethod", description,
  "platformCommission", "driverEarnings", "driverConfirmed", "clientConfirmed",
  currency, "currencySymbol")
VALUES
-- Store order transactions (for first 15 completed store orders)
(1,  NULL, 110.00, 'store_order', 'completed', 'cash', 'Commande #SO-20260201-001 - Riad Taza', 5.50, 12.75, true, true, 'MAD', 'DH'),
(7,  NULL, 128.00, 'store_order', 'completed', 'cash', 'Commande #SO-20260202-001 - Riad Taza', 6.40, 15.30, true, true, 'MAD', 'DH'),
(8,  NULL, 132.00, 'store_order', 'completed', 'cash', 'Commande #SO-20260203-001 - Pâtisserie Le Palais', 6.60, 10.20, true, true, 'MAD', 'DH'),
(6,  NULL, 146.00, 'store_order', 'completed', 'cash', 'Commande #SO-20260204-001 - Snack El Baraka', 7.30, 8.50, true, true, 'MAD', 'DH'),
(7,  NULL, 130.00, 'store_order', 'completed', 'cash', 'Commande #SO-20260205-001 - Snack El Baraka', 6.50, 10.20, true, true, 'MAD', 'DH'),
(1,  NULL, 164.00, 'store_order', 'completed', 'cash', 'Commande #SO-20260206-001 - Marché Frais', 8.20, 12.75, true, true, 'MAD', 'DH'),
(8,  NULL, 95.00,  'store_order', 'completed', 'cash', 'Commande #SO-20260207-001 - Pâtisserie Le Palais', 4.75, 8.50, true, true, 'MAD', 'DH'),
(7,  NULL, 75.00,  'store_order', 'completed', 'cash', 'Commande #SO-20260208-001 - Pharmacie Centrale', 3.75, 8.50, true, true, 'MAD', 'DH'),
(6,  NULL, 142.00, 'store_order', 'completed', 'cash', 'Commande #SO-20260209-001 - Riad Taza', 7.10, 12.75, true, true, 'MAD', 'DH'),
(1,  NULL, 110.00, 'store_order', 'completed', 'cash', 'Commande #SO-20260210-001 - Snack El Baraka', 5.50, 8.50, true, true, 'MAD', 'DH'),
(8,  NULL, 146.00, 'store_order', 'completed', 'cash', 'Commande #SO-20260211-001 - Marché Frais', 7.30, 12.75, true, true, 'MAD', 'DH'),
(7,  NULL, 335.00, 'store_order', 'completed', 'cash', 'Commande #SO-20260212-001 - Fleuriste Yasmine', 16.75, 12.75, true, true, 'MAD', 'DH'),
(1,  NULL, 147.00, 'store_order', 'completed', 'cash', 'Commande #SO-20260213-001 - Pâtisserie Le Palais', 7.35, 10.20, true, true, 'MAD', 'DH'),
(6,  NULL, 150.00, 'store_order', 'completed', 'cash', 'Commande #SO-20260214-001 - Tech Center', 7.50, 8.50, true, true, 'MAD', 'DH'),
(8,  NULL, 208.00, 'store_order', 'completed', 'cash', 'Commande #SO-20260215-001 - Riad Taza', 10.40, 15.30, true, true, 'MAD', 'DH'),

-- Service order transactions (for completed service orders 1-8, 12)
(1,  NULL, 30.00,  'service_order', 'completed', 'cash', 'Course en ville - Taza centre', 1.50, 28.50, true, true, 'MAD', 'DH'),
(7,  NULL, 250.00, 'service_order', 'completed', 'cash', 'Voyage Taza → Fès', 12.50, 237.50, true, true, 'MAD', 'DH'),
(8,  NULL, 18.00,  'service_order', 'completed', 'cash', 'Livraison colis Taza', 0.90, 17.10, true, true, 'MAD', 'DH'),
(8,  NULL, 280.00, 'service_order', 'completed', 'cash', 'Déménagement meubles', 14.00, 266.00, true, true, 'MAD', 'DH'),
(1,  NULL, 30.00,  'service_order', 'completed', 'cash', 'Courses au souk', 1.50, 28.50, true, true, 'MAD', 'DH'),
(7,  NULL, 260.00, 'service_order', 'completed', 'cash', 'Transfert Aéroport Fès', 13.00, 247.00, true, true, 'MAD', 'DH'),
(6,  NULL, 15.00,  'service_order', 'completed', 'cash', 'Livraison restaurant', 0.75, 14.25, true, true, 'MAD', 'DH'),
(1,  NULL, 20.00,  'service_order', 'completed', 'cash', 'Course pharmacie', 1.00, 19.00, true, true, 'MAD', 'DH'),
(1,  NULL, 25.00,  'service_order', 'completed', 'cash', 'Course en ville', 1.25, 23.75, true, true, 'MAD', 'DH');

-- ── Chat Messages (sample for recent orders) ──────
INSERT INTO store_order_chat_messages ("chatId", "senderId", "senderRole", "senderName", "messageType", content)
VALUES
-- Order 17 chat (in progress - pharmacy delivery)
(17, 1,  'client', 'Fouad Abatouy',    'text', 'Bonjour, c''est urgent pour le bébé SVP'),
(17, 15, 'store',  'Pharmacie Centrale','text', 'Bonjour! Commande prête, on attend le livreur'),
(17, 19, 'driver', 'Karim Ait Brahim', 'text', 'J''arrive dans 5 minutes à la pharmacie'),
(17, 19, 'driver', 'Karim Ait Brahim', 'text', 'C''est récupéré, en route vers vous!'),

-- Order 18 chat (preparing)
(18, 8,  'client', 'Youssef Hassan',   'text', 'Le couscous est pour combien de personnes?'),
(18, 5,  'store',  'Riad Taza',        'text', 'Portion généreuse pour 2-3 personnes. En préparation!'),

-- Order 16 chat (confirmed, no driver)
(16, 7,  'client', 'Sarah Ahmed',      'text', 'Quand est-ce que la commande sera prête?'),
(16, 13, 'store',  'Snack El Baraka',  'text', 'Environ 15 minutes, on cherche un livreur');

COMMIT;

-- Verify
SELECT 'store_orders' as tbl, count(*) as cnt FROM store_orders
UNION ALL SELECT 'store_order_items', count(*) FROM store_order_items
UNION ALL SELECT 'orders (service)', count(*) FROM orders
UNION ALL SELECT 'transactions', count(*) FROM transactions
UNION ALL SELECT 'order_status_history', count(*) FROM order_status_history
UNION ALL SELECT 'delivery_requests', count(*) FROM store_delivery_requests
ORDER BY tbl;
