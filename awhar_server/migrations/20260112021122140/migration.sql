BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "media_metadata" (
    "id" bigserial PRIMARY KEY,
    "messageId" text NOT NULL,
    "userId" bigint NOT NULL,
    "requestId" bigint NOT NULL,
    "mediaUrl" text NOT NULL,
    "mediaType" text NOT NULL,
    "fileName" text NOT NULL,
    "fileSizeBytes" bigint NOT NULL,
    "durationMs" bigint,
    "thumbnailUrl" text,
    "downloadCount" bigint NOT NULL DEFAULT 0,
    "lastAccessedAt" timestamp without time zone,
    "uploadedAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "media_metadata"
    ADD CONSTRAINT "media_metadata_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "media_metadata"
    ADD CONSTRAINT "media_metadata_fk_1"
    FOREIGN KEY("requestId")
    REFERENCES "service_requests"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR awhar_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar_backend', '20260112021122140', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260112021122140', "timestamp" = now();

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
