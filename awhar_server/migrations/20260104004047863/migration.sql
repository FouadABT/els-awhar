BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "addresses" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "label" text NOT NULL,
    "fullAddress" text NOT NULL,
    "cityId" bigint NOT NULL,
    "latitude" double precision NOT NULL,
    "longitude" double precision NOT NULL,
    "buildingNumber" text,
    "floor" text,
    "apartmentNumber" text,
    "landmark" text,
    "instructions" text,
    "isDefault" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "addr_userId_idx" ON "addresses" USING btree ("userId");
CREATE INDEX "addr_cityId_idx" ON "addresses" USING btree ("cityId");
CREATE INDEX "addr_isDefault_idx" ON "addresses" USING btree ("isDefault");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "admin_actions" (
    "id" bigserial PRIMARY KEY,
    "adminUserId" bigint NOT NULL,
    "actionType" bigint,
    "targetType" text NOT NULL,
    "targetId" bigint NOT NULL,
    "reason" text,
    "notes" text,
    "metadata" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "adminact_adminUserId_idx" ON "admin_actions" USING btree ("adminUserId");
CREATE INDEX "adminact_targetType_idx" ON "admin_actions" USING btree ("targetType");
CREATE INDEX "adminact_targetId_idx" ON "admin_actions" USING btree ("targetId");
CREATE INDEX "adminact_createdAt_idx" ON "admin_actions" USING btree ("createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "admin_users" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "role" text NOT NULL,
    "permissions" json,
    "isActive" boolean NOT NULL DEFAULT true,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "admin_userId_idx" ON "admin_users" USING btree ("userId");
CREATE INDEX "admin_isActive_idx" ON "admin_users" USING btree ("isActive");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "categories" (
    "id" bigserial PRIMARY KEY,
    "nameEn" text NOT NULL,
    "nameAr" text,
    "nameFr" text,
    "nameEs" text,
    "descriptionEn" text,
    "descriptionAr" text,
    "descriptionFr" text,
    "descriptionEs" text,
    "iconName" text NOT NULL,
    "iconUrl" text,
    "colorHex" text,
    "isActive" boolean NOT NULL DEFAULT true,
    "displayOrder" bigint NOT NULL DEFAULT 0,
    "parentCategoryId" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "cat_isActive_idx" ON "categories" USING btree ("isActive");
CREATE INDEX "cat_displayOrder_idx" ON "categories" USING btree ("displayOrder");
CREATE INDEX "cat_parentCategoryId_idx" ON "categories" USING btree ("parentCategoryId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "cities" (
    "id" bigserial PRIMARY KEY,
    "nameEn" text NOT NULL,
    "nameAr" text,
    "nameFr" text,
    "nameEs" text,
    "countryCode" text NOT NULL DEFAULT 'MA'::text,
    "latitude" double precision NOT NULL,
    "longitude" double precision NOT NULL,
    "isActive" boolean NOT NULL DEFAULT true,
    "isPopular" boolean NOT NULL DEFAULT false,
    "displayOrder" bigint NOT NULL DEFAULT 0,
    "defaultDeliveryRadius" double precision NOT NULL DEFAULT 10.0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "city_nameEn_idx" ON "cities" USING btree ("nameEn");
CREATE INDEX "city_isActive_idx" ON "cities" USING btree ("isActive");
CREATE INDEX "city_displayOrder_idx" ON "cities" USING btree ("displayOrder");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "disputes" (
    "id" bigserial PRIMARY KEY,
    "orderId" bigint NOT NULL,
    "openedByUserId" bigint NOT NULL,
    "clientId" bigint NOT NULL,
    "driverId" bigint NOT NULL,
    "disputeType" bigint,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "evidenceUrls" json,
    "status" bigint,
    "resolution" text,
    "resolvedByAdminId" bigint,
    "resolvedAt" timestamp without time zone,
    "refundAmount" double precision,
    "refundIssued" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "disp_orderId_idx" ON "disputes" USING btree ("orderId");
CREATE INDEX "disp_openedByUserId_idx" ON "disputes" USING btree ("openedByUserId");
CREATE INDEX "disp_status_idx" ON "disputes" USING btree ("status");
CREATE INDEX "disp_createdAt_idx" ON "disputes" USING btree ("createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "driver_profiles" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "displayName" text NOT NULL,
    "bio" text,
    "profilePhotoUrl" text,
    "vehicleType" bigint,
    "vehicleMake" text,
    "vehicleModel" text,
    "vehiclePlate" text,
    "vehicleYear" bigint,
    "vehiclePhotoUrl" text,
    "experienceYears" bigint NOT NULL DEFAULT 0,
    "availabilityStatus" bigint,
    "baseCityId" bigint,
    "ratingAverage" double precision NOT NULL DEFAULT 0.0,
    "ratingCount" bigint NOT NULL DEFAULT 0,
    "isVerified" boolean NOT NULL DEFAULT false,
    "isDocumentsSubmitted" boolean NOT NULL DEFAULT false,
    "isFeatured" boolean NOT NULL DEFAULT false,
    "isPremium" boolean NOT NULL DEFAULT false,
    "premiumUntil" timestamp without time zone,
    "totalCompletedOrders" bigint NOT NULL DEFAULT 0,
    "totalEarnings" double precision NOT NULL DEFAULT 0.0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "verifiedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "driver_userId_idx" ON "driver_profiles" USING btree ("userId");
CREATE INDEX "driver_ratingAverage_idx" ON "driver_profiles" USING btree ("ratingAverage");
CREATE INDEX "driver_isFeatured_idx" ON "driver_profiles" USING btree ("isFeatured");
CREATE INDEX "driver_availabilityStatus_idx" ON "driver_profiles" USING btree ("availabilityStatus");
CREATE INDEX "driver_baseCityId_idx" ON "driver_profiles" USING btree ("baseCityId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "driver_services" (
    "id" bigserial PRIMARY KEY,
    "driverId" bigint NOT NULL,
    "serviceId" bigint NOT NULL,
    "priceType" bigint,
    "basePrice" double precision,
    "pricePerKm" double precision,
    "pricePerHour" double precision,
    "minPrice" double precision,
    "customDescription" text,
    "isActive" boolean NOT NULL DEFAULT true,
    "displayOrder" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "drv_svc_driverId_idx" ON "driver_services" USING btree ("driverId");
CREATE INDEX "drv_svc_serviceId_idx" ON "driver_services" USING btree ("serviceId");
CREATE INDEX "drv_svc_isActive_idx" ON "driver_services" USING btree ("isActive");
CREATE UNIQUE INDEX "drv_svc_driver_service_unique" ON "driver_services" USING btree ("driverId", "serviceId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "driver_statistics" (
    "id" bigserial PRIMARY KEY,
    "driverId" bigint NOT NULL,
    "periodType" text NOT NULL,
    "periodStart" timestamp without time zone NOT NULL,
    "periodEnd" timestamp without time zone NOT NULL,
    "totalOrders" bigint NOT NULL DEFAULT 0,
    "completedOrders" bigint NOT NULL DEFAULT 0,
    "cancelledOrders" bigint NOT NULL DEFAULT 0,
    "totalRevenue" double precision NOT NULL DEFAULT 0.0,
    "platformCommission" double precision NOT NULL DEFAULT 0.0,
    "netRevenue" double precision NOT NULL DEFAULT 0.0,
    "averageRating" double precision NOT NULL DEFAULT 0.0,
    "averageResponseTime" bigint NOT NULL DEFAULT 0,
    "averageCompletionTime" bigint NOT NULL DEFAULT 0,
    "hoursOnline" double precision NOT NULL DEFAULT 0.0,
    "hoursOffline" double precision NOT NULL DEFAULT 0.0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "drv_stats_driverId_idx" ON "driver_statistics" USING btree ("driverId");
CREATE INDEX "drv_stats_periodType_idx" ON "driver_statistics" USING btree ("periodType");
CREATE INDEX "drv_stats_periodStart_idx" ON "driver_statistics" USING btree ("periodStart");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "driver_zones" (
    "id" bigserial PRIMARY KEY,
    "driverId" bigint NOT NULL,
    "zoneName" text NOT NULL,
    "cityId" bigint NOT NULL,
    "geoBoundary" text,
    "centerLatitude" double precision NOT NULL,
    "centerLongitude" double precision NOT NULL,
    "radiusKm" double precision NOT NULL DEFAULT 5.0,
    "extraFeeOutsideZone" double precision NOT NULL DEFAULT 0.0,
    "isPrimary" boolean NOT NULL DEFAULT false,
    "isActive" boolean NOT NULL DEFAULT true,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "drv_zone_driverId_idx" ON "driver_zones" USING btree ("driverId");
CREATE INDEX "drv_zone_cityId_idx" ON "driver_zones" USING btree ("cityId");
CREATE INDEX "drv_zone_isPrimary_idx" ON "driver_zones" USING btree ("isPrimary");
CREATE INDEX "drv_zone_isActive_idx" ON "driver_zones" USING btree ("isActive");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "favorites" (
    "id" bigserial PRIMARY KEY,
    "clientId" bigint NOT NULL,
    "driverId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "fav_clientId_idx" ON "favorites" USING btree ("clientId");
CREATE INDEX "fav_driverId_idx" ON "favorites" USING btree ("driverId");
CREATE UNIQUE INDEX "fav_client_driver_unique" ON "favorites" USING btree ("clientId", "driverId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "order_status_history" (
    "id" bigserial PRIMARY KEY,
    "orderId" bigint NOT NULL,
    "fromStatus" bigint,
    "toStatus" bigint,
    "changedByUserId" bigint NOT NULL,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "order_hist_orderId_idx" ON "order_status_history" USING btree ("orderId");
CREATE INDEX "order_hist_createdAt_idx" ON "order_status_history" USING btree ("createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "order_tracking" (
    "id" bigserial PRIMARY KEY,
    "orderId" bigint NOT NULL,
    "driverId" bigint NOT NULL,
    "latitude" double precision NOT NULL,
    "longitude" double precision NOT NULL,
    "accuracy" double precision,
    "speed" double precision,
    "heading" double precision,
    "recordedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "track_orderId_idx" ON "order_tracking" USING btree ("orderId");
CREATE INDEX "track_recordedAt_idx" ON "order_tracking" USING btree ("recordedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "orders" (
    "id" bigserial PRIMARY KEY,
    "clientId" bigint NOT NULL,
    "driverId" bigint,
    "serviceId" bigint NOT NULL,
    "pickupAddressId" bigint,
    "dropoffAddressId" bigint,
    "pickupLatitude" double precision,
    "pickupLongitude" double precision,
    "pickupAddress" text,
    "dropoffLatitude" double precision,
    "dropoffLongitude" double precision,
    "dropoffAddress" text,
    "estimatedDistanceKm" double precision,
    "estimatedPrice" double precision,
    "agreedPrice" double precision,
    "finalPrice" double precision,
    "notes" text,
    "clientInstructions" text,
    "status" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "acceptedAt" timestamp without time zone,
    "startedAt" timestamp without time zone,
    "completedAt" timestamp without time zone,
    "cancelledAt" timestamp without time zone,
    "cancellationReason" text,
    "cancelledByUserId" bigint
);

-- Indexes
CREATE INDEX "order_clientId_idx" ON "orders" USING btree ("clientId");
CREATE INDEX "order_driverId_idx" ON "orders" USING btree ("driverId");
CREATE INDEX "order_status_idx" ON "orders" USING btree ("status");
CREATE INDEX "order_createdAt_idx" ON "orders" USING btree ("createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "payments" (
    "id" bigserial PRIMARY KEY,
    "subscriptionId" bigint,
    "orderId" bigint,
    "userId" bigint NOT NULL,
    "amount" double precision NOT NULL,
    "currency" text NOT NULL DEFAULT 'MAD'::text,
    "paymentMethod" bigint,
    "status" bigint,
    "externalTransactionId" text,
    "metadata" text,
    "failureReason" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "paidAt" timestamp without time zone,
    "refundedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "pay_subscriptionId_idx" ON "payments" USING btree ("subscriptionId");
CREATE INDEX "pay_orderId_idx" ON "payments" USING btree ("orderId");
CREATE INDEX "pay_userId_idx" ON "payments" USING btree ("userId");
CREATE INDEX "pay_status_idx" ON "payments" USING btree ("status");
CREATE INDEX "pay_externalTransactionId_idx" ON "payments" USING btree ("externalTransactionId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "platform_statistics" (
    "id" bigserial PRIMARY KEY,
    "periodType" text NOT NULL,
    "periodStart" timestamp without time zone NOT NULL,
    "periodEnd" timestamp without time zone NOT NULL,
    "totalUsers" bigint NOT NULL DEFAULT 0,
    "newUsers" bigint NOT NULL DEFAULT 0,
    "activeUsers" bigint NOT NULL DEFAULT 0,
    "totalDrivers" bigint NOT NULL DEFAULT 0,
    "newDrivers" bigint NOT NULL DEFAULT 0,
    "activeDrivers" bigint NOT NULL DEFAULT 0,
    "verifiedDrivers" bigint NOT NULL DEFAULT 0,
    "totalOrders" bigint NOT NULL DEFAULT 0,
    "completedOrders" bigint NOT NULL DEFAULT 0,
    "cancelledOrders" bigint NOT NULL DEFAULT 0,
    "disputedOrders" bigint NOT NULL DEFAULT 0,
    "totalRevenue" double precision NOT NULL DEFAULT 0.0,
    "platformRevenue" double precision NOT NULL DEFAULT 0.0,
    "subscriptionRevenue" double precision NOT NULL DEFAULT 0.0,
    "averageOrdersPerUser" double precision NOT NULL DEFAULT 0.0,
    "averageOrderValue" double precision NOT NULL DEFAULT 0.0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "plat_stats_periodType_idx" ON "platform_statistics" USING btree ("periodType");
CREATE UNIQUE INDEX "plat_stats_periodStart_idx" ON "platform_statistics" USING btree ("periodStart");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reports" (
    "id" bigserial PRIMARY KEY,
    "reportedByUserId" bigint NOT NULL,
    "reportedDriverId" bigint,
    "reportedClientId" bigint,
    "reportedOrderId" bigint,
    "reportReason" bigint,
    "description" text NOT NULL,
    "evidenceUrls" json,
    "status" bigint,
    "reviewedByAdminId" bigint,
    "reviewNotes" text,
    "reviewedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "report_reportedByUserId_idx" ON "reports" USING btree ("reportedByUserId");
CREATE INDEX "report_reportedDriverId_idx" ON "reports" USING btree ("reportedDriverId");
CREATE INDEX "report_status_idx" ON "reports" USING btree ("status");
CREATE INDEX "report_createdAt_idx" ON "reports" USING btree ("createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reviews" (
    "id" bigserial PRIMARY KEY,
    "orderId" bigint NOT NULL,
    "driverId" bigint NOT NULL,
    "clientId" bigint NOT NULL,
    "rating" bigint NOT NULL,
    "comment" text,
    "isVisible" boolean NOT NULL DEFAULT true,
    "isVerified" boolean NOT NULL DEFAULT true,
    "isFlagged" boolean NOT NULL DEFAULT false,
    "flagReason" text,
    "flaggedByUserId" bigint,
    "flaggedAt" timestamp without time zone,
    "driverResponse" text,
    "driverRespondedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "rev_orderId_idx" ON "reviews" USING btree ("orderId");
CREATE INDEX "rev_driverId_idx" ON "reviews" USING btree ("driverId");
CREATE INDEX "rev_clientId_idx" ON "reviews" USING btree ("clientId");
CREATE INDEX "rev_rating_idx" ON "reviews" USING btree ("rating");
CREATE INDEX "rev_isVisible_idx" ON "reviews" USING btree ("isVisible");
CREATE INDEX "rev_createdAt_idx" ON "reviews" USING btree ("createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "search_logs" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint,
    "searchText" text NOT NULL,
    "cityId" bigint,
    "categoryId" bigint,
    "resultsCount" bigint NOT NULL DEFAULT 0,
    "clickedDriverId" bigint,
    "sessionId" text,
    "deviceType" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "search_userId_idx" ON "search_logs" USING btree ("userId");
CREATE INDEX "search_cityId_idx" ON "search_logs" USING btree ("cityId");
CREATE INDEX "search_createdAt_idx" ON "search_logs" USING btree ("createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "services" (
    "id" bigserial PRIMARY KEY,
    "categoryId" bigint NOT NULL,
    "nameEn" text NOT NULL,
    "nameAr" text,
    "nameFr" text,
    "nameEs" text,
    "descriptionEn" text,
    "descriptionAr" text,
    "descriptionFr" text,
    "descriptionEs" text,
    "iconName" text,
    "imageUrl" text,
    "suggestedPriceMin" double precision,
    "suggestedPriceMax" double precision,
    "isActive" boolean NOT NULL DEFAULT true,
    "displayOrder" bigint NOT NULL DEFAULT 0,
    "isPopular" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "svc_categoryId_idx" ON "services" USING btree ("categoryId");
CREATE INDEX "svc_isActive_idx" ON "services" USING btree ("isActive");
CREATE INDEX "svc_displayOrder_idx" ON "services" USING btree ("displayOrder");
CREATE INDEX "svc_isPopular_idx" ON "services" USING btree ("isPopular");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "subscription_plans" (
    "id" bigserial PRIMARY KEY,
    "nameEn" text NOT NULL,
    "nameAr" text,
    "nameFr" text,
    "nameEs" text,
    "descriptionEn" text,
    "descriptionAr" text,
    "descriptionFr" text,
    "descriptionEs" text,
    "priceAmount" double precision NOT NULL,
    "currency" text NOT NULL DEFAULT 'MAD'::text,
    "durationMonths" bigint NOT NULL,
    "features" json NOT NULL,
    "isActive" boolean NOT NULL DEFAULT true,
    "isFeatured" boolean NOT NULL DEFAULT false,
    "displayOrder" bigint NOT NULL DEFAULT 0,
    "commissionRate" double precision,
    "priorityListing" boolean NOT NULL DEFAULT false,
    "badgeEnabled" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "plan_isActive_idx" ON "subscription_plans" USING btree ("isActive");
CREATE INDEX "plan_displayOrder_idx" ON "subscription_plans" USING btree ("displayOrder");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "subscriptions" (
    "id" bigserial PRIMARY KEY,
    "driverId" bigint NOT NULL,
    "planId" bigint NOT NULL,
    "startDate" timestamp without time zone NOT NULL,
    "endDate" timestamp without time zone NOT NULL,
    "status" bigint,
    "autoRenew" boolean NOT NULL DEFAULT false,
    "cancelledAt" timestamp without time zone,
    "cancellationReason" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "sub_driverId_idx" ON "subscriptions" USING btree ("driverId");
CREATE INDEX "sub_status_idx" ON "subscriptions" USING btree ("status");
CREATE INDEX "sub_endDate_idx" ON "subscriptions" USING btree ("endDate");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "system_settings" (
    "id" bigserial PRIMARY KEY,
    "key" text NOT NULL,
    "value" text NOT NULL,
    "description" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "key_idx" ON "system_settings" USING btree ("key");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_clients" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "defaultAddressId" bigint,
    "defaultCityId" bigint,
    "totalOrders" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "uclient_userId_idx" ON "user_clients" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "users" (
    "id" bigserial PRIMARY KEY,
    "firebaseUid" text NOT NULL,
    "fullName" text NOT NULL,
    "phoneNumber" text NOT NULL,
    "email" text,
    "profilePhotoUrl" text,
    "roles" json NOT NULL,
    "status" bigint,
    "isPhoneVerified" boolean NOT NULL DEFAULT false,
    "isEmailVerified" boolean NOT NULL DEFAULT false,
    "preferredLanguage" bigint,
    "notificationsEnabled" boolean NOT NULL DEFAULT true,
    "darkModeEnabled" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastSeenAt" timestamp without time zone,
    "deletedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "firebaseUid_idx" ON "users" USING btree ("firebaseUid");
CREATE UNIQUE INDEX "email_idx" ON "users" USING btree ("email");
CREATE UNIQUE INDEX "phoneNumber_idx" ON "users" USING btree ("phoneNumber");
CREATE INDEX "user_status_idx" ON "users" USING btree ("status");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "addresses"
    ADD CONSTRAINT "addresses_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "addresses"
    ADD CONSTRAINT "addresses_fk_1"
    FOREIGN KEY("cityId")
    REFERENCES "cities"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "admin_actions"
    ADD CONSTRAINT "admin_actions_fk_0"
    FOREIGN KEY("adminUserId")
    REFERENCES "admin_users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "admin_users"
    ADD CONSTRAINT "admin_users_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "categories"
    ADD CONSTRAINT "categories_fk_0"
    FOREIGN KEY("parentCategoryId")
    REFERENCES "categories"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "disputes"
    ADD CONSTRAINT "disputes_fk_0"
    FOREIGN KEY("orderId")
    REFERENCES "orders"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "disputes"
    ADD CONSTRAINT "disputes_fk_1"
    FOREIGN KEY("openedByUserId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "disputes"
    ADD CONSTRAINT "disputes_fk_2"
    FOREIGN KEY("clientId")
    REFERENCES "user_clients"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "disputes"
    ADD CONSTRAINT "disputes_fk_3"
    FOREIGN KEY("driverId")
    REFERENCES "driver_profiles"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "disputes"
    ADD CONSTRAINT "disputes_fk_4"
    FOREIGN KEY("resolvedByAdminId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "driver_profiles"
    ADD CONSTRAINT "driver_profiles_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "driver_profiles"
    ADD CONSTRAINT "driver_profiles_fk_1"
    FOREIGN KEY("baseCityId")
    REFERENCES "cities"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "driver_services"
    ADD CONSTRAINT "driver_services_fk_0"
    FOREIGN KEY("driverId")
    REFERENCES "driver_profiles"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "driver_services"
    ADD CONSTRAINT "driver_services_fk_1"
    FOREIGN KEY("serviceId")
    REFERENCES "services"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "driver_statistics"
    ADD CONSTRAINT "driver_statistics_fk_0"
    FOREIGN KEY("driverId")
    REFERENCES "driver_profiles"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "driver_zones"
    ADD CONSTRAINT "driver_zones_fk_0"
    FOREIGN KEY("driverId")
    REFERENCES "driver_profiles"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "driver_zones"
    ADD CONSTRAINT "driver_zones_fk_1"
    FOREIGN KEY("cityId")
    REFERENCES "cities"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "favorites"
    ADD CONSTRAINT "favorites_fk_0"
    FOREIGN KEY("clientId")
    REFERENCES "user_clients"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "favorites"
    ADD CONSTRAINT "favorites_fk_1"
    FOREIGN KEY("driverId")
    REFERENCES "driver_profiles"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "order_status_history"
    ADD CONSTRAINT "order_status_history_fk_0"
    FOREIGN KEY("orderId")
    REFERENCES "orders"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "order_status_history"
    ADD CONSTRAINT "order_status_history_fk_1"
    FOREIGN KEY("changedByUserId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "order_tracking"
    ADD CONSTRAINT "order_tracking_fk_0"
    FOREIGN KEY("orderId")
    REFERENCES "orders"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "order_tracking"
    ADD CONSTRAINT "order_tracking_fk_1"
    FOREIGN KEY("driverId")
    REFERENCES "driver_profiles"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "orders"
    ADD CONSTRAINT "orders_fk_0"
    FOREIGN KEY("clientId")
    REFERENCES "user_clients"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "orders"
    ADD CONSTRAINT "orders_fk_1"
    FOREIGN KEY("driverId")
    REFERENCES "driver_profiles"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "orders"
    ADD CONSTRAINT "orders_fk_2"
    FOREIGN KEY("serviceId")
    REFERENCES "services"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "orders"
    ADD CONSTRAINT "orders_fk_3"
    FOREIGN KEY("pickupAddressId")
    REFERENCES "addresses"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "orders"
    ADD CONSTRAINT "orders_fk_4"
    FOREIGN KEY("dropoffAddressId")
    REFERENCES "addresses"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "payments"
    ADD CONSTRAINT "payments_fk_0"
    FOREIGN KEY("subscriptionId")
    REFERENCES "subscriptions"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "payments"
    ADD CONSTRAINT "payments_fk_1"
    FOREIGN KEY("orderId")
    REFERENCES "orders"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "payments"
    ADD CONSTRAINT "payments_fk_2"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "reports"
    ADD CONSTRAINT "reports_fk_0"
    FOREIGN KEY("reportedByUserId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "reports"
    ADD CONSTRAINT "reports_fk_1"
    FOREIGN KEY("reportedDriverId")
    REFERENCES "driver_profiles"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "reports"
    ADD CONSTRAINT "reports_fk_2"
    FOREIGN KEY("reportedClientId")
    REFERENCES "user_clients"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "reports"
    ADD CONSTRAINT "reports_fk_3"
    FOREIGN KEY("reportedOrderId")
    REFERENCES "orders"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "reports"
    ADD CONSTRAINT "reports_fk_4"
    FOREIGN KEY("reviewedByAdminId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "reviews"
    ADD CONSTRAINT "reviews_fk_0"
    FOREIGN KEY("orderId")
    REFERENCES "orders"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "reviews"
    ADD CONSTRAINT "reviews_fk_1"
    FOREIGN KEY("driverId")
    REFERENCES "driver_profiles"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "reviews"
    ADD CONSTRAINT "reviews_fk_2"
    FOREIGN KEY("clientId")
    REFERENCES "user_clients"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "reviews"
    ADD CONSTRAINT "reviews_fk_3"
    FOREIGN KEY("flaggedByUserId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "search_logs"
    ADD CONSTRAINT "search_logs_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "search_logs"
    ADD CONSTRAINT "search_logs_fk_1"
    FOREIGN KEY("cityId")
    REFERENCES "cities"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "search_logs"
    ADD CONSTRAINT "search_logs_fk_2"
    FOREIGN KEY("categoryId")
    REFERENCES "categories"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "search_logs"
    ADD CONSTRAINT "search_logs_fk_3"
    FOREIGN KEY("clickedDriverId")
    REFERENCES "driver_profiles"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "services"
    ADD CONSTRAINT "services_fk_0"
    FOREIGN KEY("categoryId")
    REFERENCES "categories"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "subscriptions"
    ADD CONSTRAINT "subscriptions_fk_0"
    FOREIGN KEY("driverId")
    REFERENCES "driver_profiles"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "subscriptions"
    ADD CONSTRAINT "subscriptions_fk_1"
    FOREIGN KEY("planId")
    REFERENCES "subscription_plans"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_clients"
    ADD CONSTRAINT "user_clients_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "user_clients"
    ADD CONSTRAINT "user_clients_fk_1"
    FOREIGN KEY("defaultAddressId")
    REFERENCES "addresses"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "user_clients"
    ADD CONSTRAINT "user_clients_fk_2"
    FOREIGN KEY("defaultCityId")
    REFERENCES "cities"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR awhar_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar_backend', '20260104004047863', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260104004047863', "timestamp" = now();

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
