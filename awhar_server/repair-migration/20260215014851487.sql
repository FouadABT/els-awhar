BEGIN;

--
-- ACTION ALTER TABLE
--
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "admin_actions"
    ADD CONSTRAINT "admin_actions_fk_0"
    FOREIGN KEY("adminUserId")
    REFERENCES "admin_users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR awhar
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar', '20260215014358978', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260215014358978', "timestamp" = now();

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

--
-- MIGRATION VERSION FOR _repair
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('_repair', '20260215014851487', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260215014851487', "timestamp" = now();


COMMIT;
