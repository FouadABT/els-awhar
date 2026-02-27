BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "admin_users" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "admin_users" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint,
    "email" text NOT NULL,
    "passwordHash" text NOT NULL,
    "name" text NOT NULL,
    "photoUrl" text,
    "role" text NOT NULL DEFAULT 'admin'::text,
    "permissions" json,
    "isActive" boolean NOT NULL DEFAULT true,
    "lastLoginAt" timestamp without time zone,
    "lastLoginIp" text,
    "failedLoginAttempts" bigint NOT NULL DEFAULT 0,
    "lockedUntil" timestamp without time zone,
    "passwordResetToken" text,
    "passwordResetExpiry" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" bigint
);

-- Indexes
CREATE UNIQUE INDEX "admin_email_idx" ON "admin_users" USING btree ("email");
CREATE INDEX "admin_userId_idx" ON "admin_users" USING btree ("userId");
CREATE INDEX "admin_role_idx" ON "admin_users" USING btree ("role");
CREATE INDEX "admin_isActive_idx" ON "admin_users" USING btree ("isActive");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "admin_users"
    ADD CONSTRAINT "admin_users_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR awhar
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar', '20260123025519113', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260123025519113', "timestamp" = now();

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
