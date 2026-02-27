BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "service_requests" ADD COLUMN "proposedDriverId" bigint;
ALTER TABLE "service_requests" ADD COLUMN "proposedDriverName" text;
ALTER TABLE "service_requests" ADD COLUMN "proposedDriverPhone" text;

--
-- MIGRATION VERSION FOR awhar_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar_backend', '20260108144254483', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260108144254483', "timestamp" = now();

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
