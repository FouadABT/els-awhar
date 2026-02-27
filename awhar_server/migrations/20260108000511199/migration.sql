BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ratings" (
    "id" bigserial PRIMARY KEY,
    "requestId" bigint NOT NULL,
    "raterId" bigint NOT NULL,
    "ratedUserId" bigint NOT NULL,
    "ratingValue" bigint NOT NULL,
    "ratingType" text NOT NULL,
    "reviewText" text,
    "quickTags" json,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "rating_requestId_idx" ON "ratings" USING btree ("requestId");
CREATE INDEX "rating_raterId_idx" ON "ratings" USING btree ("raterId");
CREATE INDEX "rating_ratedUserId_idx" ON "ratings" USING btree ("ratedUserId");
CREATE INDEX "rating_ratingType_idx" ON "ratings" USING btree ("ratingType");
CREATE UNIQUE INDEX "rating_request_rater_unique" ON "ratings" USING btree ("requestId", "raterId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "users" ADD COLUMN "totalRatingsAsClient" bigint NOT NULL DEFAULT 0;
ALTER TABLE "users" ADD COLUMN "ratingAsClient" double precision DEFAULT 0.0;

--
-- MIGRATION VERSION FOR awhar_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar_backend', '20260108000511199', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260108000511199', "timestamp" = now();

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
