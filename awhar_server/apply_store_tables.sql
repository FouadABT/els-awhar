-- Create store-related tables for Phase 1 implementation
-- Run with: Get-Content apply_store_tables.sql | docker exec -i awhar_server-postgres-1 psql -U postgres -d awhar_backend

BEGIN;

-- Create store_categories table
CREATE TABLE IF NOT EXISTS "store_categories" (
    "id" bigserial PRIMARY KEY,
    "nameEn" text NOT NULL,
    "nameAr" text,
    "nameFr" text,
    "nameEs" text,
    "descriptionEn" text,
    "descriptionAr" text,
    "descriptionFr" text,
    "descriptionEs" text,
    "iconName" text NOT NULL,
    "iconUrl" text,
    "imageUrl" text,
    "colorHex" text,
    "isActive" boolean NOT NULL DEFAULT true,
    "displayOrder" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS "store_cat_isActive_idx" ON "store_categories" USING btree ("isActive");
CREATE INDEX IF NOT EXISTS "store_cat_displayOrder_idx" ON "store_categories" USING btree ("displayOrder");

-- Create stores table
CREATE TABLE IF NOT EXISTS "stores" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "storeCategoryId" bigint NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "phone" text NOT NULL,
    "email" text,
    "logoUrl" text,
    "coverImageUrl" text,
    "address" text NOT NULL,
    "latitude" double precision NOT NULL,
    "longitude" double precision NOT NULL,
    "city" text,
    "deliveryRadiusKm" double precision NOT NULL DEFAULT 5.0,
    "minimumOrderAmount" double precision DEFAULT 0.0,
    "estimatedPrepTimeMinutes" bigint NOT NULL DEFAULT 30,
    "workingHours" text,
    "isActive" boolean NOT NULL DEFAULT true,
    "isOpen" boolean NOT NULL DEFAULT false,
    "totalOrders" bigint NOT NULL DEFAULT 0,
    "rating" double precision NOT NULL DEFAULT 0.0,
    "totalRatings" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX IF NOT EXISTS "store_userId_idx" ON "stores" USING btree ("userId");
CREATE INDEX IF NOT EXISTS "store_categoryId_idx" ON "stores" USING btree ("storeCategoryId");
CREATE INDEX IF NOT EXISTS "store_isActive_idx" ON "stores" USING btree ("isActive");
CREATE INDEX IF NOT EXISTS "store_isOpen_idx" ON "stores" USING btree ("isOpen");
CREATE INDEX IF NOT EXISTS "store_location_idx" ON "stores" USING btree ("latitude", "longitude");

-- Create product_categories table
CREATE TABLE IF NOT EXISTS "product_categories" (
    "id" bigserial PRIMARY KEY,
    "storeId" bigint NOT NULL,
    "name" text NOT NULL,
    "imageUrl" text,
    "isActive" boolean NOT NULL DEFAULT true,
    "displayOrder" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS "prod_cat_storeId_idx" ON "product_categories" USING btree ("storeId");
CREATE INDEX IF NOT EXISTS "prod_cat_displayOrder_idx" ON "product_categories" USING btree ("storeId", "displayOrder");

-- Create store_products table
CREATE TABLE IF NOT EXISTS "store_products" (
    "id" bigserial PRIMARY KEY,
    "storeId" bigint NOT NULL,
    "productCategoryId" bigint,
    "name" text NOT NULL,
    "description" text,
    "price" double precision NOT NULL,
    "imageUrl" text,
    "isAvailable" boolean NOT NULL DEFAULT true,
    "displayOrder" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS "store_prod_storeId_idx" ON "store_products" USING btree ("storeId");
CREATE INDEX IF NOT EXISTS "store_prod_categoryId_idx" ON "store_products" USING btree ("productCategoryId");
CREATE INDEX IF NOT EXISTS "store_prod_isAvailable_idx" ON "store_products" USING btree ("storeId", "isAvailable");
CREATE INDEX IF NOT EXISTS "store_prod_displayOrder_idx" ON "store_products" USING btree ("storeId", "displayOrder");

-- Create store_orders table
CREATE TABLE IF NOT EXISTS "store_orders" (
    "id" bigserial PRIMARY KEY,
    "orderNumber" text NOT NULL,
    "storeId" bigint NOT NULL,
    "clientId" bigint NOT NULL,
    "driverId" bigint,
    "status" bigint NOT NULL,
    "itemsJson" text NOT NULL,
    "subtotal" double precision NOT NULL,
    "deliveryFee" double precision NOT NULL,
    "total" double precision NOT NULL,
    "platformCommission" double precision NOT NULL DEFAULT 0.0,
    "driverEarnings" double precision NOT NULL DEFAULT 0.0,
    "deliveryAddress" text NOT NULL,
    "deliveryLatitude" double precision NOT NULL,
    "deliveryLongitude" double precision NOT NULL,
    "deliveryDistance" double precision,
    "clientNotes" text,
    "storeNotes" text,
    "timelineJson" text,
    "chatChannelId" text,
    "cancelledBy" text,
    "cancellationReason" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "confirmedAt" timestamp without time zone,
    "readyAt" timestamp without time zone,
    "pickedUpAt" timestamp without time zone,
    "deliveredAt" timestamp without time zone,
    "cancelledAt" timestamp without time zone
);

CREATE UNIQUE INDEX IF NOT EXISTS "store_order_number_idx" ON "store_orders" USING btree ("orderNumber");
CREATE INDEX IF NOT EXISTS "store_order_storeId_idx" ON "store_orders" USING btree ("storeId");
CREATE INDEX IF NOT EXISTS "store_order_clientId_idx" ON "store_orders" USING btree ("clientId");
CREATE INDEX IF NOT EXISTS "store_order_driverId_idx" ON "store_orders" USING btree ("driverId");
CREATE INDEX IF NOT EXISTS "store_order_status_idx" ON "store_orders" USING btree ("status");
CREATE INDEX IF NOT EXISTS "store_order_createdAt_idx" ON "store_orders" USING btree ("createdAt");

-- Create store_order_items table
CREATE TABLE IF NOT EXISTS "store_order_items" (
    "id" bigserial PRIMARY KEY,
    "storeOrderId" bigint NOT NULL,
    "productId" bigint,
    "productName" text NOT NULL,
    "productPrice" double precision NOT NULL,
    "productImageUrl" text,
    "quantity" bigint NOT NULL,
    "itemTotal" double precision NOT NULL,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS "store_order_item_orderId_idx" ON "store_order_items" USING btree ("storeOrderId");

-- Create store_delivery_requests table
CREATE TABLE IF NOT EXISTS "store_delivery_requests" (
    "id" bigserial PRIMARY KEY,
    "storeOrderId" bigint NOT NULL,
    "storeId" bigint NOT NULL,
    "requestType" text NOT NULL,
    "targetDriverId" bigint,
    "pickupAddress" text NOT NULL,
    "pickupLatitude" double precision NOT NULL,
    "pickupLongitude" double precision NOT NULL,
    "deliveryAddress" text NOT NULL,
    "deliveryLatitude" double precision NOT NULL,
    "deliveryLongitude" double precision NOT NULL,
    "distanceKm" double precision,
    "deliveryFee" double precision NOT NULL,
    "driverEarnings" double precision NOT NULL,
    "status" text NOT NULL DEFAULT 'pending',
    "assignedDriverId" bigint,
    "expiresAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "acceptedAt" timestamp without time zone,
    "rejectedAt" timestamp without time zone
);

CREATE UNIQUE INDEX IF NOT EXISTS "store_del_req_orderId_idx" ON "store_delivery_requests" USING btree ("storeOrderId");
CREATE INDEX IF NOT EXISTS "store_del_req_storeId_idx" ON "store_delivery_requests" USING btree ("storeId");
CREATE INDEX IF NOT EXISTS "store_del_req_status_idx" ON "store_delivery_requests" USING btree ("status");
CREATE INDEX IF NOT EXISTS "store_del_req_targetDriverId_idx" ON "store_delivery_requests" USING btree ("targetDriverId");
CREATE INDEX IF NOT EXISTS "store_del_req_location_idx" ON "store_delivery_requests" USING btree ("pickupLatitude", "pickupLongitude");

-- Create store_reviews table
CREATE TABLE IF NOT EXISTS "store_reviews" (
    "id" bigserial PRIMARY KEY,
    "storeOrderId" bigint NOT NULL,
    "reviewerId" bigint NOT NULL,
    "revieweeType" text NOT NULL,
    "revieweeId" bigint NOT NULL,
    "rating" bigint NOT NULL,
    "comment" text,
    "response" text,
    "responseAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS "store_review_orderId_idx" ON "store_reviews" USING btree ("storeOrderId");
CREATE INDEX IF NOT EXISTS "store_review_reviewerId_idx" ON "store_reviews" USING btree ("reviewerId");
CREATE INDEX IF NOT EXISTS "store_review_revieweeType_idx" ON "store_reviews" USING btree ("revieweeType", "revieweeId");
CREATE UNIQUE INDEX IF NOT EXISTS "store_review_unique_idx" ON "store_reviews" USING btree ("storeOrderId", "reviewerId", "revieweeType");

-- Create store_reports table
CREATE TABLE IF NOT EXISTS "store_reports" (
    "id" bigserial PRIMARY KEY,
    "storeOrderId" bigint,
    "reporterId" bigint NOT NULL,
    "reporterType" text NOT NULL,
    "reportedType" text NOT NULL,
    "reportedId" bigint NOT NULL,
    "reason" text NOT NULL,
    "description" text NOT NULL,
    "evidenceUrls" text,
    "status" text NOT NULL DEFAULT 'pending',
    "resolution" text,
    "resolvedBy" bigint,
    "resolvedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS "store_report_orderId_idx" ON "store_reports" USING btree ("storeOrderId");
CREATE INDEX IF NOT EXISTS "store_report_reporterId_idx" ON "store_reports" USING btree ("reporterId");
CREATE INDEX IF NOT EXISTS "store_report_reportedType_idx" ON "store_reports" USING btree ("reportedType", "reportedId");
CREATE INDEX IF NOT EXISTS "store_report_status_idx" ON "store_reports" USING btree ("status");

-- Add foreign keys
ALTER TABLE "stores" ADD CONSTRAINT "stores_fk_0" FOREIGN KEY("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "stores" ADD CONSTRAINT "stores_fk_1" FOREIGN KEY("storeCategoryId") REFERENCES "store_categories"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "product_categories" ADD CONSTRAINT "product_categories_fk_0" FOREIGN KEY("storeId") REFERENCES "stores"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE "store_products" ADD CONSTRAINT "store_products_fk_0" FOREIGN KEY("storeId") REFERENCES "stores"("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "store_products" ADD CONSTRAINT "store_products_fk_1" FOREIGN KEY("productCategoryId") REFERENCES "product_categories"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

ALTER TABLE "store_orders" ADD CONSTRAINT "store_orders_fk_0" FOREIGN KEY("storeId") REFERENCES "stores"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "store_orders" ADD CONSTRAINT "store_orders_fk_1" FOREIGN KEY("clientId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "store_orders" ADD CONSTRAINT "store_orders_fk_2" FOREIGN KEY("driverId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "store_order_items" ADD CONSTRAINT "store_order_items_fk_0" FOREIGN KEY("storeOrderId") REFERENCES "store_orders"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE "store_delivery_requests" ADD CONSTRAINT "store_delivery_requests_fk_0" FOREIGN KEY("storeOrderId") REFERENCES "store_orders"("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "store_delivery_requests" ADD CONSTRAINT "store_delivery_requests_fk_1" FOREIGN KEY("storeId") REFERENCES "stores"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "store_delivery_requests" ADD CONSTRAINT "store_delivery_requests_fk_2" FOREIGN KEY("targetDriverId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "store_delivery_requests" ADD CONSTRAINT "store_delivery_requests_fk_3" FOREIGN KEY("assignedDriverId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "store_reviews" ADD CONSTRAINT "store_reviews_fk_0" FOREIGN KEY("storeOrderId") REFERENCES "store_orders"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "store_reviews" ADD CONSTRAINT "store_reviews_fk_1" FOREIGN KEY("reviewerId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "store_reports" ADD CONSTRAINT "store_reports_fk_0" FOREIGN KEY("storeOrderId") REFERENCES "store_orders"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "store_reports" ADD CONSTRAINT "store_reports_fk_1" FOREIGN KEY("reporterId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Update migration version
UPDATE "serverpod_migrations" 
SET "version" = '20260117004440900', "timestamp" = now() 
WHERE "module" = 'awhar_backend';

COMMIT;

-- Verify tables created
SELECT table_name FROM information_schema.tables 
WHERE table_schema = 'public' AND table_name LIKE 'store%' 
ORDER BY table_name;
