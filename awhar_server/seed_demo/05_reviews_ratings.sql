-- =====================================================
-- SCRIPT 5: REVIEWS & RATINGS
-- Store reviews + service ratings for completed orders
-- =====================================================

BEGIN;

-- ══════════════════════════════════════════════════════
-- STORE REVIEWS
-- ══════════════════════════════════════════════════════
-- revieweeType: 'store' or 'driver'
-- rating: 1-5

INSERT INTO store_reviews ("storeOrderId", "reviewerId", "revieweeType", "revieweeId", rating, comment, response, "responseAt")
VALUES
-- Reviews for Store: Riad Taza (store 1)
(1,  1, 'store', 1, 5, 'Meilleur tajine de Taza! Le poulet au citron était parfait.', 'Merci beaucoup Fouad! À bientôt inchallah.', NOW() - INTERVAL '13 days'),
(2,  7, 'store', 1, 5, 'Le couscous royal est incroyable, portions très généreuses.', 'Merci Sarah! On vous attend vendredi prochain.', NOW() - INTERVAL '11 days'),
(9,  6, 'store', 1, 4, 'Tajine agneau excellent, mais la harira était un peu froide à l''arrivée.', 'Désolé pour la harira, on va améliorer l''emballage thermique.', NOW() - INTERVAL '4 days'),
(15, 8, 'store', 1, 5, 'Les brochettes sont les meilleures de la ville! Service rapide.', NULL, NULL),

-- Reviews for Store: Pâtisserie Le Palais (store 2)
(3,  8, 'store', 2, 5, 'Les cornes de gazelle fondent en bouche! Vrai savoir-faire artisanal.', 'Merci! C''est notre spécialité depuis 2015.', NOW() - INTERVAL '10 days'),
(7,  8, 'store', 2, 4, 'Bon gâteau au chocolat, cheesecake un peu trop sucré à mon goût.', NULL, NULL),
(13, 1, 'store', 2, 5, 'Chebakia et msemen excellents! Comme chez maman.', 'Haha merci Fouad, c''est le plus beau compliment!', NOW() - INTERVAL '20 hours'),

-- Reviews for Store: Snack El Baraka (store 3)
(4,  6, 'store', 3, 5, 'La meilleure chawarma de Taza, sans hésiter! Sauce parfaite.', 'Merci! On utilise des épices spéciales importées.', NOW() - INTERVAL '9 days'),
(5,  7, 'store', 3, 4, 'Burgers bons mais j''aurais aimé plus de sauce. Tacos top par contre!', NULL, NULL),
(10, 1, 'store', 3, 4, 'Chawarma poulet excellente, burger double un peu trop gras.', NULL, NULL),

-- Reviews for Store: Marché Frais (store 4)
(6,  1, 'store', 4, 5, 'Produits ultra frais! Les tomates étaient parfaites et le poulet excellent.', 'Merci Fouad! Nos produits viennent directement du souk chaque matin.', NOW() - INTERVAL '7 days'),
(11, 8, 'store', 4, 4, 'Bonne qualité mais les oranges étaient un peu vertes.', 'Désolé, on fera plus attention à la sélection.', NOW() - INTERVAL '2 days'),

-- Reviews for Store: Pharmacie Centrale (store 5)
(8,  7, 'store', 5, 5, 'Livraison hyper rapide! Exactement ce qu''il me fallait pour la grippe.', 'Bon rétablissement Sarah! N''hésitez pas pour vos besoins.', NOW() - INTERVAL '5 days'),

-- Reviews for Store: Tech Center (store 6)
(14, 6, 'store', 6, 4, 'Bon rapport qualité-prix sur les accessoires. Livraison rapide.', NULL, NULL),

-- Reviews for Store: Fleuriste Yasmine (store 7)
(12, 7, 'store', 7, 5, 'Bouquet magnifique! Mon mari a adoré. L''emballage était superbe aussi.', 'Merci Sarah! Ravi que ça ait plu pour l''anniversaire.', NOW() - INTERVAL '1 day'),

-- ── Driver reviews for store deliveries ──
(1,  1, 'driver', 2,  5, 'Fouad est ponctuel et très poli. Livraison parfaite.', NULL, NULL),
(2,  7, 'driver', 9,  5, 'Mohamed est le meilleur livreur de Taza! Toujours souriant.', NULL, NULL),
(3,  8, 'driver', 10, 5, 'Fatima livre super vite en moto, même dans les ruelles étroites.', NULL, NULL),
(4,  6, 'driver', 19, 4, 'Karim est rapide mais a un peu secoué la pizza.', NULL, NULL),
(5,  7, 'driver', 19, 5, 'Livraison express, commande encore chaude. Top!', NULL, NULL),
(6,  1, 'driver', 9,  5, 'Mohamed connaît tous les raccourcis, livraison en 15min.', NULL, NULL),
(8,  7, 'driver', 9,  5, 'Livraison médicaments en urgence, Mohamed est un héros!', NULL, NULL),
(9,  6, 'driver', 11, 4, 'Omar a bien livré mais un peu en retard.', NULL, NULL),
(12, 7, 'driver', 10, 5, 'Fatima a pris soin du bouquet, pas une pétale abîmée!', NULL, NULL),
(15, 8, 'driver', 2,  5, 'Service impeccable, Fouad est très sympathique.', NULL, NULL);

-- ══════════════════════════════════════════════════════
-- SERVICE ORDER RATINGS
-- ══════════════════════════════════════════════════════
-- ratingType: 'client_to_driver' or 'driver_to_client'

INSERT INTO ratings ("requestId", "raterId", "ratedUserId", "ratingValue", "ratingType", "reviewText", "quickTags")
VALUES
-- Order 1: City Ride - Fouad rates driver Fouad (user 2)
(1, 1, 2, 5, 'client_to_driver', 'Très bonne course, conduite prudente et agréable.', '["ponctuel","sympathique","prudent"]'),
(1, 2, 1, 5, 'driver_to_client', 'Client respectueux et ponctuel.', '["respectueux","ponctuel"]'),

-- Order 2: Intercity - Sarah rates Mohamed
(2, 7, 9, 5, 'client_to_driver', 'Voyage Taza-Fès impeccable! Voiture confortable et musique agréable.', '["confortable","ponctuel","propre"]'),
(2, 9, 7, 5, 'driver_to_client', 'Sarah est une cliente agréable, toujours à l''heure.', '["respectueux","ponctuel"]'),

-- Order 3: Package Delivery - Youssef rates Fatima
(3, 8, 10, 5, 'client_to_driver', 'Livraison express en moto, documents arrivés intacts. Top!', '["rapide","soigneux"]'),
(3, 10, 8, 4, 'driver_to_client', 'Bon client, adresse facile à trouver.', '["respectueux"]'),

-- Order 4: Furniture Moving - Youssef rates Omar
(4, 8, 11, 4, 'client_to_driver', 'Bon travail pour le déménagement, quelques rayures mineures sur le frigo.', '["professionnel"]'),
(4, 11, 8, 5, 'driver_to_client', 'Client aidant et organisé.', '["respectueux","aidant"]'),

-- Order 5: Grocery Shopping - Fouad rates Karim
(5, 1, 19, 5, 'client_to_driver', 'Karim a bien choisi les légumes au souk. Excellent service!', '["soigneux","sympathique"]'),
(5, 19, 1, 5, 'driver_to_client', 'Très bon client avec une liste claire.', '["respectueux","clair"]'),

-- Order 6: Airport Transfer - Sarah rates Hassan
(6, 7, 20, 5, 'client_to_driver', 'Véhicule très confortable, Hassan est un vrai professionnel. Recommandé!', '["confortable","professionnel","ponctuel"]'),
(6, 20, 7, 5, 'driver_to_client', 'Cliente parfaite, prête à l''heure.', '["respectueux","ponctuel"]'),

-- Order 7: Restaurant Delivery - client a rates Fatima
(7, 6, 10, 4, 'client_to_driver', 'Bonne livraison, nourriture chaude. Un peu de retard cependant.', '["sympathique"]'),
(7, 10, 6, 4, 'driver_to_client', 'Client correct.', '["respectueux"]'),

-- Order 8: Pharmacy Run - Fouad rates Fatima
(8, 1, 10, 5, 'client_to_driver', 'Fatima a été ultra rapide pour mes médicaments urgents. Merci!', '["rapide","efficace"]'),
(8, 10, 1, 5, 'driver_to_client', 'Fouad est toujours agréable, bon client fidèle.', '["respectueux","fidèle"]'),

-- Order 12: City Ride - Fouad rates Mohamed
(12, 1, 9, 5, 'client_to_driver', 'Mohamed est mon chauffeur préféré à Taza!', '["ponctuel","sympathique","propre"]'),
(12, 9, 1, 5, 'driver_to_client', 'Fouad est un client en or, toujours agréable.', '["respectueux","ponctuel"]');

-- ══════════════════════════════════════════════════════
-- UPDATE AGGREGATE STATS
-- ══════════════════════════════════════════════════════

-- Update user ratings (as drivers)
UPDATE users SET rating = 4.8, "totalRatings" = 8, "averageRating" = 4.8, "totalTrips" = 62 WHERE id = 2;   -- Fouad driver
UPDATE users SET rating = 4.9, "totalRatings" = 12, "averageRating" = 4.9, "totalTrips" = 98 WHERE id = 9;  -- Mohamed
UPDATE users SET rating = 4.7, "totalRatings" = 8, "averageRating" = 4.7, "totalTrips" = 45 WHERE id = 10;  -- Fatima
UPDATE users SET rating = 4.5, "totalRatings" = 5, "averageRating" = 4.5, "totalTrips" = 38 WHERE id = 11;  -- Omar
UPDATE users SET rating = 4.6, "totalRatings" = 4, "averageRating" = 4.6, "totalTrips" = 25 WHERE id = 19;  -- Karim
UPDATE users SET rating = 4.9, "totalRatings" = 6, "averageRating" = 4.9, "totalTrips" = 55 WHERE id = 20;  -- Hassan

-- Update user ratings (as clients)
UPDATE users SET "ratingAsClient" = 4.9, "totalRatingsAsClient" = 5 WHERE id = 1;  -- Fouad client
UPDATE users SET "ratingAsClient" = 4.5, "totalRatingsAsClient" = 2 WHERE id = 6;  -- client a
UPDATE users SET "ratingAsClient" = 4.9, "totalRatingsAsClient" = 4 WHERE id = 7;  -- Sarah
UPDATE users SET "ratingAsClient" = 4.7, "totalRatingsAsClient" = 3 WHERE id = 8;  -- Youssef

-- Update store ratings based on reviews
UPDATE stores SET rating = 4.75, "totalRatings" = 4 WHERE id = 1;  -- Riad Taza
UPDATE stores SET rating = 4.7,  "totalRatings" = 3 WHERE id = 2;  -- Pâtisserie
UPDATE stores SET rating = 4.3,  "totalRatings" = 3 WHERE id = 3;  -- Snack
UPDATE stores SET rating = 4.5,  "totalRatings" = 2 WHERE id = 4;  -- Marché Frais
UPDATE stores SET rating = 5.0,  "totalRatings" = 1 WHERE id = 5;  -- Pharmacie
UPDATE stores SET rating = 4.0,  "totalRatings" = 1 WHERE id = 6;  -- Tech Center
UPDATE stores SET rating = 5.0,  "totalRatings" = 1 WHERE id = 7;  -- Fleuriste

-- Update user_clients total orders
UPDATE user_clients SET "totalOrders" = 8 WHERE "userId" = 1;   -- Fouad: 6 store + several service
UPDATE user_clients SET "totalOrders" = 5 WHERE "userId" = 6;   -- client a
UPDATE user_clients SET "totalOrders" = 9 WHERE "userId" = 7;   -- Sarah
UPDATE user_clients SET "totalOrders" = 7 WHERE "userId" = 8;   -- Youssef

COMMIT;

-- Verify
SELECT 'store_reviews' as tbl, count(*) as cnt FROM store_reviews
UNION ALL SELECT 'ratings', count(*) FROM ratings
ORDER BY tbl;
