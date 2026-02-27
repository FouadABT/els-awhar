-- Insert into service_categories table (matches ServiceCategory protocol)
INSERT INTO service_categories (name, "nameAr", "nameFr", "nameEs", icon, description, "displayOrder", "isActive", "defaultRadiusKm", "createdAt", "updatedAt")
VALUES
('Transportation & Rides', 'النقل والتوصيل', 'Transport & Courses', 'Transporte y Viajes', 'car', 'Personal transportation, taxi services, ride-sharing', 1, true, 15.0, NOW(), NOW()),
('Delivery Services', 'خدمات التوصيل', 'Services de Livraison', 'Servicios de Entrega', 'local_shipping', 'Package delivery, document courier, express delivery', 2, true, 20.0, NOW(), NOW()),
('Shopping & Errands', 'التسوق والمهام', 'Shopping & Courses', 'Compras y Recados', 'shopping_cart', 'Grocery shopping, pharmacy runs, personal shopping assistance', 3, true, 10.0, NOW(), NOW()),
('Moving & Transport', 'النقل والشحن', 'Déménagement & Transport', 'Mudanzas y Transporte', 'local_shipping', 'Furniture moving, large item transport, relocation services', 4, true, 25.0, NOW(), NOW()),
('Food & Restaurant Delivery', 'توصيل الطعام', 'Livraison de Nourriture', 'Entrega de Comida', 'restaurant', 'Restaurant food delivery, meal pickup, catering delivery', 5, true, 10.0, NOW(), NOW()),
('Professional Services', 'الخدمات المهنية', 'Services Professionnels', 'Servicios Profesionales', 'work', 'Business errands, document services, professional assistance', 6, true, 15.0, NOW(), NOW());

-- Verify
SELECT id, name, "nameAr", icon, "displayOrder" FROM service_categories ORDER BY "displayOrder";
