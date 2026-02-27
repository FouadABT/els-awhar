# Awhar Backend Database Schema

## 🏗️ Architecture Overview

**Framework:** Serverpod 3.1.1  
**Database:** PostgreSQL  
**Auth:** Firebase Authentication  
**Real-time:** Firebase Realtime Database (chat, notifications)  
**Storage:** Firebase Storage (images, documents)

---

## 📊 Database Tables (27 Total)

### **Core Identity (3 tables)**
- `users` - Main user accounts (linked to Firebase)
- `clients` - Client-specific data
- `driver_profiles` - Driver-specific data & stats

### **Location (3 tables)**
- `cities` - Supported cities (multi-language)
- `addresses` - User saved addresses
- `driver_zones` - Driver service areas

### **Services (3 tables)**
- `categories` - Service categories (multi-language)
- `services` - Available services
- `driver_services` - Services offered by each driver

### **Orders (3 tables)**
- `orders` - Coordination records
- `order_status_history` - Audit trail
- `order_tracking` - GPS trail (opt-in)

### **Reviews (2 tables)**
- `reviews` - Driver ratings & comments
- `favorites` - Client saved drivers

### **Disputes (2 tables)**
- `disputes` - Mediation cases
- `reports` - User reports

### **Monetization (3 tables)**
- `subscription_plans` - Premium driver plans
- `subscriptions` - Active subscriptions
- `payments` - Payment records

### **Admin (3 tables)**
- `admin_users` - Admin accounts
- `admin_actions` - Audit log
- `system_settings` - Config key-value store

### **Analytics (3 tables)**
- `search_logs` - Search behavior tracking
- `driver_statistics` - Per-driver metrics
- `platform_statistics` - Overall platform metrics

---

## 🔑 Key Design Decisions

### 1. **Firebase Integration**
- **Auth:** `users.firebaseUid` links Serverpod to Firebase
- **Chat:** Use Firebase Realtime DB (not in SQL)
- **Notifications:** Use FCM (not in SQL)
- **Storage:** Profile photos, evidence images in Firebase Storage

### 2. **Multi-Language Support**
- All user-facing content has: `nameEn`, `nameAr`, `nameFr`, `nameEs`
- Enum for user `preferredLanguage`

### 3. **Type Safety**
- **15 Enums** defined (UserRole, OrderStatus, etc.)
- No string typos, validated at compile-time

### 4. **Soft Deletes**
- `users.status = deleted` + `deletedAt` timestamp
- Preserves data for analytics

### 5. **Relations**
- Foreign keys with `onDelete` policies:
  - `cascade` - Child deleted when parent deleted
  - `restrict` - Prevent deletion if children exist

### 6. **Indexes**
- Added on all commonly queried columns
- Unique constraints on emails, phone numbers
- Composite indexes for multi-column searches

### 7. **Audit Trails**
- `order_status_history` - All order changes
- `admin_actions` - Admin activities
- Timestamps on all tables

---

## 🚀 Generate & Run

### 1. Generate Dart Code + Migrations
```powershell
cd awhar_server
serverpod generate
```

This creates:
- Dart models in `lib/src/generated/`
- SQL migration files in `migrations/`

### 2. Create Migration
```powershell
serverpod create-migration
```

### 3. Apply to Database
```powershell
docker-compose down
docker-compose up -d
```

### 4. Verify Tables
```powershell
docker exec -it awhar_backend-postgres-1 psql -U postgres -d awhar_backend
\dt  # List all tables
```

---

## 📋 Table Summary

| Category | Tables | Purpose |
|----------|--------|---------|
| Identity | 3 | User accounts, clients, drivers |
| Location | 3 | Cities, addresses, zones |
| Services | 3 | Categories, services, pricing |
| Orders | 3 | Coordination records, tracking |
| Trust | 2 | Reviews, favorites |
| Disputes | 2 | Reports, mediation |
| Money | 3 | Subscriptions, payments |
| Admin | 3 | Governance, audit logs |
| Analytics | 3 | Search logs, statistics |
| **Total** | **27** | **Production-ready** |

---

## 🔒 Legal Protection

All tables designed for **coordination marketplace**, not delivery liability:

- Orders = "coordination records" (not contracts)
- Tracking = informational only (not enforcement)
- Disputes = mediation (not judgments)
- Payments = platform fees only (not transaction guarantees)

---

## 📱 What's NOT in SQL

These are handled by Firebase:

- ❌ `conversations` - Use Firebase Realtime DB
- ❌ `messages` - Use Firebase Realtime DB  
- ❌ `notifications` - Use Firebase Cloud Messaging
- ❌ `push_tokens` - Use Firebase Cloud Messaging

**Why?** Real-time messaging is Firebase's strength. Keep SQL for business logic.

---

## 🎯 Next Steps

1. ✅ Schema created
2. ⏭️ Run `serverpod generate`
3. ⏭️ Run `serverpod create-migration`
4. ⏭️ Apply migrations to Docker
5. ⏭️ Create endpoint classes (CRUD operations)
6. ⏭️ Connect Flutter app to endpoints

---

## 🛠️ Improvements Over Original Design

1. **Firebase UID Link** - Connects Serverpod ↔ Firebase
2. **Multi-Role Users** - `roles: List<UserRole>` (client + driver possible)
3. **Type-Safe Enums** - 15 enums prevent string typos
4. **Multi-Language** - 4 languages (EN, AR, FR, ES)
5. **Soft Deletes** - `deletedAt` instead of hard delete
6. **Address System** - Separate table, multiple addresses per user
7. **City References** - Normalized city data
8. **Driver Statistics** - Pre-aggregated metrics
9. **System Settings** - Dynamic config without code changes
10. **Better Indexes** - Performance optimized

---

## 📞 Support

For questions, check:
- [Serverpod Docs](https://docs.serverpod.dev/)
- [Firebase Flutter](https://firebase.google.com/docs/flutter/setup)
