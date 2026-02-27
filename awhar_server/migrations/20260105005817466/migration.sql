BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chat_messages" (
    "id" bigserial PRIMARY KEY,
    "orderId" bigint NOT NULL,
    "senderId" bigint NOT NULL,
    "receiverId" bigint NOT NULL,
    "message" text NOT NULL,
    "messageType" bigint,
    "attachmentUrl" text,
    "isRead" boolean NOT NULL DEFAULT false,
    "readAt" timestamp without time zone,
    "firebaseId" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "chat_message_orderId_idx" ON "chat_messages" USING btree ("orderId");
CREATE INDEX "chat_message_senderId_idx" ON "chat_messages" USING btree ("senderId");
CREATE INDEX "chat_message_receiverId_idx" ON "chat_messages" USING btree ("receiverId");
CREATE UNIQUE INDEX "chat_message_firebaseId_idx" ON "chat_messages" USING btree ("firebaseId");
CREATE INDEX "chat_message_createdAt_idx" ON "chat_messages" USING btree ("createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "client_reviews" (
    "id" bigserial PRIMARY KEY,
    "orderId" bigint NOT NULL,
    "driverId" bigint NOT NULL,
    "clientId" bigint NOT NULL,
    "rating" bigint NOT NULL,
    "comment" text,
    "communicationRating" bigint,
    "respectRating" bigint,
    "paymentPromptness" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "client_review_orderId_idx" ON "client_reviews" USING btree ("orderId");
CREATE INDEX "client_review_driverId_idx" ON "client_reviews" USING btree ("driverId");
CREATE INDEX "client_review_clientId_idx" ON "client_reviews" USING btree ("clientId");
CREATE INDEX "client_review_createdAt_idx" ON "client_reviews" USING btree ("createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "driver_offers" (
    "id" bigserial PRIMARY KEY,
    "orderId" bigint NOT NULL,
    "driverId" bigint NOT NULL,
    "offeredPrice" double precision NOT NULL,
    "message" text,
    "status" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "respondedAt" timestamp without time zone,
    "expiresAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "driver_offer_orderId_idx" ON "driver_offers" USING btree ("orderId");
CREATE INDEX "driver_offer_driverId_idx" ON "driver_offers" USING btree ("driverId");
CREATE INDEX "driver_offer_status_idx" ON "driver_offers" USING btree ("status");
CREATE INDEX "driver_offer_createdAt_idx" ON "driver_offers" USING btree ("createdAt");
CREATE UNIQUE INDEX "driver_offer_order_driver_unique" ON "driver_offers" USING btree ("orderId", "driverId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "driver_profiles" ADD COLUMN "isOnline" boolean NOT NULL DEFAULT false;
ALTER TABLE "driver_profiles" ADD COLUMN "lastLocationLat" double precision;
ALTER TABLE "driver_profiles" ADD COLUMN "lastLocationLng" double precision;
ALTER TABLE "driver_profiles" ADD COLUMN "lastLocationUpdatedAt" timestamp without time zone;
ALTER TABLE "driver_profiles" ADD COLUMN "autoOfflineAt" timestamp without time zone;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "driver_services" ADD COLUMN "categoryId" bigint;
ALTER TABLE "driver_services" ADD COLUMN "imageUrl" text;
ALTER TABLE "driver_services" ADD COLUMN "description" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "orders" ADD COLUMN "clientProposedPrice" double precision;
ALTER TABLE "orders" ADD COLUMN "driverCounterPrice" double precision;
ALTER TABLE "orders" ADD COLUMN "priceNegotiationStatus" bigint;
ALTER TABLE "orders" ADD COLUMN "expiresAt" timestamp without time zone;
ALTER TABLE "orders" ADD COLUMN "cancelledBy" bigint;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "reports" ADD COLUMN "reporterType" bigint;
ALTER TABLE "reports" ADD COLUMN "reportedType" bigint;
ALTER TABLE "reports" ADD COLUMN "resolution" bigint;
ALTER TABLE "reports" ADD COLUMN "adminNotes" text;
ALTER TABLE "reports" ADD COLUMN "resolvedAt" timestamp without time zone;
ALTER TABLE "reports" ADD COLUMN "resolvedBy" bigint;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "service_categories" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "nameAr" text NOT NULL,
    "nameFr" text NOT NULL,
    "nameEs" text,
    "icon" text NOT NULL,
    "description" text,
    "displayOrder" bigint NOT NULL DEFAULT 0,
    "isActive" boolean NOT NULL DEFAULT true,
    "defaultRadiusKm" double precision NOT NULL DEFAULT 10.0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "service_category_name_idx" ON "service_categories" USING btree ("name");
CREATE INDEX "service_category_isActive_idx" ON "service_categories" USING btree ("isActive");
CREATE INDEX "service_category_displayOrder_idx" ON "service_categories" USING btree ("displayOrder");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "users" ADD COLUMN "isSuspended" boolean NOT NULL DEFAULT false;
ALTER TABLE "users" ADD COLUMN "suspendedUntil" timestamp without time zone;
ALTER TABLE "users" ADD COLUMN "suspensionReason" text;
ALTER TABLE "users" ADD COLUMN "totalReportsReceived" bigint NOT NULL DEFAULT 0;
ALTER TABLE "users" ADD COLUMN "totalReportsMade" bigint NOT NULL DEFAULT 0;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "chat_messages"
    ADD CONSTRAINT "chat_messages_fk_0"
    FOREIGN KEY("orderId")
    REFERENCES "orders"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "chat_messages"
    ADD CONSTRAINT "chat_messages_fk_1"
    FOREIGN KEY("senderId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "chat_messages"
    ADD CONSTRAINT "chat_messages_fk_2"
    FOREIGN KEY("receiverId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "client_reviews"
    ADD CONSTRAINT "client_reviews_fk_0"
    FOREIGN KEY("orderId")
    REFERENCES "orders"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "client_reviews"
    ADD CONSTRAINT "client_reviews_fk_1"
    FOREIGN KEY("driverId")
    REFERENCES "driver_profiles"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "client_reviews"
    ADD CONSTRAINT "client_reviews_fk_2"
    FOREIGN KEY("clientId")
    REFERENCES "user_clients"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "driver_offers"
    ADD CONSTRAINT "driver_offers_fk_0"
    FOREIGN KEY("orderId")
    REFERENCES "orders"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "driver_offers"
    ADD CONSTRAINT "driver_offers_fk_1"
    FOREIGN KEY("driverId")
    REFERENCES "driver_profiles"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "driver_services"
    ADD CONSTRAINT "driver_services_fk_2"
    FOREIGN KEY("categoryId")
    REFERENCES "service_categories"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "reports"
    ADD CONSTRAINT "reports_fk_5"
    FOREIGN KEY("resolvedBy")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR awhar_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar_backend', '20260105005817466', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260105005817466', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20251208110420531-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110420531-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20251208110412389-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110412389-v3-0-0', "timestamp" = now();


COMMIT;
