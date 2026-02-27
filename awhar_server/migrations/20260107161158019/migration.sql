BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "service_requests" ADD COLUMN "agreedPrice" double precision;
ALTER TABLE "service_requests" ADD COLUMN "isPaid" boolean NOT NULL DEFAULT false;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "transactions" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "requestId" bigint,
    "amount" double precision NOT NULL,
    "type" text NOT NULL,
    "status" text NOT NULL DEFAULT 'completed'::text,
    "paymentMethod" text NOT NULL DEFAULT 'cash'::text,
    "description" text,
    "notes" text,
    "platformCommission" double precision NOT NULL DEFAULT 0.0,
    "driverEarnings" double precision NOT NULL DEFAULT 0.0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" timestamp without time zone,
    "refundedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "transaction_userId_index" ON "transactions" USING btree ("userId");
CREATE INDEX "transaction_requestId_index" ON "transactions" USING btree ("requestId");
CREATE INDEX "transaction_type_index" ON "transactions" USING btree ("type");
CREATE INDEX "transaction_status_index" ON "transactions" USING btree ("status");
CREATE INDEX "transaction_createdAt_index" ON "transactions" USING btree ("createdAt");
CREATE INDEX "transaction_userId_createdAt_index" ON "transactions" USING btree ("userId", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "wallets" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "totalEarned" double precision NOT NULL DEFAULT 0.0,
    "totalSpent" double precision NOT NULL DEFAULT 0.0,
    "pendingEarnings" double precision NOT NULL DEFAULT 0.0,
    "totalTransactions" bigint NOT NULL DEFAULT 0,
    "completedRides" bigint NOT NULL DEFAULT 0,
    "totalCommissionPaid" double precision NOT NULL DEFAULT 0.0,
    "currency" text NOT NULL DEFAULT 'MAD'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastTransactionAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "wallet_userId_index" ON "wallets" USING btree ("userId");


--
-- MIGRATION VERSION FOR awhar_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar_backend', '20260107161158019', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260107161158019', "timestamp" = now();

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
