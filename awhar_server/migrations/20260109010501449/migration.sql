BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "service_requests" ADD COLUMN "estimatedPurchaseCost" double precision;
ALTER TABLE "service_requests" ADD COLUMN "deliveryFee" double precision;
ALTER TABLE "service_requests" ADD COLUMN "isPurchaseRequired" boolean NOT NULL DEFAULT false;
ALTER TABLE "service_requests" ADD COLUMN "shoppingList" json;
ALTER TABLE "service_requests" ADD COLUMN "attachments" json;
ALTER TABLE "service_requests" ALTER COLUMN "pickupLocation" DROP NOT NULL;
ALTER TABLE "service_requests" ALTER COLUMN "distance" DROP NOT NULL;
ALTER TABLE "service_requests" ALTER COLUMN "estimatedDuration" DROP NOT NULL;

--
-- MIGRATION VERSION FOR awhar_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar_backend', '20260109010501449', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260109010501449', "timestamp" = now();

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
