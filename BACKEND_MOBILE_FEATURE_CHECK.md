# Cek Fitur Backend Arpul-Coffee-shop ke Arpul Mobile

Dokumen ini memetakan fitur dari backend Laravel `Arpul-Coffee-shop` yang sudah masuk atau belum masuk ke aplikasi Flutter `arpul_mobile`.

Sumber pengecekan:

- Backend: `routes/api.php`
- Backend: `routes/web.php`
- Backend API controllers: `app/Http/Controllers/Api`
- Backend events: `app/Events`
- Mobile constants, models, repositories, providers, screens, dan services

## Ringkasan Status

| Area Backend | Status di Mobile | Catatan |
|---|---|---|
| Auth API | Sudah masuk, perlu penyesuaian JSON key | Login/logout/me sudah dibuat, tapi response backend memakai `is_active` sedangkan mobile memakai `isActive`. |
| Admin Dashboard API | Sudah masuk, perlu penyesuaian JSON key | Backend memakai `total_transactions_today`, `total_revenue_today`, `total_products`, `pending_orders`; mobile model memakai nama Indonesia camelCase. |
| Products API | Sudah masuk, perlu penyesuaian JSON key/type | CRUD produk sudah dibuat, tapi backend memakai `image_url`, `created_at`, dan `price` sering berupa string decimal. |
| Orders Kasir API | Sudah masuk sebagian, perlu penyesuaian model | Pending/confirm/cancel/update status sudah dibuat, tapi backend memakai field `total`/`grand_total`, bukan `total_amount`. |
| Transactions API Admin | Endpoint ada, mobile belum punya screen/repository khusus | Mobile baru punya endpoint constant `/transactions`, belum ada transaction list/detail admin. |
| Reports Web | UI route mobile ada placeholder, API belum ada | Backend reports masih web route, belum ada API report untuk mobile. |
| Pusher Events | Sudah masuk, perlu mapping payload | Event `new-order` mengirim `transaction_id`, bukan `id`; mobile `OrderModel` butuh `id`. |
| Member Menu/Ordering | Belum masuk mobile | Backend fitur member masih web route, tidak ada API mobile. |
| Favorites | Belum masuk mobile | Backend web only. |
| Delivery | Belum masuk mobile | Backend web/kasir/member route, belum API mobile. |
| Payment QRIS Upload/Verify | Belum masuk mobile | Backend web route. |
| Admin User Management | Belum masuk mobile | Backend web route. |
| Admin Notification Management | Belum masuk mobile | Backend web route. |
| Profile Management | Belum masuk mobile | Backend web route. |

## API Backend yang Tersedia untuk Mobile

File backend:

```text
Arpul-Coffee-shop/routes/api.php
```

Base path:

```text
/api/v1
```

### Public

| Method | Endpoint | Backend | Mobile |
|---|---|---|---|
| POST | `/auth/login` | `Api\AuthController@login` | `AuthRepository.login()` |

### Authenticated

| Method | Endpoint | Backend | Mobile |
|---|---|---|---|
| POST | `/auth/logout` | `Api\AuthController@logout` | `AuthRepository.logout()` |
| GET | `/auth/me` | `Api\AuthController@me` | `AuthRepository.getProfile()` |

### Admin

| Method | Endpoint | Backend | Mobile |
|---|---|---|---|
| GET | `/dashboard` | `Api\DashboardController@index` | `DashboardRepository.getStats()` |
| GET | `/products` | `Api\ProductController@index` | `ProductRepository.getProducts()` |
| POST | `/products` | `Api\ProductController@store` | `ProductRepository.createProduct()` |
| GET | `/products/{id}` | `Api\ProductController@show` | `ProductRepository.getProduct()` |
| PUT | `/products/{id}` | `Api\ProductController@update` | `ProductRepository.updateProduct()` |
| DELETE | `/products/{id}` | `Api\ProductController@destroy` | `ProductRepository.deleteProduct()` |
| GET | `/transactions` | `Api\TransactionController@index` | Belum dibuat repository/screen khusus |
| GET | `/transactions/{id}` | `Api\TransactionController@show` | Belum dibuat repository/screen khusus |

### Kasir

| Method | Endpoint | Backend | Mobile |
|---|---|---|---|
| GET | `/orders/pending` | `Api\OrderController@pending` | `OrderRepository.getPendingOrders()` |
| POST | `/orders/{id}/confirm` | `Api\OrderController@confirm` | `OrderRepository.confirmOrder()` |
| POST | `/orders/{id}/cancel` | `Api\OrderController@cancel` | `OrderRepository.cancelOrder()` |
| PATCH | `/transactions/{id}/status` | `Api\TransactionController@updateStatus` | `OrderRepository.updateOrderStatus()` |

## Detail Per Fitur

## 1. Auth

### Backend

Controller:

```text
app/Http/Controllers/Api/AuthController.php
```

Endpoint:

```text
POST /api/v1/auth/login
POST /api/v1/auth/logout
GET  /api/v1/auth/me
```

Response login backend:

```json
{
  "status": "success",
  "message": "Login berhasil.",
  "data": {
    "token": "...",
    "token_type": "Bearer",
    "user": {
      "id": 2,
      "name": "Kasir Arpul",
      "email": "kasir@arpul.com",
      "role": "kasir",
      "is_active": true
    }
  }
}
```

### Mobile

Sudah masuk:

```text
lib/features/auth/data/models/user_model.dart
lib/features/auth/data/repositories/auth_repository.dart
lib/features/auth/presentation/providers/auth_provider.dart
lib/features/auth/presentation/screens/login_screen.dart
```

Status:

```text
Sebagian besar sudah masuk.
```

Catatan penting:

- Backend mengirim `is_active`.
- Mobile model saat ini memakai `isActive`.
- Tanpa `@JsonKey(name: 'is_active')`, parsing user dari backend bisa gagal.

Rekomendasi:

```dart
@JsonKey(name: 'is_active')
required bool isActive,
```

## 2. Admin Dashboard

### Backend

Controller:

```text
app/Http/Controllers/Api/DashboardController.php
```

Endpoint:

```text
GET /api/v1/dashboard
```

Response backend:

```json
{
  "data": {
    "total_transactions_today": 3,
    "total_revenue_today": 125000,
    "total_products": 12,
    "pending_orders": 2
  }
}
```

### Mobile

Sudah masuk:

```text
lib/features/admin/data/models/dashboard_stats_model.dart
lib/features/admin/data/repositories/dashboard_repository.dart
lib/features/admin/presentation/providers/dashboard_provider.dart
lib/features/admin/presentation/screens/admin_dashboard_screen.dart
```

Status:

```text
Sudah masuk, tetapi model perlu mapping JSON key.
```

Catatan:

- Backend memakai snake_case English.
- Mobile memakai:
  - `totalTransaksiHariIni`
  - `totalRevenueHariIni`
  - `totalProduk`
  - `orderPending`

Rekomendasi mapping:

```dart
@JsonKey(name: 'total_transactions_today')
required int totalTransaksiHariIni,

@JsonKey(name: 'total_revenue_today')
required double totalRevenueHariIni,

@JsonKey(name: 'total_products')
required int totalProduk,

@JsonKey(name: 'pending_orders')
required int orderPending,
```

## 3. Products

### Backend

Controller:

```text
app/Http/Controllers/Api/ProductController.php
```

Endpoint:

```text
GET    /api/v1/products
POST   /api/v1/products
GET    /api/v1/products/{id}
PUT    /api/v1/products/{id}
DELETE /api/v1/products/{id}
```

Response produk backend memakai:

```json
{
  "id": 1,
  "name": "Arpul Signature Espresso",
  "category": "Signature",
  "description": "...",
  "image_url": "https://...",
  "price": "18000.00",
  "stock": 100,
  "created_at": "2026-05-18T04:49:48.000000Z"
}
```

### Mobile

Sudah masuk:

```text
lib/features/admin/data/models/product_model.dart
lib/features/admin/data/repositories/product_repository.dart
lib/features/admin/presentation/providers/product_provider.dart
lib/features/admin/presentation/screens/product_list_screen.dart
lib/features/admin/presentation/screens/product_form_screen.dart
lib/features/admin/presentation/widgets/product_card.dart
```

Status:

```text
CRUD produk sudah masuk.
```

Catatan penting:

- Backend field `image_url`, mobile `imageUrl`.
- Backend field `created_at`, mobile `createdAt`.
- Backend `price` bisa berupa string `"18000.00"`, mobile `double`.
- Freezed generated default tidak otomatis parse string ke double.

Rekomendasi:

- Tambahkan `@JsonKey(name: 'image_url')`
- Tambahkan `@JsonKey(name: 'created_at')`
- Tambahkan converter untuk `price` dari string/double/int ke double

## 4. Orders Kasir

### Backend

Controller:

```text
app/Http/Controllers/Api/OrderController.php
app/Http/Controllers/Api/TransactionController.php
```

Endpoint:

```text
GET   /api/v1/orders/pending
POST  /api/v1/orders/{id}/confirm
POST  /api/v1/orders/{id}/cancel
PATCH /api/v1/transactions/{id}/status
```

Response pending order backend:

```json
{
  "id": 1,
  "user_id": 3,
  "payment_method": "qris",
  "total": "54000.00",
  "grand_total": "54000.00",
  "status": "pending",
  "created_at": "2026-05-18T05:00:00.000000Z",
  "details": []
}
```

### Mobile

Sudah masuk:

```text
lib/features/kasir/data/models/order_model.dart
lib/features/kasir/data/repositories/order_repository.dart
lib/features/kasir/presentation/providers/order_provider.dart
lib/features/kasir/presentation/screens/kasir_dashboard_screen.dart
lib/features/kasir/presentation/screens/order_detail_screen.dart
lib/features/kasir/presentation/widgets/order_card.dart
```

Status:

```text
Fitur kasir utama sudah masuk.
```

Catatan penting:

- Backend memakai `user_id`, mobile `userId`.
- Backend memakai `payment_method`, mobile `paymentMethod`.
- Backend memakai `created_at`, mobile `createdAt`.
- Backend tidak mengirim `total_amount`; backend mengirim `total` dan `grand_total`.
- Backend tidak mengirim `item_count` di endpoint pending, tetapi punya `details`.
- Status cancel backend adalah `canceled`, mobile label hanya mengenali `cancelled`.

Rekomendasi:

- Mapping `user_id`, `payment_method`, `created_at`.
- Hitung `itemCount` dari `details.length` jika `item_count` tidak ada.
- Ambil total dari `grand_total` atau `total`.
- Tambahkan label status `canceled`.
- Tambahkan model `OrderItemModel` untuk `details.product`.

## 5. Transaction Admin

### Backend

Endpoint:

```text
GET /api/v1/transactions
GET /api/v1/transactions/{id}
```

Role:

```text
admin
```

### Mobile

Status:

```text
Belum masuk sebagai fitur lengkap.
```

Yang sudah ada:

- Constant endpoint `/transactions`
- Route `/admin/reports` placeholder

Yang belum ada:

- `TransactionModel`
- `TransactionRepository`
- Admin transaction list screen
- Admin transaction detail screen
- Filter status/date/from_date/to_date
- Report integration dari transaksi

## 6. Reports

### Backend

Di `routes/web.php`:

```text
GET  /reports
POST /reports/export
GET  /admin/reports
POST /admin/reports/export
```

### Mobile

Status:

```text
Belum masuk.
```

Yang ada di mobile:

```text
/admin/reports -> ReportScreen placeholder
```

Catatan:

- Backend reports masih web/Blade route.
- Belum ada API `/api/v1/reports`.

Rekomendasi:

- Buat API report di backend jika ingin fitur reports mobile.

## 7. Pusher Real-Time Order

### Backend

Events:

```text
app/Events/NewOrderReceived.php
app/Events/OrderStatusUpdated.php
```

Channel:

```text
orders
```

Events:

```text
new-order
order-status-updated
```

Payload `new-order`:

```json
{
  "transaction_id": 15,
  "total_amount": 54000,
  "item_count": 2,
  "created_at": "2026-05-18T05:00:00.000000Z"
}
```

Payload `order-status-updated`:

```json
{
  "transaction_id": 15,
  "old_status": "pending",
  "new_status": "confirmed",
  "updated_at": "2026-05-18T05:10:00.000000Z"
}
```

### Mobile

Sudah masuk:

```text
lib/core/services/pusher_service.dart
lib/shared/widgets/connection_indicator.dart
```

Status:

```text
Sudah masuk, tetapi payload new-order perlu adapter.
```

Catatan penting:

- Mobile `OrderModel` butuh `id`.
- Backend Pusher mengirim `transaction_id`.
- Backend Pusher mengirim `total_amount`, sesuai mobile.
- Backend Pusher tidak mengirim `status`; mobile `OrderModel` butuh `status`.
- Backend Pusher tidak mengirim `payment_method`; mobile nullable aman.

Rekomendasi:

Saat menerima `new-order`, ubah payload:

```text
transaction_id -> id
status default -> pending
```

Atau setelah event `new-order`, langsung invalidate `pendingOrdersProvider` agar mobile fetch ulang dari API.

## 8. Delivery

### Backend

Ada fitur delivery di web routes:

```text
Admin delivery settings
Kasir delivery management
Member delivery checkout
```

Controller:

```text
app/Http/Controllers/DeliveryController.php
app/Http/Controllers/Cashier/DeliveryController.php
app/Http/Controllers/Admin/DeliverySettingController.php
```

### Mobile

Status:

```text
Belum masuk.
```

Catatan:

- Belum ada API mobile untuk delivery.
- Belum ada screen mobile delivery.

## 9. Payment QRIS

### Backend

Route web:

```text
GET  /payment/{transaction}
POST /payment/{transaction}/upload
POST /transactions/{transaction}/payment/verify
POST /transactions/{transaction}/payment/reject
```

### Mobile

Status:

```text
Belum masuk.
```

Catatan:

- Belum ada API mobile untuk upload/verifikasi bukti pembayaran.

## 10. Member Menu, Cart, Favorites, My Orders

### Backend

Route web:

```text
GET    /menu
POST   /menu/add-to-cart
POST   /menu/update-cart-quantity
POST   /menu/remove-from-cart
POST   /menu/place-order
GET    /my-orders
GET    /favorites
POST   /favorites/toggle/{product}
POST   /favorites/add/{product}
DELETE /favorites/remove/{product}
```

### Mobile

Status:

```text
Belum masuk.
```

Catatan:

- Mobile saat ini hanya role admin dan kasir.
- Role member belum dibuat di mobile.

## 11. Admin User Management

### Backend

Route web:

```text
admin/users
admin/users/{user}/toggle
```

### Mobile

Status:

```text
Belum masuk.
```

Catatan:

- Belum ada API mobile untuk user management.

## 12. Admin Notification Management

### Backend

Route web:

```text
admin/notifications
admin/notifications/{notification}/toggle
admin/notifications/broadcast
notifications/{notification}/dismiss
```

### Mobile

Status:

```text
Belum masuk.
```

Catatan:

- Mobile hanya menerima real-time order via Pusher.
- Notification management belum dibuat.

## 13. Profile Management

### Backend

Route web:

```text
GET    /profile
PATCH  /profile
DELETE /profile
```

### Mobile

Status:

```text
Belum masuk.
```

Catatan:

- Mobile hanya punya auth login/logout/me.

## Masalah Integrasi Utama yang Perlu Diperbaiki

## A. JSON Key Mismatch

Backend memakai snake_case, mobile model memakai camelCase.

Perlu diperbaiki di:

```text
UserModel
ProductModel
DashboardStatsModel
OrderModel
```

Contoh:

```text
is_active -> isActive
image_url -> imageUrl
created_at -> createdAt
user_id -> userId
payment_method -> paymentMethod
total_transactions_today -> totalTransaksiHariIni
```

## B. Numeric String dari Backend

Backend sering mengirim decimal sebagai string:

```json
"price": "18000.00"
"total": "54000.00"
"grand_total": "54000.00"
```

Mobile model memakai `double`.

Perlu converter:

```text
String/int/double -> double
```

## C. Order Detail Item Belum Dimodelkan

Backend mengirim:

```text
details[].product
details[].quantity
details[].subtotal
```

Mobile belum punya:

```text
OrderItemModel
```

Dampak:

- `OrderDetailScreen` masih placeholder untuk item pesanan.

## D. Status Cancel Berbeda

Backend memakai:

```text
canceled
```

Mobile memakai label:

```text
cancelled
```

Perlu dukung dua-duanya.

## E. Pusher Payload Mismatch

Backend `new-order` mengirim:

```text
transaction_id
```

Mobile butuh:

```text
id
```

Solusi:

- map `transaction_id` ke `id`, atau
- event hanya memicu refresh pending orders.

## Kesimpulan

Fitur backend yang sudah masuk ke mobile:

- Auth login/logout/profile
- Admin dashboard
- Product CRUD
- Kasir pending order
- Kasir confirm/cancel order
- Kasir update status transaction
- Pusher real-time order event
- Role-based routing admin/kasir

Fitur backend yang belum masuk ke mobile:

- Admin transaction list/detail
- Reports API/full report screen
- Member menu/cart/order
- Favorites
- Delivery management
- Payment upload/verification
- Admin user management
- Admin notification management
- Profile edit/delete

Prioritas perbaikan sebelum integrasi live:

1. Perbaiki JSON mapping model mobile.
2. Tambahkan converter decimal string ke double.
3. Tambahkan `OrderItemModel` dan mapping `details`.
4. Sesuaikan Pusher payload `transaction_id`.
5. Tambahkan repository/screen transactions dan reports jika dibutuhkan admin mobile.
