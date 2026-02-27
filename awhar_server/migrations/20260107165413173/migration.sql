BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "transactions" ADD COLUMN "driverConfirmed" boolean NOT NULL DEFAULT false;
ALTER TABLE "transactions" ADD COLUMN "clientConfirmed" boolean NOT NULL DEFAULT false;
ALTER TABLE "transactions" ADD COLUMN "driverConfirmedAt" timestamp without time zone;
ALTER TABLE "transactions" ADD COLUMN "clientConfirmedAt" timestamp without time zone;

--
-- MIGRATION VERSION FOR awhar_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar_backend', '20260107165413173', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260107165413173', "timestamp" = now();

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
