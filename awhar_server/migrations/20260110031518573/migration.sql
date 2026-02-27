BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "driver_services" ADD COLUMN "title" text;
ALTER TABLE "driver_services" ADD COLUMN "viewCount" bigint NOT NULL DEFAULT 0;
ALTER TABLE "driver_services" ADD COLUMN "inquiryCount" bigint NOT NULL DEFAULT 0;
ALTER TABLE "driver_services" ADD COLUMN "bookingCount" bigint NOT NULL DEFAULT 0;
ALTER TABLE "driver_services" ADD COLUMN "isAvailable" boolean NOT NULL DEFAULT true;
ALTER TABLE "driver_services" ADD COLUMN "availableFrom" timestamp without time zone;
ALTER TABLE "driver_services" ADD COLUMN "availableUntil" timestamp without time zone;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "service_analytics" (
    "id" bigserial PRIMARY KEY,
    "driverServiceId" bigint NOT NULL,
    "totalViews" bigint NOT NULL DEFAULT 0,
    "uniqueViews" bigint NOT NULL DEFAULT 0,
    "lastViewedAt" timestamp without time zone,
    "totalInquiries" bigint NOT NULL DEFAULT 0,
    "totalBookings" bigint NOT NULL DEFAULT 0,
    "conversionRate" double precision NOT NULL DEFAULT 0.0,
    "averageResponseTime" bigint NOT NULL DEFAULT 0,
    "completionRate" double precision NOT NULL DEFAULT 0.0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "svc_analytics_driverServiceId_idx" ON "service_analytics" USING btree ("driverServiceId");
CREATE INDEX "svc_analytics_totalViews_idx" ON "service_analytics" USING btree ("totalViews");
CREATE INDEX "svc_analytics_totalBookings_idx" ON "service_analytics" USING btree ("totalBookings");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "service_images" (
    "id" bigserial PRIMARY KEY,
    "driverServiceId" bigint NOT NULL,
    "imageUrl" text NOT NULL,
    "thumbnailUrl" text,
    "displayOrder" bigint NOT NULL DEFAULT 0,
    "caption" text,
    "fileSize" bigint,
    "width" bigint,
    "height" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "svc_img_driverServiceId_idx" ON "service_images" USING btree ("driverServiceId");
CREATE INDEX "svc_img_displayOrder_idx" ON "service_images" USING btree ("driverServiceId", "displayOrder");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "service_analytics"
    ADD CONSTRAINT "service_analytics_fk_0"
    FOREIGN KEY("driverServiceId")
    REFERENCES "driver_services"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "service_images"
    ADD CONSTRAINT "service_images_fk_0"
    FOREIGN KEY("driverServiceId")
    REFERENCES "driver_services"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR awhar_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar_backend', '20260110031518573', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260110031518573', "timestamp" = now();

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
