-- =====================================================
-- SCRIPT 2: STORES & PRODUCTS - Taza businesses
-- 8 stores across different categories with realistic products
-- =====================================================

BEGIN;

-- ── Update existing stores to Taza ─────────────────
-- Store 1 (user 5): Restaurant
UPDATE stores SET 
  name = 'Riad Taza',
  description = 'Restaurant traditionnel marocain, tajines et couscous faits maison',
  phone = '+212535672100',
  address = 'Rue de la Kasbah, Taza Haute',
  city = 'Taza',
  latitude = 34.2130, longitude = -4.0180,
  "deliveryRadiusKm" = 8.0,
  "minimumOrderAmount" = 30.0,
  "estimatedPrepTimeMinutes" = 25,
  "workingHours" = '{"mon":"11:00-23:00","tue":"11:00-23:00","wed":"11:00-23:00","thu":"11:00-23:00","fri":"11:00-23:30","sat":"11:00-23:30","sun":"12:00-22:00"}',
  "isActive" = true, "isOpen" = true,
  "totalOrders" = 156, rating = 4.7, "totalRatings" = 89,
  tagline = 'La tradition marocaine à votre porte',
  "aboutText" = 'Depuis 2018, Riad Taza propose les meilleurs plats traditionnels de la région. Nos tajines sont préparés avec des ingrédients frais du souk.',
  "acceptsCash" = true, "acceptsCard" = false,
  "hasDelivery" = true, "hasPickup" = true,
  "storeCategoryId" = 1
WHERE id = 1;

-- Store 2 (user 12): Café & Bakery → rename for Taza
UPDATE stores SET
  name = 'Pâtisserie Le Palais',
  description = 'Pâtisseries fines, viennoiseries et café de spécialité',
  phone = '+212535672200',
  address = 'Avenue Mohammed V, Centre Ville, Taza',
  city = 'Taza',
  latitude = 34.2095, longitude = -4.0120,
  "deliveryRadiusKm" = 6.0,
  "minimumOrderAmount" = 20.0,
  "estimatedPrepTimeMinutes" = 15,
  "workingHours" = '{"mon":"07:00-21:00","tue":"07:00-21:00","wed":"07:00-21:00","thu":"07:00-21:00","fri":"07:00-22:00","sat":"07:00-22:00","sun":"08:00-20:00"}',
  "isActive" = true, "isOpen" = true,
  "totalOrders" = 234, rating = 4.8, "totalRatings" = 142,
  tagline = 'L''art de la pâtisserie depuis 2015',
  "aboutText" = 'Pâtisserie artisanale au cœur de Taza. Nos gâteaux marocains et français sont préparés chaque matin avec amour.',
  "acceptsCash" = true, "acceptsCard" = true,
  "hasDelivery" = true, "hasPickup" = true,
  "storeCategoryId" = 3
WHERE id = 2;

-- Store 3 (user 13): Fast Food → rename for Taza
UPDATE stores SET
  name = 'Snack El Baraka',
  description = 'Sandwiches, chawarma, pizzas et burgers - le meilleur fast food de Taza',
  phone = '+212535672300',
  address = 'Place de l''Indépendance, Taza',
  city = 'Taza',
  latitude = 34.2110, longitude = -4.0090,
  "deliveryRadiusKm" = 7.0,
  "minimumOrderAmount" = 15.0,
  "estimatedPrepTimeMinutes" = 20,
  "workingHours" = '{"mon":"10:00-01:00","tue":"10:00-01:00","wed":"10:00-01:00","thu":"10:00-01:00","fri":"10:00-02:00","sat":"10:00-02:00","sun":"11:00-00:00"}',
  "isActive" = true, "isOpen" = true,
  "totalOrders" = 312, rating = 4.5, "totalRatings" = 198,
  tagline = 'Fast food à la marocaine',
  "aboutText" = 'Le snack préféré des Tazis! Chawarma fraîche, pizzas au feu de bois et les meilleurs burgers de la ville.',
  "acceptsCash" = true, "acceptsCard" = false,
  "hasDelivery" = true, "hasPickup" = true,
  "storeCategoryId" = 2
WHERE id = 3;

-- Store 4 (user 14): Supermarket → rename for Taza
UPDATE stores SET
  name = 'Marché Frais Taza',
  description = 'Fruits, légumes, épicerie fine et produits locaux de qualité',
  phone = '+212535672400',
  address = 'Hay Al Massira, Route de Fès, Taza',
  city = 'Taza',
  latitude = 34.2060, longitude = -4.0160,
  "deliveryRadiusKm" = 10.0,
  "minimumOrderAmount" = 50.0,
  "estimatedPrepTimeMinutes" = 15,
  "workingHours" = '{"mon":"08:00-22:00","tue":"08:00-22:00","wed":"08:00-22:00","thu":"08:00-22:00","fri":"08:00-22:00","sat":"08:00-22:00","sun":"09:00-21:00"}',
  "isActive" = true, "isOpen" = true,
  "totalOrders" = 189, rating = 4.6, "totalRatings" = 115,
  tagline = 'Vos courses livrées en 30 minutes',
  "aboutText" = 'Supermarché de proximité avec les meilleurs produits frais de Taza et de la région du Rif.',
  "acceptsCash" = true, "acceptsCard" = true,
  "hasDelivery" = true, "hasPickup" = true,
  "storeCategoryId" = 4
WHERE id = 4;

-- ── New stores (IDs 5-8) ──────────────────────────
-- We need new user accounts for these stores. Using existing users with store roles.
-- Actually, let's create 4 more stores using existing store owner users re-pointing is complex.
-- Instead, let's add 4 new virtual users for the new stores.

-- New store users (IDs 15-18)
INSERT INTO users (id, "firebaseUid", "fullName", "phoneNumber", email, roles, status, "isPhoneVerified", "isEmailVerified")
VALUES
(15, 'demo_store_user_15', 'Pharmacie Centrale',    '+212535672500', 'pharmacie.taza@awhar.demo',  '[2]', 0, true, true),
(16, 'demo_store_user_16', 'Tech Center Taza',      '+212535672600', 'techcenter.taza@awhar.demo',  '[2]', 0, true, true),
(17, 'demo_store_user_17', 'Fleuriste Yasmine',     '+212535672700', 'fleuriste.taza@awhar.demo',   '[2]', 0, true, true),
(18, 'demo_store_user_18', 'Librairie Al Maarifa',  '+212535672800', 'librairie.taza@awhar.demo',   '[2]', 0, true, true);

-- Wallets for new store users
INSERT INTO wallets ("userId", "totalEarned", "totalSpent", "pendingEarnings", "totalTransactions", "completedRides", "totalCommissionPaid", currency)
VALUES
(15, 2200.00, 0, 80.00,  18, 0, 115.79, 'MAD'),
(16, 1500.00, 0, 60.00,  12, 0,  78.95, 'MAD'),
(17, 900.00,  0, 40.00,   8, 0,  47.37, 'MAD'),
(18, 600.00,  0, 30.00,   5, 0,  31.58, 'MAD');

-- Store 5: Pharmacy
INSERT INTO stores (id, "userId", "storeCategoryId", name, description, phone, address, city, latitude, longitude,
  "deliveryRadiusKm", "minimumOrderAmount", "estimatedPrepTimeMinutes", "workingHours",
  "isActive", "isOpen", "totalOrders", rating, "totalRatings", tagline, "aboutText",
  "acceptsCash", "acceptsCard", "hasDelivery", "hasPickup")
VALUES
(5, 15, 5, 'Pharmacie Centrale', 'Pharmacie de garde, parapharmacie et produits de santé',
  '+212535672500', 'Avenue Hassan II, Centre Ville, Taza', 'Taza', 34.2098, -4.0110,
  8.0, 25.0, 10,
  '{"mon":"08:00-22:00","tue":"08:00-22:00","wed":"08:00-22:00","thu":"08:00-22:00","fri":"08:00-22:00","sat":"08:30-21:00","sun":"09:00-20:00"}',
  true, true, 95, 4.8, 67, 'Votre santé, notre priorité',
  'Pharmacie familiale depuis 2010. Large gamme de médicaments, parapharmacie, produits bébé et compléments alimentaires. Service de garde disponible.',
  true, true, true, true);

-- Store 6: Electronics
INSERT INTO stores (id, "userId", "storeCategoryId", name, description, phone, address, city, latitude, longitude,
  "deliveryRadiusKm", "minimumOrderAmount", "estimatedPrepTimeMinutes", "workingHours",
  "isActive", "isOpen", "totalOrders", rating, "totalRatings", tagline, "aboutText",
  "acceptsCash", "acceptsCard", "hasDelivery", "hasPickup")
VALUES
(6, 16, 6, 'Tech Center Taza', 'Smartphones, accessoires, réparation et informatique',
  '+212535672600', 'Rue Allal Ben Abdallah, Taza', 'Taza', 34.2105, -4.0070,
  6.0, 50.0, 10,
  '{"mon":"09:00-20:00","tue":"09:00-20:00","wed":"09:00-20:00","thu":"09:00-20:00","fri":"09:00-20:00","sat":"09:00-20:00","sun":"closed"}',
  true, true, 62, 4.4, 38, 'La tech accessible à Taza',
  'Revendeur agréé de smartphones et accessoires. Service de réparation rapide et conseil personnalisé.',
  true, true, true, true);

-- Store 7: Flowers
INSERT INTO stores (id, "userId", "storeCategoryId", name, description, phone, address, city, latitude, longitude,
  "deliveryRadiusKm", "minimumOrderAmount", "estimatedPrepTimeMinutes", "workingHours",
  "isActive", "isOpen", "totalOrders", rating, "totalRatings", tagline, "aboutText",
  "acceptsCash", "acceptsCard", "hasDelivery", "hasPickup")
VALUES
(7, 17, 7, 'Fleuriste Yasmine', 'Bouquets, compositions florales et cadeaux pour toutes les occasions',
  '+212535672700', 'Boulevard Mohammed VI, Taza', 'Taza', 34.2140, -4.0060,
  10.0, 40.0, 20,
  '{"mon":"08:00-20:00","tue":"08:00-20:00","wed":"08:00-20:00","thu":"08:00-20:00","fri":"08:00-21:00","sat":"08:00-21:00","sun":"09:00-18:00"}',
  true, true, 45, 4.9, 32, 'Des fleurs pour chaque émotion',
  'Artisan fleuriste spécialisé dans les compositions florales uniques. Livraison express pour les occasions spéciales.',
  true, false, true, true);

-- Store 8: Books
INSERT INTO stores (id, "userId", "storeCategoryId", name, description, phone, address, city, latitude, longitude,
  "deliveryRadiusKm", "minimumOrderAmount", "estimatedPrepTimeMinutes", "workingHours",
  "isActive", "isOpen", "totalOrders", rating, "totalRatings", tagline, "aboutText",
  "acceptsCash", "acceptsCard", "hasDelivery", "hasPickup")
VALUES
(8, 18, 9, 'Librairie Al Maarifa', 'Livres, fournitures scolaires, papeterie et jeux éducatifs',
  '+212535672800', 'Rue Ibn Khaldoun, Taza', 'Taza', 34.2085, -4.0135,
  5.0, 30.0, 10,
  '{"mon":"09:00-19:00","tue":"09:00-19:00","wed":"09:00-19:00","thu":"09:00-19:00","fri":"09:00-12:00,14:30-19:00","sat":"09:00-18:00","sun":"closed"}',
  true, true, 38, 4.6, 25, 'Le savoir à portée de main',
  'Librairie indépendante proposant une sélection de livres en arabe, français et anglais. Fournitures scolaires et de bureau.',
  true, false, true, true);

-- Update sequences
SELECT setval('stores_id_seq', 8);
SELECT setval('users_id_seq', 18);

-- ── Product Categories (per store) ─────────────────
-- Delete old and reinsert
INSERT INTO product_categories ("storeId", name, "isActive", "displayOrder")
VALUES
-- Store 1: Riad Taza (Restaurant)
(1, 'Tajines',            true, 1),
(1, 'Couscous',           true, 2),
(1, 'Entrées & Salades',  true, 3),
(1, 'Grillades',          true, 4),
(1, 'Boissons',           true, 5),
-- Store 2: Pâtisserie Le Palais
(2, 'Gâteaux Marocains',  true, 1),
(2, 'Viennoiseries',      true, 2),
(2, 'Gâteaux Modernes',   true, 3),
(2, 'Boissons Chaudes',   true, 4),
-- Store 3: Snack El Baraka
(3, 'Chawarma',           true, 1),
(3, 'Pizzas',             true, 2),
(3, 'Burgers',            true, 3),
(3, 'Tacos & Wraps',      true, 4),
(3, 'Boissons',           true, 5),
-- Store 4: Marché Frais
(4, 'Fruits & Légumes',   true, 1),
(4, 'Épicerie',           true, 2),
(4, 'Produits Laitiers',  true, 3),
(4, 'Boucherie',          true, 4),
-- Store 5: Pharmacie
(5, 'Médicaments',        true, 1),
(5, 'Parapharmacie',      true, 2),
(5, 'Bébé & Maman',       true, 3),
(5, 'Hygiène',            true, 4),
-- Store 6: Tech Center
(6, 'Smartphones',        true, 1),
(6, 'Accessoires',        true, 2),
(6, 'Informatique',       true, 3),
-- Store 7: Fleuriste
(7, 'Bouquets',           true, 1),
(7, 'Plantes',            true, 2),
(7, 'Cadeaux',            true, 3),
-- Store 8: Librairie
(8, 'Livres',             true, 1),
(8, 'Fournitures',        true, 2),
(8, 'Papeterie',          true, 3);

-- ── Store Products ─────────────────────────────────
-- We need product_category IDs. They auto-increment from 1 after cleanup.
-- Store 1 cats: 1-5, Store 2: 6-9, Store 3: 10-14, Store 4: 15-18
-- Store 5: 19-22, Store 6: 23-25, Store 7: 26-28, Store 8: 29-31

INSERT INTO store_products ("storeId", "productCategoryId", name, description, price, "isAvailable", "displayOrder")
VALUES
-- ── Store 1: Riad Taza (Restaurant) ──
(1, 1, 'Tajine Poulet Citron',       'Poulet fermier, citrons confits, olives vertes',     55.00, true, 1),
(1, 1, 'Tajine Kefta aux Œufs',      'Boulettes de viande hachée, sauce tomate, œufs',     45.00, true, 2),
(1, 1, 'Tajine Agneau Pruneaux',     'Agneau tendre, pruneaux, amandes grillées',          75.00, true, 3),
(1, 1, 'Tajine Légumes',             'Légumes de saison, épices douces',                   40.00, true, 4),
(1, 2, 'Couscous Royal',             'Agneau, poulet, merguez, légumes variés',            80.00, true, 1),
(1, 2, 'Couscous Tfaya',             'Poulet, oignons caramélisés, raisins secs',          65.00, true, 2),
(1, 3, 'Salade Marocaine',           'Tomates, concombres, oignons, huile d''olive',       20.00, true, 1),
(1, 3, 'Briouates au Fromage',       'Feuilles de brick, fromage frais, herbes',           25.00, true, 2),
(1, 3, 'Harira',                     'Soupe traditionnelle aux lentilles et pois chiches', 18.00, true, 3),
(1, 4, 'Brochettes Mixtes',          'Agneau et poulet marinés, grillés au charbon',       60.00, true, 1),
(1, 4, 'Côtelettes d''Agneau',       'Côtelettes grillées, herbes et épices',              70.00, true, 2),
(1, 5, 'Thé à la Menthe',            'Thé vert gunpowder, menthe fraîche',                 10.00, true, 1),
(1, 5, 'Jus d''Orange Pressé',       'Oranges fraîches pressées minute',                   15.00, true, 2),
(1, 5, 'Eau Minérale',               'Sidi Ali 1.5L',                                       8.00, true, 3),

-- ── Store 2: Pâtisserie Le Palais ──
(2, 6, 'Cornes de Gazelle',          'Pâte d''amande parfumée à la fleur d''oranger',      60.00, true, 1),
(2, 6, 'Baklava Marocain',           'Feuilles de brick, amandes, miel',                   55.00, true, 2),
(2, 6, 'Chebakia',                   'Pâte frite, graines de sésame, miel',                45.00, true, 3),
(2, 6, 'Ghriba aux Amandes',         'Biscuits fondants aux amandes',                      40.00, true, 4),
(2, 7, 'Croissant au Beurre',        'Croissant pur beurre, fait maison',                  8.00, true, 1),
(2, 7, 'Pain au Chocolat',           'Viennoiserie au chocolat noir',                      10.00, true, 2),
(2, 7, 'Msemen',                     'Crêpe feuilletée traditionnelle',                    5.00, true, 3),
(2, 7, 'Baghrir',                    'Crêpe aux mille trous, servie avec miel',            5.00, true, 4),
(2, 8, 'Gâteau au Chocolat',         'Fondant au chocolat noir 70%',                       35.00, true, 1),
(2, 8, 'Tarte aux Fruits',           'Pâte sablée, crème pâtissière, fruits de saison',   40.00, true, 2),
(2, 8, 'Cheesecake',                 'New York style, coulis de framboise',                38.00, true, 3),
(2, 9, 'Café Espresso',              'Café italien, torréfaction artisanale',              12.00, true, 1),
(2, 9, 'Cappuccino',                 'Espresso, lait mousseux, cacao',                    18.00, true, 2),
(2, 9, 'Thé à la Menthe',            'Thé vert, menthe fraîche du jardin',                10.00, true, 3),

-- ── Store 3: Snack El Baraka ──
(3, 10, 'Chawarma Poulet',            'Poulet mariné, crudités, sauce blanche',             25.00, true, 1),
(3, 10, 'Chawarma Viande',            'Viande épicée, salade, sauce piquante',              30.00, true, 2),
(3, 10, 'Chawarma Mixte',             'Poulet et viande, double garniture',                 35.00, true, 3),
(3, 11, 'Pizza Margherita',           'Tomate, mozzarella, basilic frais',                  40.00, true, 1),
(3, 11, 'Pizza Viande Hachée',        'Sauce tomate, viande hachée, oignons, poivrons',     50.00, true, 2),
(3, 11, 'Pizza 4 Fromages',           'Mozzarella, chèvre, emmental, bleu',                55.00, true, 3),
(3, 12, 'Burger Classic',             'Steak haché, salade, tomate, cheddar',               35.00, true, 1),
(3, 12, 'Burger Double',              'Double steak, double cheddar, sauce BBQ',            50.00, true, 2),
(3, 12, 'Burger Poulet Crispy',       'Filet de poulet pané, coleslaw',                    40.00, true, 3),
(3, 13, 'Tacos Classique',            'Viande, frites, fromage, sauce algérienne',          30.00, true, 1),
(3, 13, 'Wrap Poulet Caesar',         'Poulet grillé, parmesan, sauce caesar',              28.00, true, 2),
(3, 14, 'Coca-Cola 33cl',             'Canette classique',                                  8.00, true, 1),
(3, 14, 'Jus Raibi',                  'Boisson lactée aux fruits',                         6.00, true, 2),
(3, 14, 'Eau Sidi Ali 50cl',          'Eau minérale naturelle',                             5.00, true, 3),

-- ── Store 4: Marché Frais Taza ──
(4, 15, 'Tomates (1kg)',              'Tomates fraîches de saison',                          8.00, true, 1),
(4, 15, 'Pommes de Terre (1kg)',      'Pommes de terre locales',                             5.00, true, 2),
(4, 15, 'Oignons (1kg)',              'Oignons jaunes',                                     4.00, true, 3),
(4, 15, 'Oranges (1kg)',              'Oranges à jus, région de Berkane',                  10.00, true, 4),
(4, 15, 'Bananes (1kg)',              'Bananes importées, mûres',                          15.00, true, 5),
(4, 16, 'Huile d''Olive (1L)',        'Huile d''olive extra vierge, pressée à froid',       60.00, true, 1),
(4, 16, 'Riz Basmati (1kg)',          'Riz basmati premium',                               18.00, true, 2),
(4, 16, 'Lentilles (500g)',           'Lentilles vertes du Maroc',                          8.00, true, 3),
(4, 16, 'Sucre (1kg)',                'Sucre blanc en poudre',                              7.00, true, 4),
(4, 17, 'Lait Centrale (1L)',         'Lait entier pasteurisé',                              7.00, true, 1),
(4, 17, 'Yaourt Danone (x6)',         'Pack de 6 yaourts nature',                          18.00, true, 2),
(4, 17, 'Fromage Vache Qui Rit (x16)','Fromage fondu, 16 portions',                        22.00, true, 3),
(4, 18, 'Poulet Entier',              'Poulet fermier frais, environ 1.5kg',               45.00, true, 1),
(4, 18, 'Viande Hachée (500g)',       'Bœuf haché, qualité boucherie',                     40.00, true, 2),
(4, 18, 'Merguez (500g)',             'Merguez maison, épicées',                           35.00, true, 3),

-- ── Store 5: Pharmacie Centrale ──
(5, 19, 'Doliprane 1000mg',           'Paracétamol, boîte de 8 comprimés',                 15.00, true, 1),
(5, 19, 'Smecta',                     'Anti-diarrhéique, boîte de 30 sachets',             45.00, true, 2),
(5, 19, 'Vitamine C 1000mg',          'Vitamine C effervescente, tube de 20',              35.00, true, 3),
(5, 20, 'Crème Solaire SPF50',        'Protection solaire haute, 200ml',                   120.00, true, 1),
(5, 20, 'Gel Main Hydroalcoolique',   'Gel antiseptique, flacon 500ml',                    25.00, true, 2),
(5, 20, 'Masques Chirurgicaux (x50)', 'Masques 3 plis, boîte de 50',                      40.00, true, 3),
(5, 21, 'Couches Pampers Taille 3',   'Pack de 30 couches, 6-10kg',                        85.00, true, 1),
(5, 21, 'Lait Infantile 1er Âge',     'Lait en poudre 0-6 mois, 800g',                   110.00, true, 2),
(5, 22, 'Dentifrice Signal',          'Tube de 75ml, protection caries',                   15.00, true, 1),
(5, 22, 'Shampoing Head & Shoulders', 'Anti-pelliculaire, 400ml',                          45.00, true, 2),

-- ── Store 6: Tech Center Taza ──
(6, 23, 'Samsung Galaxy A15',          'Écran 6.5", 128GB, Double SIM',                  1800.00, true, 1),
(6, 23, 'Xiaomi Redmi Note 13',       'Écran AMOLED 6.67", 256GB',                      2200.00, true, 2),
(6, 23, 'iPhone SE (reconditionné)',   'iPhone SE 2022, 64GB, état excellent',            3500.00, true, 3),
(6, 24, 'Coque Silicone Universelle',  'Protection souple, plusieurs couleurs',             30.00, true, 1),
(6, 24, 'Chargeur USB-C Rapide',      'Chargeur 25W, câble inclus',                        60.00, true, 2),
(6, 24, 'Écouteurs Bluetooth',         'Écouteurs sans fil, autonomie 6h',                 120.00, true, 3),
(6, 24, 'Protection Écran Verre',      'Verre trempé 9H, anti-rayures',                    25.00, true, 4),
(6, 25, 'Clé USB 64GB',               'SanDisk USB 3.0',                                   50.00, true, 1),
(6, 25, 'Souris Sans Fil',            'Souris optique Logitech',                            80.00, true, 2),

-- ── Store 7: Fleuriste Yasmine ──
(7, 26, 'Bouquet Romantique',          '12 roses rouges, eucalyptus, emballage',           120.00, true, 1),
(7, 26, 'Bouquet Printanier',          'Tulipes, marguerites, tournesols',                  90.00, true, 2),
(7, 26, 'Bouquet Mixte Classique',     'Roses, lys, gerberas assortis',                   100.00, true, 3),
(7, 26, 'Composition Deuil',           'Gerbe de fleurs blanches et vertes',               150.00, true, 4),
(7, 27, 'Orchidée en Pot',             'Phalaenopsis, pot décoratif',                      180.00, true, 1),
(7, 27, 'Cactus Collection',           'Assortiment de 3 mini cactus',                      60.00, true, 2),
(7, 27, 'Plante Verte Intérieur',      'Ficus ou Monstera, pot inclus',                   140.00, true, 3),
(7, 28, 'Boîte Chocolats + Fleurs',    'Mini bouquet + boîte de chocolats artisanaux',     200.00, true, 1),
(7, 28, 'Coffret Cadeau Naissance',    'Peluche, fleurs et carte de félicitations',        250.00, true, 2),

-- ── Store 8: Librairie Al Maarifa ──
(8, 29, 'Le Petit Prince (FR)',        'Antoine de Saint-Exupéry, édition illustrée',       45.00, true, 1),
(8, 29, 'Cahier de Vacances CM2',      'Révisions ludiques, toutes matières',               35.00, true, 2),
(8, 29, 'Dictionnaire Larousse FR',    'Édition 2025, format poche',                        80.00, true, 3),
(8, 29, 'القرآن الكريم',               'Mushaf, couverture en cuir',                       120.00, true, 4),
(8, 30, 'Cahier 96 Pages (x5)',        'Cahiers grands carreaux, lot de 5',                 25.00, true, 1),
(8, 30, 'Stylos BIC (x10)',            'Stylos à bille bleu, pack de 10',                   20.00, true, 2),
(8, 30, 'Sac à Dos Scolaire',          'Sac renforcé, compartiment laptop',                150.00, true, 3),
(8, 31, 'Enveloppes (x50)',            'Enveloppes blanches format A5',                      15.00, true, 1),
(8, 31, 'Rames Papier A4',            'Papier blanc 80g, 500 feuilles',                    40.00, true, 2);

COMMIT;

-- Verify
SELECT s.id, s.name, s.city, s.rating, s."totalOrders",
  (SELECT count(*) FROM product_categories pc WHERE pc."storeId" = s.id) as categories,
  (SELECT count(*) FROM store_products sp WHERE sp."storeId" = s.id) as products
FROM stores s ORDER BY s.id;
