BEGIN;

--
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

--
-- Class Address as table addresses
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
-- Class AdminAction as table admin_actions
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
-- Class AdminUser as table admin_users
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
-- Class Category as table categories
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
-- Class ChatMessage as table chat_messages
--
CREATE TABLE "chat_messages" (
    "id" bigserial PRIMARY KEY,
    "orderId" bigint NOT NULL,
    "senderId" bigint NOT NULL,
    "receiverId" bigint NOT NULL,
    "message" text NOT NULL,
    "messageType" bigint,
    "attachmentUrl" text,
    "isRead" boolean NOT NULL DEFAULT false,
    "readAt" timestamp without time zone,
    "firebaseId" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "chat_message_orderId_idx" ON "chat_messages" USING btree ("orderId");
CREATE INDEX "chat_message_senderId_idx" ON "chat_messages" USING btree ("senderId");
CREATE INDEX "chat_message_receiverId_idx" ON "chat_messages" USING btree ("receiverId");
CREATE UNIQUE INDEX "chat_message_firebaseId_idx" ON "chat_messages" USING btree ("firebaseId");
CREATE INDEX "chat_message_createdAt_idx" ON "chat_messages" USING btree ("createdAt");

--
-- Class City as table cities
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
-- Class ClientReview as table client_reviews
--
CREATE TABLE "client_reviews" (
    "id" bigserial PRIMARY KEY,
    "orderId" bigint NOT NULL,
    "driverId" bigint NOT NULL,
    "clientId" bigint NOT NULL,
    "rating" bigint NOT NULL,
    "comment" text,
    "communicationRating" bigint,
    "respectRating" bigint,
    "paymentPromptness" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "client_review_orderId_idx" ON "client_reviews" USING btree ("orderId");
CREATE INDEX "client_review_driverId_idx" ON "client_reviews" USING btree ("driverId");
CREATE INDEX "client_review_clientId_idx" ON "client_reviews" USING btree ("clientId");
CREATE INDEX "client_review_createdAt_idx" ON "client_reviews" USING btree ("createdAt");

--
-- Class Dispute as table disputes
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
-- Class DriverOffer as table driver_offers
--
CREATE TABLE "driver_offers" (
    "id" bigserial PRIMARY KEY,
    "orderId" bigint NOT NULL,
    "driverId" bigint NOT NULL,
    "offeredPrice" double precision NOT NULL,
    "message" text,
    "status" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "respondedAt" timestamp without time zone,
    "expiresAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "driver_offer_orderId_idx" ON "driver_offers" USING btree ("orderId");
CREATE INDEX "driver_offer_driverId_idx" ON "driver_offers" USING btree ("driverId");
CREATE INDEX "driver_offer_status_idx" ON "driver_offers" USING btree ("status");
CREATE INDEX "driver_offer_createdAt_idx" ON "driver_offers" USING btree ("createdAt");
CREATE UNIQUE INDEX "driver_offer_order_driver_unique" ON "driver_offers" USING btree ("orderId", "driverId");

--
-- Class DriverProfile as table driver_profiles
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
    "isOnline" boolean NOT NULL DEFAULT false,
    "lastLocationLat" double precision,
    "lastLocationLng" double precision,
    "lastLocationUpdatedAt" timestamp without time zone,
    "autoOfflineAt" timestamp without time zone,
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
-- Class DriverProposal as table driver_proposals
--
CREATE TABLE "driver_proposals" (
    "id" bigserial PRIMARY KEY,
    "requestId" bigint NOT NULL,
    "driverId" bigint NOT NULL,
    "proposedPrice" double precision,
    "estimatedArrival" bigint NOT NULL,
    "message" text,
    "driverName" text NOT NULL,
    "driverPhone" text,
    "driverRating" double precision DEFAULT 0.0,
    "driverVehicleInfo" text,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "acceptedAt" timestamp without time zone,
    "rejectedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "proposal_requestId_index" ON "driver_proposals" USING btree ("requestId");
CREATE INDEX "proposal_driverId_index" ON "driver_proposals" USING btree ("driverId");
CREATE INDEX "proposal_status_index" ON "driver_proposals" USING btree ("status");
CREATE INDEX "proposal_requestId_status_index" ON "driver_proposals" USING btree ("requestId", "status");

--
-- Class DriverService as table driver_services
--
CREATE TABLE "driver_services" (
    "id" bigserial PRIMARY KEY,
    "driverId" bigint NOT NULL,
    "serviceId" bigint NOT NULL,
    "categoryId" bigint,
    "priceType" bigint,
    "basePrice" double precision,
    "pricePerKm" double precision,
    "pricePerHour" double precision,
    "minPrice" double precision,
    "imageUrl" text,
    "description" text,
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
-- Class DriverStatistics as table driver_statistics
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
-- Class DriverZone as table driver_zones
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
-- Class Favorite as table favorites
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
-- Class OrderStatusHistory as table order_status_history
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
-- Class OrderTracking as table order_tracking
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
-- Class Order as table orders
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
    "clientProposedPrice" double precision,
    "driverCounterPrice" double precision,
    "priceNegotiationStatus" bigint,
    "notes" text,
    "clientInstructions" text,
    "expiresAt" timestamp without time zone,
    "status" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "acceptedAt" timestamp without time zone,
    "startedAt" timestamp without time zone,
    "completedAt" timestamp without time zone,
    "cancelledAt" timestamp without time zone,
    "cancellationReason" text,
    "cancelledByUserId" bigint,
    "cancelledBy" bigint
);

-- Indexes
CREATE INDEX "order_clientId_idx" ON "orders" USING btree ("clientId");
CREATE INDEX "order_driverId_idx" ON "orders" USING btree ("driverId");
CREATE INDEX "order_status_idx" ON "orders" USING btree ("status");
CREATE INDEX "order_createdAt_idx" ON "orders" USING btree ("createdAt");

--
-- Class Payment as table payments
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
-- Class PlatformStatistics as table platform_statistics
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
-- Class Rating as table ratings
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
-- Class Report as table reports
--
CREATE TABLE "reports" (
    "id" bigserial PRIMARY KEY,
    "reportedByUserId" bigint NOT NULL,
    "reporterType" bigint,
    "reportedDriverId" bigint,
    "reportedClientId" bigint,
    "reportedOrderId" bigint,
    "reportedType" bigint,
    "reportReason" bigint,
    "description" text NOT NULL,
    "evidenceUrls" json,
    "status" bigint,
    "resolution" bigint,
    "reviewedByAdminId" bigint,
    "reviewNotes" text,
    "adminNotes" text,
    "reviewedAt" timestamp without time zone,
    "resolvedAt" timestamp without time zone,
    "resolvedBy" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "report_reportedByUserId_idx" ON "reports" USING btree ("reportedByUserId");
CREATE INDEX "report_reportedDriverId_idx" ON "reports" USING btree ("reportedDriverId");
CREATE INDEX "report_status_idx" ON "reports" USING btree ("status");
CREATE INDEX "report_createdAt_idx" ON "reports" USING btree ("createdAt");

--
-- Class Review as table reviews
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
-- Class SearchLog as table search_logs
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
-- Class ServiceCategory as table service_categories
--
CREATE TABLE "service_categories" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "nameAr" text NOT NULL,
    "nameFr" text NOT NULL,
    "nameEs" text,
    "icon" text NOT NULL,
    "description" text,
    "displayOrder" bigint NOT NULL DEFAULT 0,
    "isActive" boolean NOT NULL DEFAULT true,
    "defaultRadiusKm" double precision NOT NULL DEFAULT 10.0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "service_category_name_idx" ON "service_categories" USING btree ("name");
CREATE INDEX "service_category_isActive_idx" ON "service_categories" USING btree ("isActive");
CREATE INDEX "service_category_displayOrder_idx" ON "service_categories" USING btree ("displayOrder");

--
-- Class ServiceRequest as table service_requests
--
CREATE TABLE "service_requests" (
    "id" bigserial PRIMARY KEY,
    "clientId" bigint NOT NULL,
    "driverId" bigint,
    "serviceType" text NOT NULL,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "pickupLocation" json NOT NULL,
    "destinationLocation" json NOT NULL,
    "basePrice" double precision NOT NULL,
    "distancePrice" double precision NOT NULL,
    "totalPrice" double precision NOT NULL,
    "distance" double precision NOT NULL,
    "estimatedDuration" bigint NOT NULL,
    "clientOfferedPrice" double precision,
    "driverCounterPrice" double precision,
    "agreedPrice" double precision,
    "negotiationStatus" bigint DEFAULT 0,
    "isPaid" boolean NOT NULL DEFAULT false,
    "itemDescription" text,
    "recipientName" text,
    "recipientPhone" text,
    "specialInstructions" text,
    "packageSize" text,
    "isFragile" boolean NOT NULL DEFAULT false,
    "notes" text,
    "clientName" text NOT NULL,
    "clientPhone" text,
    "driverName" text,
    "driverPhone" text,
    "cancelledBy" bigint,
    "cancellationReason" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "acceptedAt" timestamp without time zone,
    "driverArrivingAt" timestamp without time zone,
    "startedAt" timestamp without time zone,
    "completedAt" timestamp without time zone,
    "cancelledAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "clientId_index" ON "service_requests" USING btree ("clientId");
CREATE INDEX "driverId_index" ON "service_requests" USING btree ("driverId");
CREATE INDEX "status_index" ON "service_requests" USING btree ("status");
CREATE INDEX "createdAt_index" ON "service_requests" USING btree ("createdAt");

--
-- Class Service as table services
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
-- Class SubscriptionPlan as table subscription_plans
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
-- Class Subscription as table subscriptions
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
-- Class SystemSetting as table system_settings
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
-- Class Transaction as table transactions
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
    "driverConfirmed" boolean NOT NULL DEFAULT false,
    "clientConfirmed" boolean NOT NULL DEFAULT false,
    "driverConfirmedAt" timestamp without time zone,
    "clientConfirmedAt" timestamp without time zone,
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
-- Class UserClient as table user_clients
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
-- Class User as table users
--
CREATE TABLE "users" (
    "id" bigserial PRIMARY KEY,
    "firebaseUid" text NOT NULL,
    "fullName" text NOT NULL,
    "phoneNumber" text,
    "email" text,
    "profilePhotoUrl" text,
    "roles" json NOT NULL,
    "status" bigint,
    "isOnline" boolean NOT NULL DEFAULT false,
    "isPhoneVerified" boolean NOT NULL DEFAULT false,
    "isEmailVerified" boolean NOT NULL DEFAULT false,
    "rating" double precision DEFAULT 0.0,
    "totalRatings" bigint NOT NULL DEFAULT 0,
    "totalRatingsAsClient" bigint NOT NULL DEFAULT 0,
    "ratingAsClient" double precision DEFAULT 0.0,
    "vehicleInfo" text,
    "vehiclePlate" text,
    "preferredLanguage" bigint,
    "notificationsEnabled" boolean NOT NULL DEFAULT true,
    "darkModeEnabled" boolean NOT NULL DEFAULT false,
    "fcmToken" text,
    "isSuspended" boolean NOT NULL DEFAULT false,
    "suspendedUntil" timestamp without time zone,
    "suspensionReason" text,
    "totalReportsReceived" bigint NOT NULL DEFAULT 0,
    "totalReportsMade" bigint NOT NULL DEFAULT 0,
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
-- Class Wallet as table wallets
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
-- Class CloudStorageEntry as table serverpod_cloud_storage
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- Class CloudStorageDirectUploadEntry as table serverpod_cloud_storage_direct_upload
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- Class FutureCallEntry as table serverpod_future_call
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- Class ServerHealthConnectionInfo as table serverpod_health_connection_info
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- Class ServerHealthMetric as table serverpod_health_metric
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- Class LogEntry as table serverpod_log
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId");

--
-- Class MessageLogEntry as table serverpod_message_log
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

--
-- Class MethodInfo as table serverpod_method
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- Class DatabaseMigrationVersion as table serverpod_migrations
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- Class QueryLogEntry as table serverpod_query_log
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId");

--
-- Class ReadWriteTestEntry as table serverpod_readwrite_test
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- Class RuntimeSettings as table serverpod_runtime_settings
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- Class SessionLogEntry as table serverpod_session_log
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "userId" text,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- Class AppleAccount as table serverpod_auth_idp_apple_account
--
CREATE TABLE "serverpod_auth_idp_apple_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userIdentifier" text NOT NULL,
    "refreshToken" text NOT NULL,
    "refreshTokenRequestedWithBundleIdentifier" boolean NOT NULL,
    "lastRefreshedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text,
    "isEmailVerified" boolean,
    "isPrivateEmail" boolean,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_apple_account_identifier" ON "serverpod_auth_idp_apple_account" USING btree ("userIdentifier");

--
-- Class EmailAccount as table serverpod_auth_idp_email_account
--
CREATE TABLE "serverpod_auth_idp_email_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "passwordHash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_email" ON "serverpod_auth_idp_email_account" USING btree ("email");

--
-- Class EmailAccountPasswordResetRequest as table serverpod_auth_idp_email_account_password_reset_request
--
CREATE TABLE "serverpod_auth_idp_email_account_password_reset_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "emailAccountId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "challengeId" uuid NOT NULL,
    "setPasswordChallengeId" uuid
);

--
-- Class EmailAccountRequest as table serverpod_auth_idp_email_account_request
--
CREATE TABLE "serverpod_auth_idp_email_account_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" text NOT NULL,
    "challengeId" uuid NOT NULL,
    "createAccountChallengeId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_request_email" ON "serverpod_auth_idp_email_account_request" USING btree ("email");

--
-- Class GoogleAccount as table serverpod_auth_idp_google_account
--
CREATE TABLE "serverpod_auth_idp_google_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_google_account_user_identifier" ON "serverpod_auth_idp_google_account" USING btree ("userIdentifier");

--
-- Class PasskeyAccount as table serverpod_auth_idp_passkey_account
--
CREATE TABLE "serverpod_auth_idp_passkey_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "keyId" bytea NOT NULL,
    "keyIdBase64" text NOT NULL,
    "clientDataJSON" bytea NOT NULL,
    "attestationObject" bytea NOT NULL,
    "originalChallenge" bytea NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_passkey_account_key_id_base64" ON "serverpod_auth_idp_passkey_account" USING btree ("keyIdBase64");

--
-- Class PasskeyChallenge as table serverpod_auth_idp_passkey_challenge
--
CREATE TABLE "serverpod_auth_idp_passkey_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "challenge" bytea NOT NULL
);

--
-- Class RateLimitedRequestAttempt as table serverpod_auth_idp_rate_limited_request_attempt
--
CREATE TABLE "serverpod_auth_idp_rate_limited_request_attempt" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "domain" text NOT NULL,
    "source" text NOT NULL,
    "nonce" text NOT NULL,
    "ipAddress" text,
    "attemptedAt" timestamp without time zone NOT NULL,
    "extraData" json
);

-- Indexes
CREATE INDEX "serverpod_auth_idp_rate_limited_request_attempt_domain" ON "serverpod_auth_idp_rate_limited_request_attempt" USING btree ("domain");
CREATE INDEX "serverpod_auth_idp_rate_limited_request_attempt_source" ON "serverpod_auth_idp_rate_limited_request_attempt" USING btree ("source");
CREATE INDEX "serverpod_auth_idp_rate_limited_request_attempt_nonce" ON "serverpod_auth_idp_rate_limited_request_attempt" USING btree ("nonce");

--
-- Class SecretChallenge as table serverpod_auth_idp_secret_challenge
--
CREATE TABLE "serverpod_auth_idp_secret_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "challengeCodeHash" text NOT NULL
);

--
-- Class RefreshToken as table serverpod_auth_core_jwt_refresh_token
--
CREATE TABLE "serverpod_auth_core_jwt_refresh_token" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "extraClaims" text,
    "method" text NOT NULL,
    "fixedSecret" bytea NOT NULL,
    "rotatingSecretHash" text NOT NULL,
    "lastUpdatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "serverpod_auth_core_jwt_refresh_token_last_updated_at" ON "serverpod_auth_core_jwt_refresh_token" USING btree ("lastUpdatedAt");

--
-- Class UserProfile as table serverpod_auth_core_profile
--
CREATE TABLE "serverpod_auth_core_profile" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "imageId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_profile_user_profile_email_auth_user_id" ON "serverpod_auth_core_profile" USING btree ("authUserId");

--
-- Class UserProfileImage as table serverpod_auth_core_profile_image
--
CREATE TABLE "serverpod_auth_core_profile_image" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userProfileId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "url" text NOT NULL
);

--
-- Class ServerSideSession as table serverpod_auth_core_session
--
CREATE TABLE "serverpod_auth_core_session" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastUsedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone,
    "expireAfterUnusedFor" bigint,
    "sessionKeyHash" bytea NOT NULL,
    "sessionKeySalt" bytea NOT NULL,
    "method" text NOT NULL
);

--
-- Class AuthUser as table serverpod_auth_core_user
--
CREATE TABLE "serverpod_auth_core_user" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

--
-- Foreign relations for "addresses" table
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
-- Foreign relations for "admin_actions" table
--
ALTER TABLE ONLY "admin_actions"
    ADD CONSTRAINT "admin_actions_fk_0"
    FOREIGN KEY("adminUserId")
    REFERENCES "admin_users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "admin_users" table
--
ALTER TABLE ONLY "admin_users"
    ADD CONSTRAINT "admin_users_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "categories" table
--
ALTER TABLE ONLY "categories"
    ADD CONSTRAINT "categories_fk_0"
    FOREIGN KEY("parentCategoryId")
    REFERENCES "categories"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "chat_messages" table
--
ALTER TABLE ONLY "chat_messages"
    ADD CONSTRAINT "chat_messages_fk_0"
    FOREIGN KEY("orderId")
    REFERENCES "orders"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "chat_messages"
    ADD CONSTRAINT "chat_messages_fk_1"
    FOREIGN KEY("senderId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "chat_messages"
    ADD CONSTRAINT "chat_messages_fk_2"
    FOREIGN KEY("receiverId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "client_reviews" table
--
ALTER TABLE ONLY "client_reviews"
    ADD CONSTRAINT "client_reviews_fk_0"
    FOREIGN KEY("orderId")
    REFERENCES "orders"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "client_reviews"
    ADD CONSTRAINT "client_reviews_fk_1"
    FOREIGN KEY("driverId")
    REFERENCES "driver_profiles"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "client_reviews"
    ADD CONSTRAINT "client_reviews_fk_2"
    FOREIGN KEY("clientId")
    REFERENCES "user_clients"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "disputes" table
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
-- Foreign relations for "driver_offers" table
--
ALTER TABLE ONLY "driver_offers"
    ADD CONSTRAINT "driver_offers_fk_0"
    FOREIGN KEY("orderId")
    REFERENCES "orders"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "driver_offers"
    ADD CONSTRAINT "driver_offers_fk_1"
    FOREIGN KEY("driverId")
    REFERENCES "driver_profiles"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "driver_profiles" table
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
-- Foreign relations for "driver_services" table
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
ALTER TABLE ONLY "driver_services"
    ADD CONSTRAINT "driver_services_fk_2"
    FOREIGN KEY("categoryId")
    REFERENCES "service_categories"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "driver_statistics" table
--
ALTER TABLE ONLY "driver_statistics"
    ADD CONSTRAINT "driver_statistics_fk_0"
    FOREIGN KEY("driverId")
    REFERENCES "driver_profiles"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "driver_zones" table
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
-- Foreign relations for "favorites" table
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
-- Foreign relations for "order_status_history" table
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
-- Foreign relations for "order_tracking" table
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
-- Foreign relations for "orders" table
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
-- Foreign relations for "payments" table
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
-- Foreign relations for "reports" table
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
ALTER TABLE ONLY "reports"
    ADD CONSTRAINT "reports_fk_5"
    FOREIGN KEY("resolvedBy")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "reviews" table
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
-- Foreign relations for "search_logs" table
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
-- Foreign relations for "services" table
--
ALTER TABLE ONLY "services"
    ADD CONSTRAINT "services_fk_0"
    FOREIGN KEY("categoryId")
    REFERENCES "categories"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "subscriptions" table
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
-- Foreign relations for "user_clients" table
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
-- Foreign relations for "serverpod_log" table
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_message_log" table
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_query_log" table
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_apple_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_apple_account"
    ADD CONSTRAINT "serverpod_auth_idp_apple_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_password_reset_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_0"
    FOREIGN KEY("emailAccountId")
    REFERENCES "serverpod_auth_idp_email_account"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_1"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_2"
    FOREIGN KEY("setPasswordChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_0"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_1"
    FOREIGN KEY("createAccountChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_google_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_google_account"
    ADD CONSTRAINT "serverpod_auth_idp_google_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_passkey_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_passkey_account"
    ADD CONSTRAINT "serverpod_auth_idp_passkey_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_jwt_refresh_token" table
--
ALTER TABLE ONLY "serverpod_auth_core_jwt_refresh_token"
    ADD CONSTRAINT "serverpod_auth_core_jwt_refresh_token_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_profile" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_1"
    FOREIGN KEY("imageId")
    REFERENCES "serverpod_auth_core_profile_image"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_profile_image" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile_image"
    ADD CONSTRAINT "serverpod_auth_core_profile_image_fk_0"
    FOREIGN KEY("userProfileId")
    REFERENCES "serverpod_auth_core_profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_session" table
--
ALTER TABLE ONLY "serverpod_auth_core_session"
    ADD CONSTRAINT "serverpod_auth_core_session_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR awhar_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('awhar_backend', '20260108011545513', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260108011545513', "timestamp" = now();

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
