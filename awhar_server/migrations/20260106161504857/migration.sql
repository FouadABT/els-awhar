BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "service_requests" (
    "id" bigserial PRIMARY KEY,
    "clientId" bigint NOT NULL,
    "driverId" bigint,
    "serviceType" text NOT NULL,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "pickupLocation" json NOT NULL,
    "destinationLocation" json NOT NULL,
    "basePrice" double precision NOT NULL,
    "distancePrice" double precision NOT NULL,
    "totalPrice" double precision NOT NULL,
    "distance" double precision NOT NULL,
    "estimatedDuration" bigint NOT NULL,
    "notes" text,
    "clientName" text NOT NULL,
    "clientPhone" text,
    "driverName" text,
    "driverPhone" text,
    "cancelledBy" bigint,
    "cancellationReason" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "acceptedAt" timestamp without time zone,
    "driverArrivingAt" timestamp without time zone,
    "startedAt" timestamp without time zone,
    "completedAt" timestamp without time zone,
    "cancelledAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "clientId_index" ON "service_requests" USING btree ("clientId");
CREATE INDEX "driverId_index" ON "service_requests" USING btree ("driverId");
CREATE INDEX "status_index" ON "service_requests" USING btree ("status");
CREATE INDEX "createdAt_index" ON "service_requests" USING btree ("createdAt");


--
-- MIGRATION VERSION FOR awhar_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar_backend', '20260106161504857', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260106161504857', "timestamp" = now();

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
