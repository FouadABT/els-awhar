BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "reports" DROP CONSTRAINT "reports_fk_3";
ALTER TABLE "reports" DROP CONSTRAINT "reports_fk_4";
ALTER TABLE "reports" DROP CONSTRAINT "reports_fk_5";
ALTER TABLE "reports" ADD COLUMN "reportedStoreId" bigint;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "reports"
    ADD CONSTRAINT "reports_fk_6"
    FOREIGN KEY("resolvedBy")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "reports"
    ADD CONSTRAINT "reports_fk_3"
    FOREIGN KEY("reportedStoreId")
    REFERENCES "stores"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "reports"
    ADD CONSTRAINT "reports_fk_4"
    FOREIGN KEY("reportedOrderId")
    REFERENCES "orders"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "reports"
    ADD CONSTRAINT "reports_fk_5"
    FOREIGN KEY("reviewedByAdminId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR awhar
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar', '20260121150809990', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260121150809990', "timestamp" = now();

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
