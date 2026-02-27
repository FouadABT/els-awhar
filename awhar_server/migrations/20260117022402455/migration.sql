BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "store_order_chat_messages" (
    "id" bigserial PRIMARY KEY,
    "chatId" bigint NOT NULL,
    "senderId" bigint NOT NULL,
    "senderRole" text NOT NULL,
    "senderName" text NOT NULL,
    "messageType" text NOT NULL DEFAULT 'text'::text,
    "content" text NOT NULL,
    "attachmentUrl" text,
    "latitude" double precision,
    "longitude" double precision,
    "readByJson" text,
    "firebaseId" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "store_chat_msg_chatId_idx" ON "store_order_chat_messages" USING btree ("chatId");
CREATE INDEX "store_chat_msg_senderId_idx" ON "store_order_chat_messages" USING btree ("senderId");
CREATE INDEX "store_chat_msg_createdAt_idx" ON "store_order_chat_messages" USING btree ("createdAt");
CREATE UNIQUE INDEX "store_chat_msg_firebaseId_idx" ON "store_order_chat_messages" USING btree ("firebaseId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "store_order_chats" (
    "id" bigserial PRIMARY KEY,
    "storeOrderId" bigint NOT NULL,
    "clientId" bigint NOT NULL,
    "storeId" bigint NOT NULL,
    "driverId" bigint,
    "firebaseChannelId" text,
    "isActive" boolean NOT NULL DEFAULT true,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "store_order_chat_orderId_idx" ON "store_order_chats" USING btree ("storeOrderId");
CREATE INDEX "store_order_chat_clientId_idx" ON "store_order_chats" USING btree ("clientId");
CREATE INDEX "store_order_chat_storeId_idx" ON "store_order_chats" USING btree ("storeId");
CREATE INDEX "store_order_chat_driverId_idx" ON "store_order_chats" USING btree ("driverId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "store_orders" DROP COLUMN "chatChannelId";
ALTER TABLE "store_orders" ADD COLUMN "chatId" bigint;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "store_order_chat_messages"
    ADD CONSTRAINT "store_order_chat_messages_fk_0"
    FOREIGN KEY("chatId")
    REFERENCES "store_order_chats"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "store_order_chat_messages"
    ADD CONSTRAINT "store_order_chat_messages_fk_1"
    FOREIGN KEY("senderId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "store_order_chats"
    ADD CONSTRAINT "store_order_chats_fk_0"
    FOREIGN KEY("storeOrderId")
    REFERENCES "store_orders"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "store_order_chats"
    ADD CONSTRAINT "store_order_chats_fk_1"
    FOREIGN KEY("clientId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "store_order_chats"
    ADD CONSTRAINT "store_order_chats_fk_2"
    FOREIGN KEY("storeId")
    REFERENCES "stores"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "store_order_chats"
    ADD CONSTRAINT "store_order_chats_fk_3"
    FOREIGN KEY("driverId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "store_orders"
    ADD CONSTRAINT "store_orders_fk_3"
    FOREIGN KEY("chatId")
    REFERENCES "store_order_chats"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR awhar
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar', '20260117022402455', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260117022402455', "timestamp" = now();

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
