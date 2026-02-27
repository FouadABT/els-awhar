BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "blocked_users" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "blockedUserId" bigint NOT NULL,
    "reason" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "blocked_user_userId_idx" ON "blocked_users" USING btree ("userId");
CREATE INDEX "blocked_user_blockedUserId_idx" ON "blocked_users" USING btree ("blockedUserId");
CREATE UNIQUE INDEX "blocked_user_unique_idx" ON "blocked_users" USING btree ("userId", "blockedUserId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "store_delivery_requests" DROP CONSTRAINT "store_delivery_requests_fk_2";
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "blocked_users"
    ADD CONSTRAINT "blocked_users_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "blocked_users"
    ADD CONSTRAINT "blocked_users_fk_1"
    FOREIGN KEY("blockedUserId")
    REFERENCES "users"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "store_delivery_requests"
    ADD CONSTRAINT "store_delivery_requests_fk_2"
    FOREIGN KEY("targetDriverId")
    REFERENCES "driver_profiles"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR awhar
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar', '20260121145339905', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260121145339905', "timestamp" = now();

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
