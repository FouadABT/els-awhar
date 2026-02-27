-- Insert categories into the correct 'categories' table
INSERT INTO categories ("nameEn", "nameAr", "nameFr", "nameEs", "descriptionEn", "iconName", "isActive", "displayOrder", "createdAt", "updatedAt")
VALUES 
('Transportation & Rides', 'النقل والتوصيل', 'Transport & Courses', 'Transporte y Viajes', 'Personal transportation, taxi services, ride-sharing', 'car', true, 1, NOW(), NOW()),
('Delivery Services', 'خدمات التوصيل', 'Services de Livraison', 'Servicios de Entrega', 'Package delivery, document courier, express delivery', 'local_shipping', true, 2, NOW(), NOW()),
('Shopping & Errands', 'التسوق والمهام', 'Shopping & Courses', 'Compras y Recados', 'Grocery shopping, pharmacy runs, personal shopping assistance', 'shopping_cart', true, 3, NOW(), NOW()),
('Moving & Transport', 'النقل والشحن', 'Déménagement & Transport', 'Mudanzas y Transporte', 'Furniture moving, large item transport, relocation services', 'local_shipping', true, 4, NOW(), NOW()),
('Food & Restaurant Delivery', 'توصيل الطعام', 'Livraison de Nourriture', 'Entrega de Comida', 'Restaurant food delivery, meal pickup, catering delivery', 'restaurant', true, 5, NOW(), NOW()),
('Professional Services', 'الخدمات المهنية', 'Services Professionnels', 'Servicios Profesionales', 'Business errands, document services, professional assistance', 'work', true, 6, NOW(), NOW());

-- Verify
SELECT id, "nameEn", "nameAr", "iconName", "displayOrder" FROM categories ORDER BY "displayOrder";
