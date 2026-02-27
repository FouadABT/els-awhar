-- =====================================================
-- SCRIPT 0: CLEANUP - Clear transactional data
-- Run this FIRST to wipe old demo data before reseeding
-- Keeps: users, user_clients, service_categories, services, store_categories, categories
-- =====================================================

BEGIN;

-- Disable triggers temporarily for clean delete
SET session_replication_role = 'replica';

-- Delete in reverse FK dependency order
DELETE FROM store_order_chat_messages;
DELETE FROM store_order_chats;
DELETE FROM store_delivery_requests;
DELETE FROM store_reviews;
DELETE FROM store_order_items;
DELETE FROM store_orders;
DELETE FROM store_products;
DELETE FROM product_categories;
DELETE FROM stores;

DELETE FROM order_status_history;
DELETE FROM reviews;
DELETE FROM ratings;
DELETE FROM orders;
DELETE FROM transactions;
DELETE FROM wallets;

DELETE FROM driver_statistics;
DELETE FROM driver_services;
DELETE FROM driver_profiles;

DELETE FROM addresses;
DELETE FROM cities;
DELETE FROM countries;

-- Reset sequences
ALTER SEQUENCE stores_id_seq RESTART WITH 1;
ALTER SEQUENCE store_products_id_seq RESTART WITH 1;
ALTER SEQUENCE product_categories_id_seq RESTART WITH 1;
ALTER SEQUENCE store_orders_id_seq RESTART WITH 1;
ALTER SEQUENCE store_order_items_id_seq RESTART WITH 1;
ALTER SEQUENCE store_reviews_id_seq RESTART WITH 1;
ALTER SEQUENCE store_delivery_requests_id_seq RESTART WITH 1;
ALTER SEQUENCE store_order_chats_id_seq RESTART WITH 1;
ALTER SEQUENCE store_order_chat_messages_id_seq RESTART WITH 1;
ALTER SEQUENCE orders_id_seq RESTART WITH 1;
ALTER SEQUENCE order_status_history_id_seq RESTART WITH 1;
ALTER SEQUENCE reviews_id_seq RESTART WITH 1;
ALTER SEQUENCE ratings_id_seq RESTART WITH 1;
ALTER SEQUENCE transactions_id_seq RESTART WITH 1;
ALTER SEQUENCE wallets_id_seq RESTART WITH 1;
ALTER SEQUENCE driver_profiles_id_seq RESTART WITH 1;
ALTER SEQUENCE driver_services_id_seq RESTART WITH 1;
ALTER SEQUENCE driver_statistics_id_seq RESTART WITH 1;
ALTER SEQUENCE addresses_id_seq RESTART WITH 1;
ALTER SEQUENCE cities_id_seq RESTART WITH 1;
ALTER SEQUENCE countries_id_seq RESTART WITH 1;

-- Re-enable triggers
SET session_replication_role = 'origin';

COMMIT;

-- Verify cleanup
SELECT 'stores' as tbl, count(*) as cnt FROM stores
UNION ALL SELECT 'store_orders', count(*) FROM store_orders
UNION ALL SELECT 'driver_profiles', count(*) FROM driver_profiles
UNION ALL SELECT 'wallets', count(*) FROM wallets
UNION ALL SELECT 'transactions', count(*) FROM transactions
ORDER BY tbl;
