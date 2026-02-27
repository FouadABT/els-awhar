-- Seed initial store categories
-- Run with: Get-Content seed_store_categories.sql | docker exec -i awhar_server-postgres-1 psql -U postgres -d awhar_backend

INSERT INTO "store_categories" (
    "nameEn", "nameAr", "nameFr", "nameEs",
    "descriptionEn", "descriptionAr", "descriptionFr", "descriptionEs",
    "iconName", "colorHex", "displayOrder", "isActive"
) VALUES 
-- Restaurant
(
    'Restaurant', 'مطعم', 'Restaurant', 'Restaurante',
    'Restaurants and food establishments', 'المطاعم ومؤسسات الطعام', 'Restaurants et établissements alimentaires', 'Restaurantes y establecimientos de comida',
    'restaurant', '#FF6B35', 1, true
),
-- Fast Food
(
    'Fast Food', 'وجبات سريعة', 'Restauration Rapide', 'Comida Rápida',
    'Quick service restaurants and fast food chains', 'مطاعم الخدمة السريعة وسلاسل الوجبات السريعة', 'Restaurants de service rapide et chaînes de restauration rapide', 'Restaurantes de servicio rápido y cadenas de comida rápida',
    'fastfood', '#FFA500', 2, true
),
-- Cafe & Bakery
(
    'Cafe & Bakery', 'مقهى ومخبز', 'Café et Boulangerie', 'Cafetería y Panadería',
    'Coffee shops, cafes, and bakeries', 'المقاهي والمخابز', 'Cafés et boulangeries', 'Cafeterías y panaderías',
    'coffee', '#8B4513', 3, true
),
-- Supermarket
(
    'Supermarket', 'سوبر ماركت', 'Supermarché', 'Supermercado',
    'Grocery stores and supermarkets', 'محلات البقالة والسوبر ماركت', 'Épiceries et supermarchés', 'Tiendas de comestibles y supermercados',
    'shopping_cart', '#4CAF50', 4, true
),
-- Pharmacy
(
    'Pharmacy', 'صيدلية', 'Pharmacie', 'Farmacia',
    'Pharmacies and drugstores', 'الصيدليات ومحلات الأدوية', 'Pharmacies et drogueries', 'Farmacias y droguerías',
    'medical_services', '#E91E63', 5, true
),
-- Electronics
(
    'Electronics', 'إلكترونيات', 'Électronique', 'Electrónica',
    'Electronics and gadget stores', 'متاجر الإلكترونيات والأجهزة', 'Magasins d''électronique et de gadgets', 'Tiendas de electrónica y gadgets',
    'devices', '#2196F3', 6, true
),
-- Flowers & Gifts
(
    'Flowers & Gifts', 'زهور وهدايا', 'Fleurs et Cadeaux', 'Flores y Regalos',
    'Flower shops and gift stores', 'محلات الزهور والهدايا', 'Boutiques de fleurs et de cadeaux', 'Floristerías y tiendas de regalos',
    'local_florist', '#9C27B0', 7, true
),
-- Pet Supplies
(
    'Pet Supplies', 'مستلزمات الحيوانات', 'Animalerie', 'Suministros para Mascotas',
    'Pet food and supplies stores', 'متاجر طعام ومستلزمات الحيوانات الأليفة', 'Magasins d''alimentation et de fournitures pour animaux', 'Tiendas de comida y suministros para mascotas',
    'pets', '#795548', 8, true
),
-- Books & Stationery
(
    'Books & Stationery', 'كتب وقرطاسية', 'Livres et Papeterie', 'Libros y Papelería',
    'Bookstores and stationery shops', 'المكتبات ومحلات القرطاسية', 'Librairies et papeteries', 'Librerías y papelerías',
    'menu_book', '#3F51B5', 9, true
),
-- Other
(
    'Other', 'أخرى', 'Autre', 'Otro',
    'Other types of stores and businesses', 'أنواع أخرى من المتاجر والأعمال', 'Autres types de magasins et d''entreprises', 'Otros tipos de tiendas y negocios',
    'store', '#607D8B', 10, true
)
ON CONFLICT DO NOTHING;

-- Verify
SELECT id, "nameEn", "iconName", "colorHex" FROM "store_categories" ORDER BY "displayOrder";
