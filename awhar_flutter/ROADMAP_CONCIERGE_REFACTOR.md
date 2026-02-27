# Roadmap: Intelligent "Concierge" Request Model Refactor

Current State: The app is built as a rigid "Courier/Logistics" service (Point A to Point B) using `AppColors`, `AppTypography`, and strict translation keys (`en.json`).
Target State: A flexible "Concierge/Errand" service (Buy X, Do Y, Fetch Z) where users state a need, negotiable price, and optional location constraints. Payment is Cash on Delivery (Driver pays upfront for goods, reimbursed by client).

---

## Technical Constraints & Standards (Analysis)

### 1. Theme Consistency (`AppColors` & `AppTypography`)
*   **Colors**: Use `AppColors.of(context)` (light/dark mode aware).
    *   `primary`: For main actions (Submit Request).
    *   `surface`: For card backgrounds.
    *   `textPrimary` / `textSecondary`: For inputs and labels.
    *   `warning`/`warningSoft`: For "Payment Required" or "Fragile" alerts.
*   **Typography**: Use `AppTypography` class.
    *   `AppTypography.titleMedium`: Section headers.
    *   `AppTypography.bodyMedium`: Input text.
    *   `AppTypography.bodySmall`: Hints (e.g., "Driver pays first").

### 2. Localization (`assets/translations/*.json`)
*   **Structure**: Nested keys (e.g., `request.concierge.what_to_buy`).
*   **New Keys Needed**:
    *   `request.concierge` section.
    *   `request.payment_info`: Explanation of "Reimbursement".
    *   `service_type.purchase`: Label for the new service.

### 3. Serverpod Protocol
*   **Current Issue**: `pickupLocation` is non-nullable in `service_request.yaml`.
*   **Fix**: Make `pickupLocation` nullable (`Location?`) to allow "Any Store" requests.

---

## Phase 1: Backend Protocol Restructuring
**Goal:** Loosen the database constraints to allow flexible requests without mandatory pickup locations or predefined categories.

- [x] **Update `ServiceType` Enum** (`awhar_server/lib/src/protocol/service_type.yaml`)
    - [x] Add `purchase`: "Buy something" (Grocery/Snacks).
    - [x] Add `task`: "General errand".
    - [x] *Analysis*: Keep `delivery` for backward compatibility.
- [x] **Update `ServiceRequest` Model** (`awhar_server/lib/src/protocol/service_request.yaml`)
    - [x] Change `pickupLocation: Location` to `pickupLocation: Location?` (Nullable).
    - [x] Add `estimatedPurchaseCost: double?` (Client's guess of item cost).
    - [x] Add `isPurchaseRequired: bool` (default=false).
    - [x] Add `shoppingList: List<String>?` (Structured items if simple description isnt enough).
    - [x] Add `attachments: List<String>?` (URLs for photo uploads).
- [x] **Run Serverpod Generation**
    - [x] Execute `dart run serverpod_cli generate` in `awhar_server`.
    - [x] Create migration: `dart run serverpod_cli create-migration`.
    - [x] Apply migration: `dart run bin/main.dart --apply-migrations`.

---

## Phase 2: Client "Request Creation" Experience
**Goal:** Create a smart, conversational-style form that adapts based on what the user wants, using `AppColors` and `GetX`.

- [x] **UI: "What do you need?" Input**
    - [x] Create `ConciergeInputWidget` using `AppColors.surface` and `AppTypography.bodyLarge`.
    - [x] Add photo attachment capability using `image_picker`.
- [x] **UI: Location Logic Strategy**
    - [x] Implement "Smart Location Toggle": 
        - *Option A*: "Anywhere nearby" (No Pickup Location required).
        - *Option B*: "Specific Place" (Opens Map Picker).
    - [x] Use `Iconsax` icons consistent with current design.
- [x] **State Management (GetX)**
    - [x] Update `RequestController`:
        - [x] Add `RxBool isPurchaseReq`.
        - [x] Add `RxDouble estimatedItemCost`.
        - [x] Handle null `pickupLocation` in validation logic.

---

## Phase 3: Driver Discovery & Acceptance Flow
**Goal:** Ensure drivers understand what is expected (e.g., "I need to buy this first") before accepting.

- [x] **Driver Request Card Redesign**
    - [x] Highlight `isPurchaseRequired` clearly with `AppColors.warning`.
    - [x] Display `estimatedPurchaseCost` vs `totalPrice` (Earnings).
- [x] **Proposal/Negotiation Logic**
    - [x] Update negotiation to allow Driver to correct the "Item Cost".
- [x] **Driver Screens Updated**
    - [x] AvailableRequestsScreen: Purchase indicators, flexible pickup badges
    - [x] DriverRequestDetailsScreen: Purchase details card with cost breakdown
    - [x] DriverRidesScreen: Flexible pickup display in history

---

## Phase 4: Active Request Management (The "Chat & Clarify" Phase)
**Goal:** Since requests are vague ("Buy snacks"), the Chat phase is critical for success.

- [x] **Enhanced Status Timeline**
    - [x] Created `StatusTimelineWidget` with purchase-specific steps
    - [x] Shows "At Store", "Purchasing items", "Out for Delivery" for purchase requests
    - [x] Integrated into `ClientActiveRequestScreen` with collapsible view
- [x] **Enhanced Active Request UI**
    - [x] Added purchase details card showing item description, costs breakdown
    - [x] Shows estimated item cost + delivery fee = total
    - [x] Payment notice explaining driver pays first, client reimburses
    - [x] Better map view with driver tracking
    - [x] Status timeline with visual progress indicator
- [x] **Enhanced Chat Interface**
    - [x] System message prompts drivers to confirm item costs when they arrive at the store.
- [x] **Finalizing the Order**
    - [x] "Complete Request" flow now asks drivers for the final receipt amount before closing.

---

## Implementation Summary

### ✅ **Completed**
- **Phase 1**: Backend protocol updated (nullable pickupLocation, purchase fields, migrations applied)
- **Phase 2**: Client UI rebuilt (ConciergeInputWidget, LocationModeToggle, CreateRequestScreen redesigned)
- **Phase 3**: Driver screens updated (purchase indicators, flexible pickup, cost breakdowns)
- **Phase 4**: Chat cost-confirmation, receipt capture, and enhanced active request UX delivered

### 🔄 **In Progress**
- None (Phase 4 is fully delivered)

### 📋 **Next Steps**
1. Run end-to-end tests of the purchase flow
2. Add photo upload for purchase verification (optional polish)
3. Collect driver/client feedback for further refinements

