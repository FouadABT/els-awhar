BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "service_requests" DROP COLUMN "shoppingList";
ALTER TABLE "service_requests" ADD COLUMN "shoppingList" json;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "stores" ADD COLUMN "whatsappNumber" text;
ALTER TABLE "stores" ADD COLUMN "websiteUrl" text;
ALTER TABLE "stores" ADD COLUMN "facebookUrl" text;
ALTER TABLE "stores" ADD COLUMN "instagramUrl" text;
ALTER TABLE "stores" ADD COLUMN "aboutText" text;
ALTER TABLE "stores" ADD COLUMN "tagline" text;
ALTER TABLE "stores" ADD COLUMN "galleryImages" text;
ALTER TABLE "stores" ADD COLUMN "acceptsCash" boolean NOT NULL DEFAULT true;
ALTER TABLE "stores" ADD COLUMN "acceptsCard" boolean NOT NULL DEFAULT false;
ALTER TABLE "stores" ADD COLUMN "hasDelivery" boolean NOT NULL DEFAULT true;
ALTER TABLE "stores" ADD COLUMN "hasPickup" boolean NOT NULL DEFAULT false;

--
-- MIGRATION VERSION FOR awhar
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar', '20260118144115844', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260118144115844', "timestamp" = now();

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
