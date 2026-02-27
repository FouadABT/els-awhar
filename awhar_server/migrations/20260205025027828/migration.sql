BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "device_fingerprint_records" (
    "id" bigserial PRIMARY KEY,
    "fingerprintHash" text NOT NULL,
    "deviceId" text,
    "deviceModel" text,
    "deviceBrand" text,
    "screenWidth" bigint,
    "screenHeight" bigint,
    "screenDensity" double precision,
    "cpuCores" bigint,
    "isPhysicalDevice" boolean,
    "osVersion" text,
    "timezone" text,
    "language" text,
    "appVersion" text,
    "lastIpAddress" text,
    "userIds" text NOT NULL,
    "riskScore" double precision NOT NULL,
    "riskFactors" text,
    "isBlocked" boolean NOT NULL,
    "notes" text,
    "firstSeenAt" timestamp without time zone NOT NULL,
    "lastSeenAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "device_fingerprint_hash_idx" ON "device_fingerprint_records" USING btree ("fingerprintHash");
CREATE INDEX "device_fingerprint_device_id_idx" ON "device_fingerprint_records" USING btree ("deviceId");
CREATE INDEX "device_fingerprint_risk_idx" ON "device_fingerprint_records" USING btree ("riskScore");
CREATE INDEX "device_fingerprint_blocked_idx" ON "device_fingerprint_records" USING btree ("isBlocked");


--
-- MIGRATION VERSION FOR awhar
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar', '20260205025027828', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260205025027828', "timestamp" = now();

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
