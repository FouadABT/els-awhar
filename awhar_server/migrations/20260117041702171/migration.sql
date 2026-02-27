BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_notifications" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "title" text NOT NULL,
    "body" text NOT NULL,
    "type" text NOT NULL,
    "relatedEntityId" bigint,
    "relatedEntityType" text,
    "dataJson" text,
    "isRead" boolean NOT NULL DEFAULT false,
    "readAt" timestamp without time zone
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_notifications"
    ADD CONSTRAINT "user_notifications_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR awhar
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar', '20260117041702171', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260117041702171', "timestamp" = now();

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
