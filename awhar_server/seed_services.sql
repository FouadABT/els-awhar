-- Insert services for each category
-- Transportation & Rides (categoryId = 1)
INSERT INTO services ("categoryId", "nameEn", "nameAr", "nameFr", "nameEs", "descriptionEn", "iconName", "suggestedPriceMin", "suggestedPriceMax", "isActive", "displayOrder", "isPopular", "createdAt", "updatedAt")
VALUES
(1, 'City Ride', 'توصيلة داخل المدينة', 'Course en Ville', 'Viaje por la Ciudad', 'Point-to-point transportation within the city', 'directions_car', 20.0, 100.0, true, 1, true, NOW(), NOW()),
(1, 'Airport Transfer', 'نقل من وإلى المطار', 'Transfert Aéroport', 'Traslado al Aeropuerto', 'Comfortable airport pickup and drop-off service', 'flight', 150.0, 300.0, true, 2, true, NOW(), NOW()),
(1, 'Hourly Rental', 'استئجار بالساعة', 'Location Horaire', 'Alquiler por Horas', 'Rent a driver with vehicle for multiple stops', 'schedule', 100.0, 200.0, true, 3, false, NOW(), NOW()),
(1, 'Intercity Travel', 'سفر بين المدن', 'Voyage Interurbain', 'Viaje Interurbano', 'Long-distance travel between cities', 'route', 200.0, 500.0, true, 4, false, NOW(), NOW());

-- Delivery Services (categoryId = 2)
INSERT INTO services ("categoryId", "nameEn", "nameAr", "nameFr", "nameEs", "descriptionEn", "iconName", "suggestedPriceMin", "suggestedPriceMax", "isActive", "displayOrder", "isPopular", "createdAt", "updatedAt")
VALUES
(2, 'Package Delivery', 'توصيل الطرود', 'Livraison de Colis', 'Entrega de Paquetes', 'Fast and secure package delivery service', 'package', 15.0, 50.0, true, 1, true, NOW(), NOW()),
(2, 'Document Courier', 'توصيل الوثائق', 'Coursier de Documents', 'Mensajería de Documentos', 'Express document and envelope delivery', 'description', 10.0, 30.0, true, 2, true, NOW(), NOW()),
(2, 'Same-Day Delivery', 'توصيل في نفس اليوم', 'Livraison le Jour Même', 'Entrega el Mismo Día', 'Urgent same-day delivery for important items', 'electric_bolt', 25.0, 80.0, true, 3, false, NOW(), NOW()),
(2, 'Fragile Items', 'البضائع الهشة', 'Articles Fragiles', 'Artículos Frágiles', 'Special handling for delicate and fragile items', 'inventory_2', 30.0, 100.0, true, 4, false, NOW(), NOW());

-- Shopping & Errands (categoryId = 3)
INSERT INTO services ("categoryId", "nameEn", "nameAr", "nameFr", "nameEs", "descriptionEn", "iconName", "suggestedPriceMin", "suggestedPriceMax", "isActive", "displayOrder", "isPopular", "createdAt", "updatedAt")
VALUES
(3, 'Grocery Shopping', 'تسوق البقالة', 'Courses Alimentaires', 'Compras de Comestibles', 'Personal grocery shopping and delivery service', 'local_grocery_store', 30.0, 100.0, true, 1, true, NOW(), NOW()),
(3, 'Pharmacy Run', 'شراء الأدوية', 'Course à la Pharmacie', 'Compra de Medicamentos', 'Medication pickup and delivery service', 'local_pharmacy', 20.0, 50.0, true, 2, true, NOW(), NOW()),
(3, 'Personal Shopping', 'تسوق شخصي', 'Shopping Personnel', 'Compras Personales', 'Shop for clothes, gifts, or any personal items', 'shopping_bag', 40.0, 150.0, true, 3, false, NOW(), NOW()),
(3, 'Bill Payment', 'دفع الفواتير', 'Paiement de Factures', 'Pago de Facturas', 'Pay bills and handle administrative tasks', 'receipt', 15.0, 40.0, true, 4, false, NOW(), NOW());

-- Moving & Transport (categoryId = 4)
INSERT INTO services ("categoryId", "nameEn", "nameAr", "nameFr", "nameEs", "descriptionEn", "iconName", "suggestedPriceMin", "suggestedPriceMax", "isActive", "displayOrder", "isPopular", "createdAt", "updatedAt")
VALUES
(4, 'Furniture Moving', 'نقل الأثاث', 'Déménagement de Meubles', 'Mudanza de Muebles', 'Professional furniture and household item moving', 'chair', 200.0, 800.0, true, 1, true, NOW(), NOW()),
(4, 'Small Item Transport', 'نقل الأشياء الصغيرة', 'Transport Petits Articles', 'Transporte de Artículos Pequeños', 'Transport small to medium-sized items', 'inventory', 50.0, 200.0, true, 2, false, NOW(), NOW()),
(4, 'Full House Move', 'نقل منزل كامل', 'Déménagement Complet', 'Mudanza Completa', 'Complete house or apartment relocation service', 'home', 500.0, 2000.0, true, 3, true, NOW(), NOW()),
(4, 'Appliance Moving', 'نقل الأجهزة', 'Transport Électroménager', 'Mudanza de Electrodomésticos', 'Move large appliances like fridges, washers', 'kitchen', 100.0, 300.0, true, 4, false, NOW(), NOW());

-- Food & Restaurant Delivery (categoryId = 5)
INSERT INTO services ("categoryId", "nameEn", "nameAr", "nameFr", "nameEs", "descriptionEn", "iconName", "suggestedPriceMin", "suggestedPriceMax", "isActive", "displayOrder", "isPopular", "createdAt", "updatedAt")
VALUES
(5, 'Restaurant Delivery', 'توصيل من المطاعم', 'Livraison Restaurant', 'Entrega de Restaurantes', 'Deliver food from your favorite restaurants', 'restaurant_menu', 15.0, 50.0, true, 1, true, NOW(), NOW()),
(5, 'Fast Food Pickup', 'استلام الوجبات السريعة', 'Récupération Fast Food', 'Recogida de Comida Rápida', 'Quick pickup from fast food chains', 'fastfood', 10.0, 30.0, true, 2, true, NOW(), NOW()),
(5, 'Catering Delivery', 'توصيل الولائم', 'Livraison Traiteur', 'Entrega de Catering', 'Large orders and catering delivery', 'celebration', 100.0, 500.0, true, 3, false, NOW(), NOW());

-- Professional Services (categoryId = 6)
INSERT INTO services ("categoryId", "nameEn", "nameAr", "nameFr", "nameEs", "descriptionEn", "iconName", "suggestedPriceMin", "suggestedPriceMax", "isActive", "displayOrder", "isPopular", "createdAt", "updatedAt")
VALUES
(6, 'Business Errands', 'مهام العمل', 'Courses Professionnelles', 'Recados Comerciales', 'Professional errands for businesses', 'business_center', 30.0, 100.0, true, 1, false, NOW(), NOW()),
(6, 'Document Services', 'خدمات الوثائق', 'Services de Documents', 'Servicios de Documentos', 'Document pickup, delivery, and administrative tasks', 'folder', 20.0, 60.0, true, 2, false, NOW(), NOW()),
(6, 'Bank Services', 'الخدمات المصرفية', 'Services Bancaires', 'Servicios Bancarios', 'Banking errands and transactions', 'account_balance', 25.0, 80.0, true, 3, false, NOW(), NOW());

-- Verify
SELECT 
  c."nameEn" as category,
  s."nameEn" as service,
  s."nameAr",
  s."iconName",
  s."suggestedPriceMin",
  s."suggestedPriceMax",
  s."isPopular"
FROM services s
JOIN categories c ON s."categoryId" = c.id
ORDER BY c."displayOrder", s."displayOrder";
