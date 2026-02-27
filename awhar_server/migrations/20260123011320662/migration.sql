BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "promos" (
    "id" bigserial PRIMARY KEY,
    "titleEn" text NOT NULL,
    "titleAr" text,
    "titleFr" text,
    "titleEs" text,
    "descriptionEn" text,
    "descriptionAr" text,
    "descriptionFr" text,
    "descriptionEs" text,
    "imageUrl" text NOT NULL,
    "targetRoles" text NOT NULL,
    "actionType" text NOT NULL DEFAULT 'none'::text,
    "actionValue" text,
    "priority" bigint NOT NULL DEFAULT 0,
    "isActive" boolean NOT NULL DEFAULT true,
    "startDate" timestamp without time zone,
    "endDate" timestamp without time zone,
    "viewCount" bigint NOT NULL DEFAULT 0,
    "clickCount" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone,
    "createdBy" bigint
);

-- Indexes
CREATE INDEX "promo_active_idx" ON "promos" USING btree ("isActive");
CREATE INDEX "promo_dates_idx" ON "promos" USING btree ("startDate", "endDate");
CREATE INDEX "promo_priority_idx" ON "promos" USING btree ("priority");


--
-- MIGRATION VERSION FOR awhar
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar', '20260123011320662', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260123011320662', "timestamp" = now();

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
