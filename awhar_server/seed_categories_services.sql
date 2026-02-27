-- ============================================================
-- Awhar Service Categories & Services - Professional Seed Data
-- Multi-language support: English, Arabic, French, Spanish
-- Icons: Material Icons / Iconsax names
-- ============================================================

-- Clear existing data (if needed)
-- TRUNCATE TABLE services CASCADE;
-- TRUNCATE TABLE service_categories CASCADE;

-- ============================================================
-- MAIN SERVICE CATEGORIES
-- ============================================================

-- 1. Transportation & Rides
INSERT INTO service_categories (
  name, "nameAr", "nameFr", "nameEs", 
  icon, description, 
  "displayOrder", "isActive", "defaultRadiusKm",
  "createdAt", "updatedAt"
) VALUES (
  'Transportation & Rides',
  'النقل والتوصيل',
  'Transport & Courses',
  'Transporte y Viajes',
  'car',
  'Personal transportation, taxi services, ride-sharing',
  1,
  true,
  15.0,
  NOW(),
  NOW()
);

-- 2. Delivery Services
INSERT INTO service_categories (
  name, "nameAr", "nameFr", "nameEs",
  icon, description,
  "displayOrder", "isActive", "defaultRadiusKm",
  "createdAt", "updatedAt"
) VALUES (
  'Delivery Services',
  'خدمات التوصيل',
  'Services de Livraison',
  'Servicios de Entrega',
  'local_shipping',
  'Package delivery, document courier, express delivery',
  2,
  true,
  20.0,
  NOW(),
  NOW()
);

-- 3. Shopping & Errands
INSERT INTO service_categories (
  name, "nameAr", "nameFr", "nameEs",
  icon, description,
  "displayOrder", "isActive", "defaultRadiusKm",
  "createdAt", "updatedAt"
) VALUES (
  'Shopping & Errands',
  'التسوق والمهام',
  'Shopping & Courses',
  'Compras y Recados',
  'shopping_cart',
  'Grocery shopping, pharmacy runs, personal shopping assistance',
  3,
  true,
  10.0,
  NOW(),
  NOW()
);

-- 4. Moving & Transport
INSERT INTO service_categories (
  name, "nameAr", "nameFr", "nameEs",
  icon, description,
  "displayOrder", "isActive", "defaultRadiusKm",
  "createdAt", "updatedAt"
) VALUES (
  'Moving & Transport',
  'النقل والشحن',
  'Déménagement & Transport',
  'Mudanzas y Transporte',
  'local_shipping',
  'Furniture moving, large item transport, relocation services',
  4,
  true,
  25.0,
  NOW(),
  NOW()
);

-- 5. Food & Restaurant Delivery
INSERT INTO service_categories (
  name, "nameAr", "nameFr", "nameEs",
  icon, description,
  "displayOrder", "isActive", "defaultRadiusKm",
  "createdAt", "updatedAt"
) VALUES (
  'Food & Restaurant Delivery',
  'توصيل الطعام',
  'Livraison de Nourriture',
  'Entrega de Comida',
  'restaurant',
  'Restaurant food delivery, meal pickup, catering delivery',
  5,
  true,
  10.0,
  NOW(),
  NOW()
);

-- 6. Professional Services
INSERT INTO service_categories (
  name, "nameAr", "nameFr", "nameEs",
  icon, description,
  "displayOrder", "isActive", "defaultRadiusKm",
  "createdAt", "updatedAt"
) VALUES (
  'Professional Services',
  'الخدمات المهنية',
  'Services Professionnels',
  'Servicios Profesionales',
  'work',
  'Business errands, document services, professional assistance',
  6,
  true,
  15.0,
  NOW(),
  NOW()
);

-- ============================================================
-- SERVICES FOR EACH CATEGORY
-- ============================================================

-- Get category IDs (these will be used in subsequent inserts)
-- Transportation & Rides Services
INSERT INTO services (
  "categoryId", "nameEn", "nameAr", "nameFr", "nameEs",
  "descriptionEn", "descriptionAr", "descriptionFr", "descriptionEs",
  "iconName", "suggestedPriceMin", "suggestedPriceMax",
  "isActive", "displayOrder", "isPopular",
  "createdAt", "updatedAt"
)
SELECT 
  id,
  'City Ride',
  'توصيلة داخل المدينة',
  'Course en Ville',
  'Viaje por la Ciudad',
  'Point-to-point transportation within the city',
  'نقل من نقطة لأخرى داخل المدينة',
  'Transport point à point dans la ville',
  'Transporte punto a punto dentro de la ciudad',
  'directions_car',
  20.0,
  100.0,
  true,
  1,
  true,
  NOW(),
  NOW()
FROM service_categories WHERE name = 'Transportation & Rides';

INSERT INTO services (
  "categoryId", "nameEn", "nameAr", "nameFr", "nameEs",
  "descriptionEn", "descriptionAr", "descriptionFr", "descriptionEs",
  "iconName", "suggestedPriceMin", "suggestedPriceMax",
  "isActive", "displayOrder", "isPopular",
  "createdAt", "updatedAt"
)
SELECT 
  id,
  'Airport Transfer',
  'نقل من وإلى المطار',
  'Transfert Aéroport',
  'Traslado al Aeropuerto',
  'Comfortable airport pickup and drop-off service',
  'خدمة نقل مريحة من وإلى المطار',
  'Service de navette aéroport confortable',
  'Servicio cómodo de recogida y entrega en el aeropuerto',
  'flight',
  150.0,
  300.0,
  true,
  2,
  true,
  NOW(),
  NOW()
FROM service_categories WHERE name = 'Transportation & Rides';

INSERT INTO services (
  "categoryId", "nameEn", "nameAr", "nameFr", "nameEs",
  "descriptionEn", "descriptionAr", "descriptionFr", "descriptionEs",
  "iconName", "suggestedPriceMin", "suggestedPriceMax",
  "isActive", "displayOrder", "isPopular",
  "createdAt", "updatedAt"
)
SELECT 
  id,
  'Hourly Rental',
  'استئجار بالساعة',
  'Location Horaire',
  'Alquiler por Horas',
  'Rent a driver with vehicle for multiple stops',
  'استئجار سائق مع مركبة لعدة توقفات',
  'Louez un chauffeur avec véhicule pour plusieurs arrêts',
  'Alquila un conductor con vehículo para varias paradas',
  'schedule',
  100.0,
  200.0,
  true,
  3,
  false,
  NOW(),
  NOW()
FROM service_categories WHERE name = 'Transportation & Rides';

-- Delivery Services
INSERT INTO services (
  "categoryId", "nameEn", "nameAr", "nameFr", "nameEs",
  "descriptionEn", "descriptionAr", "descriptionFr", "descriptionEs",
  "iconName", "suggestedPriceMin", "suggestedPriceMax",
  "isActive", "displayOrder", "isPopular",
  "createdAt", "updatedAt"
)
SELECT 
  id,
  'Package Delivery',
  'توصيل الطرود',
  'Livraison de Colis',
  'Entrega de Paquetes',
  'Fast and secure package delivery service',
  'خدمة توصيل طرود سريعة وآمنة',
  'Service de livraison de colis rapide et sécurisé',
  'Servicio de entrega de paquetes rápido y seguro',
  'package',
  15.0,
  50.0,
  true,
  1,
  true,
  NOW(),
  NOW()
FROM service_categories WHERE name = 'Delivery Services';

INSERT INTO services (
  "categoryId", "nameEn", "nameAr", "nameFr", "nameEs",
  "descriptionEn", "descriptionAr", "descriptionFr", "descriptionEs",
  "iconName", "suggestedPriceMin", "suggestedPriceMax",
  "isActive", "displayOrder", "isPopular",
  "createdAt", "updatedAt"
)
SELECT 
  id,
  'Document Courier',
  'توصيل الوثائق',
  'Coursier de Documents',
  'Mensajería de Documentos',
  'Express document and envelope delivery',
  'توصيل سريع للوثائق والمظاريف',
  'Livraison express de documents et enveloppes',
  'Entrega urgente de documentos y sobres',
  'description',
  10.0,
  30.0,
  true,
  2,
  true,
  NOW(),
  NOW()
FROM service_categories WHERE name = 'Delivery Services';

INSERT INTO services (
  "categoryId", "nameEn", "nameAr", "nameFr", "nameEs",
  "descriptionEn", "descriptionAr", "descriptionFr", "descriptionEs",
  "iconName", "suggestedPriceMin", "suggestedPriceMax",
  "isActive", "displayOrder", "isPopular",
  "createdAt", "updatedAt"
)
SELECT 
  id,
  'Same-Day Delivery',
  'توصيل في نفس اليوم',
  'Livraison le Jour Même',
  'Entrega el Mismo Día',
  'Urgent same-day delivery for important items',
  'توصيل عاجل في نفس اليوم للأشياء المهمة',
  'Livraison urgente le jour même pour articles importants',
  'Entrega urgente el mismo día para artículos importantes',
  'electric_bolt',
  25.0,
  80.0,
  true,
  3,
  false,
  NOW(),
  NOW()
FROM service_categories WHERE name = 'Delivery Services';

-- Shopping & Errands
INSERT INTO services (
  "categoryId", "nameEn", "nameAr", "nameFr", "nameEs",
  "descriptionEn", "descriptionAr", "descriptionFr", "descriptionEs",
  "iconName", "suggestedPriceMin", "suggestedPriceMax",
  "isActive", "displayOrder", "isPopular",
  "createdAt", "updatedAt"
)
SELECT 
  id,
  'Grocery Shopping',
  'تسوق البقالة',
  'Courses Alimentaires',
  'Compras de Comestibles',
  'Personal grocery shopping and delivery service',
  'خدمة تسوق البقالة والتوصيل الشخصية',
  'Service personnel d''achat et livraison de courses',
  'Servicio personal de compra y entrega de comestibles',
  'local_grocery_store',
  30.0,
  100.0,
  true,
  1,
  true,
  NOW(),
  NOW()
FROM service_categories WHERE name = 'Shopping & Errands';

INSERT INTO services (
  "categoryId", "nameEn", "nameAr", "nameFr", "nameEs",
  "descriptionEn", "descriptionAr", "descriptionFr", "descriptionEs",
  "iconName", "suggestedPriceMin", "suggestedPriceMax",
  "isActive", "displayOrder", "isPopular",
  "createdAt", "updatedAt"
)
SELECT 
  id,
  'Pharmacy Run',
  'شراء الأدوية',
  'Course à la Pharmacie',
  'Compra de Medicamentos',
  'Medication pickup and delivery service',
  'خدمة شراء وتوصيل الأدوية',
  'Service de récupération et livraison de médicaments',
  'Servicio de recogida y entrega de medicamentos',
  'local_pharmacy',
  20.0,
  50.0,
  true,
  2,
  true,
  NOW(),
  NOW()
FROM service_categories WHERE name = 'Shopping & Errands';

INSERT INTO services (
  "categoryId", "nameEn", "nameAr", "nameFr", "nameEs",
  "descriptionEn", "descriptionAr", "descriptionFr", "descriptionEs",
  "iconName", "suggestedPriceMin", "suggestedPriceMax",
  "isActive", "displayOrder", "isPopular",
  "createdAt", "updatedAt"
)
SELECT 
  id,
  'Personal Shopping',
  'تسوق شخصي',
  'Shopping Personnel',
  'Compras Personales',
  'Shop for clothes, gifts, or any personal items',
  'التسوق للملابس أو الهدايا أو أي أغراض شخصية',
  'Acheter des vêtements, cadeaux ou articles personnels',
  'Comprar ropa, regalos o cualquier artículo personal',
  'shopping_bag',
  40.0,
  150.0,
  true,
  3,
  false,
  NOW(),
  NOW()
FROM service_categories WHERE name = 'Shopping & Errands';

-- Moving & Transport
INSERT INTO services (
  "categoryId", "nameEn", "nameAr", "nameFr", "nameEs",
  "descriptionEn", "descriptionAr", "descriptionFr", "descriptionEs",
  "iconName", "suggestedPriceMin", "suggestedPriceMax",
  "isActive", "displayOrder", "isPopular",
  "createdAt", "updatedAt"
)
SELECT 
  id,
  'Furniture Moving',
  'نقل الأثاث',
  'Déménagement de Meubles',
  'Mudanza de Muebles',
  'Professional furniture and household item moving',
  'نقل احترافي للأثاث والأغراض المنزلية',
  'Déménagement professionnel de meubles et articles ménagers',
  'Mudanza profesional de muebles y artículos del hogar',
  'chair',
  200.0,
  800.0,
  true,
  1,
  true,
  NOW(),
  NOW()
FROM service_categories WHERE name = 'Moving & Transport';

INSERT INTO services (
  "categoryId", "nameEn", "nameAr", "nameFr", "nameEs",
  "descriptionEn", "descriptionAr", "descriptionFr", "descriptionEs",
  "iconName", "suggestedPriceMin", "suggestedPriceMax",
  "isActive", "displayOrder", "isPopular",
  "createdAt", "updatedAt"
)
SELECT 
  id,
  'Small Item Transport',
  'نقل الأشياء الصغيرة',
  'Transport Petits Articles',
  'Transporte de Artículos Pequeños',
  'Transport small to medium-sized items',
  'نقل الأشياء الصغيرة إلى المتوسطة الحجم',
  'Transporter des articles petits à moyens',
  'Transportar artículos pequeños a medianos',
  'inventory',
  50.0,
  200.0,
  true,
  2,
  false,
  NOW(),
  NOW()
FROM service_categories WHERE name = 'Moving & Transport';

INSERT INTO services (
  "categoryId", "nameEn", "nameAr", "nameFr", "nameEs",
  "descriptionEn", "descriptionAr", "descriptionFr", "descriptionEs",
  "iconName", "suggestedPriceMin", "suggestedPriceMax",
  "isActive", "displayOrder", "isPopular",
  "createdAt", "updatedAt"
)
SELECT 
  id,
  'Full House Move',
  'نقل منزل كامل',
  'Déménagement Complet',
  'Mudanza Completa',
  'Complete house or apartment relocation service',
  'خدمة نقل منزل أو شقة كاملة',
  'Service complet de déménagement de maison ou appartement',
  'Servicio completo de mudanza de casa o apartamento',
  'home',
  500.0,
  2000.0,
  true,
  3,
  true,
  NOW(),
  NOW()
FROM service_categories WHERE name = 'Moving & Transport';

-- Food & Restaurant Delivery
INSERT INTO services (
  "categoryId", "nameEn", "nameAr", "nameFr", "nameEs",
  "descriptionEn", "descriptionAr", "descriptionFr", "descriptionEs",
  "iconName", "suggestedPriceMin", "suggestedPriceMax",
  "isActive", "displayOrder", "isPopular",
  "createdAt", "updatedAt"
)
SELECT 
  id,
  'Restaurant Delivery',
  'توصيل من المطاعم',
  'Livraison Restaurant',
  'Entrega de Restaurantes',
  'Deliver food from your favorite restaurants',
  'توصيل الطعام من مطاعمك المفضلة',
  'Livrer de la nourriture de vos restaurants préférés',
  'Entregar comida de tus restaurantes favoritos',
  'restaurant_menu',
  15.0,
  50.0,
  true,
  1,
  true,
  NOW(),
  NOW()
FROM service_categories WHERE name = 'Food & Restaurant Delivery';

INSERT INTO services (
  "categoryId", "nameEn", "nameAr", "nameFr", "nameEs",
  "descriptionEn", "descriptionAr", "descriptionFr", "descriptionEs",
  "iconName", "suggestedPriceMin", "suggestedPriceMax",
  "isActive", "displayOrder", "isPopular",
  "createdAt", "updatedAt"
)
SELECT 
  id,
  'Fast Food Pickup',
  'استلام الوجبات السريعة',
  'Récupération Fast Food',
  'Recogida de Comida Rápida',
  'Quick pickup from fast food chains',
  'استلام سريع من سلاسل الوجبات السريعة',
  'Récupération rapide dans les chaînes de restauration rapide',
  'Recogida rápida de cadenas de comida rápida',
  'fastfood',
  10.0,
  30.0,
  true,
  2,
  true,
  NOW(),
  NOW()
FROM service_categories WHERE name = 'Food & Restaurant Delivery';

-- Professional Services
INSERT INTO services (
  "categoryId", "nameEn", "nameAr", "nameFr", "nameEs",
  "descriptionEn", "descriptionAr", "descriptionFr", "descriptionEs",
  "iconName", "suggestedPriceMin", "suggestedPriceMax",
  "isActive", "displayOrder", "isPopular",
  "createdAt", "updatedAt"
)
SELECT 
  id,
  'Business Errands',
  'مهام العمل',
  'Courses Professionnelles',
  'Recados Comerciales',
  'Professional errands for businesses',
  'مهام احترافية للشركات',
  'Courses professionnelles pour entreprises',
  'Recados profesionales para empresas',
  'business_center',
  30.0,
  100.0,
  true,
  1,
  false,
  NOW(),
  NOW()
FROM service_categories WHERE name = 'Professional Services';

INSERT INTO services (
  "categoryId", "nameEn", "nameAr", "nameFr", "nameEs",
  "descriptionEn", "descriptionAr", "descriptionFr", "descriptionEs",
  "iconName", "suggestedPriceMin", "suggestedPriceMax",
  "isActive", "displayOrder", "isPopular",
  "createdAt", "updatedAt"
)
SELECT 
  id,
  'Document Services',
  'خدمات الوثائق',
  'Services de Documents',
  'Servicios de Documentos',
  'Document pickup, delivery, and administrative tasks',
  'استلام وتوصيل الوثائق والمهام الإدارية',
  'Récupération, livraison de documents et tâches administratives',
  'Recogida, entrega de documentos y tareas administrativas',
  'folder',
  20.0,
  60.0,
  true,
  2,
  false,
  NOW(),
  NOW()
FROM service_categories WHERE name = 'Professional Services';

-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================

-- Check inserted categories
SELECT id, name, "nameAr", icon, "displayOrder", "isActive" 
FROM service_categories 
ORDER BY "displayOrder";

-- Check inserted services with category names
SELECT 
  sc.name as category,
  s."nameEn",
  s."nameAr",
  s."iconName",
  s."suggestedPriceMin",
  s."suggestedPriceMax",
  s."isPopular",
  s."displayOrder"
FROM services s
JOIN service_categories sc ON s."categoryId" = sc.id
ORDER BY sc."displayOrder", s."displayOrder";

-- Count services per category
SELECT 
  sc.name as category,
  COUNT(s.id) as service_count
FROM service_categories sc
LEFT JOIN services s ON s."categoryId" = sc.id
GROUP BY sc.id, sc.name
ORDER BY sc."displayOrder";
