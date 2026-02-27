BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "driver_proposals" (
    "id" bigserial PRIMARY KEY,
    "requestId" bigint NOT NULL,
    "driverId" bigint NOT NULL,
    "proposedPrice" double precision,
    "estimatedArrival" bigint NOT NULL,
    "message" text,
    "driverName" text NOT NULL,
    "driverPhone" text,
    "driverRating" double precision DEFAULT 0.0,
    "driverVehicleInfo" text,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "acceptedAt" timestamp without time zone,
    "rejectedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "proposal_requestId_index" ON "driver_proposals" USING btree ("requestId");
CREATE INDEX "proposal_driverId_index" ON "driver_proposals" USING btree ("driverId");
CREATE INDEX "proposal_status_index" ON "driver_proposals" USING btree ("status");
CREATE INDEX "proposal_requestId_status_index" ON "driver_proposals" USING btree ("requestId", "status");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "users" ADD COLUMN "rating" double precision DEFAULT 0.0;
ALTER TABLE "users" ADD COLUMN "totalRatings" bigint NOT NULL DEFAULT 0;
ALTER TABLE "users" ADD COLUMN "vehicleInfo" text;
ALTER TABLE "users" ADD COLUMN "vehiclePlate" text;

--
-- MIGRATION VERSION FOR awhar_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar_backend', '20260107030409675', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260107030409675', "timestamp" = now();

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
