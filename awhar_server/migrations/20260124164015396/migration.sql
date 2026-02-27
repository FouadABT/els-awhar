BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "countries" (
    "id" bigserial PRIMARY KEY,
    "code" text NOT NULL,
    "name" text NOT NULL,
    "nameAr" text,
    "nameFr" text,
    "currencyCode" text NOT NULL,
    "currencySymbol" text NOT NULL,
    "currencyName" text NOT NULL,
    "currencyNameAr" text,
    "vatRate" double precision NOT NULL DEFAULT 0.0,
    "vatName" text NOT NULL DEFAULT 'VAT'::text,
    "phonePrefix" text,
    "phonePlaceholder" text,
    "defaultLanguage" text NOT NULL DEFAULT 'en'::text,
    "minPrice" double precision NOT NULL DEFAULT 15.0,
    "commissionRate" double precision NOT NULL DEFAULT 0.05,
    "exchangeRateToMAD" double precision NOT NULL DEFAULT 1.0,
    "exchangeRateUpdatedAt" timestamp without time zone,
    "isActive" boolean NOT NULL DEFAULT true,
    "isDefault" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "country_code_idx" ON "countries" USING btree ("code");
CREATE INDEX "country_currencyCode_idx" ON "countries" USING btree ("currencyCode");
CREATE INDEX "country_isActive_idx" ON "countries" USING btree ("isActive");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "orders" ADD COLUMN "currency" text NOT NULL DEFAULT 'MAD'::text;
ALTER TABLE "orders" ADD COLUMN "currencySymbol" text NOT NULL DEFAULT 'DH'::text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "service_requests" ADD COLUMN "currency" text NOT NULL DEFAULT 'MAD'::text;
ALTER TABLE "service_requests" ADD COLUMN "currencySymbol" text NOT NULL DEFAULT 'DH'::text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "store_orders" ADD COLUMN "currency" text NOT NULL DEFAULT 'MAD'::text;
ALTER TABLE "store_orders" ADD COLUMN "currencySymbol" text NOT NULL DEFAULT 'DH'::text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "transactions" ADD COLUMN "currency" text NOT NULL DEFAULT 'MAD'::text;
ALTER TABLE "transactions" ADD COLUMN "currencySymbol" text NOT NULL DEFAULT 'DH'::text;
ALTER TABLE "transactions" ADD COLUMN "baseCurrencyAmount" double precision;
ALTER TABLE "transactions" ADD COLUMN "exchangeRateToBase" double precision NOT NULL DEFAULT 1.0;
ALTER TABLE "transactions" ADD COLUMN "vatRate" double precision NOT NULL DEFAULT 0.0;
ALTER TABLE "transactions" ADD COLUMN "vatAmount" double precision NOT NULL DEFAULT 0.0;

--
-- MIGRATION VERSION FOR awhar
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar', '20260124164015396', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260124164015396', "timestamp" = now();

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
