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
| Auth API | Sudah sesuai | Login/logout/me sudah dibuat dan `is_active` sudah dimapping ke `isActive`. |
| Admin Dashboard API | Sudah sesuai | Field dashboard snake_case backend sudah dimapping ke model mobile. |
| Products API | Sudah sesuai untuk CRUD JSON dan multipart | CRUD produk sudah dibuat, `image_url`, `gambar_url`, upload gambar file, kategori, `created_at`, dan decimal string `price` sudah ditangani. |
| Orders Kasir API | Sudah masuk cukup lengkap | Pending review, ready-to-confirm, in-progress, verify/reject payment, confirm, deliver, complete, cancel, dan POS sudah dibuat. |
| Transactions API Admin | Sudah masuk sebagian besar | `TransactionModel`, repository, provider, filter report, list, dan detail transaksi sudah ada. |
| Reports API Admin | Backend siap, mobile sebagian | Backend punya `/reports/summary` dan `/reports/export`; mobile masih memakai `/transactions` untuk laporan dasar. |
| Reverb Events | Sudah masuk | Mobile memakai `web_socket_channel` ke Laravel Reverb dan `OrderModel` sudah menerima `transaction_id` sebagai id. |
| Member Menu/Ordering | Belum masuk mobile | Backend fitur member masih web route, tidak ada API mobile. |
| Favorites | Belum masuk mobile | Backend web only. |
| Delivery | Masuk sebagian | Mobile kasir bisa membaca data delivery dan mengubah status deliver/complete; backend admin delivery setting API sudah ada, mobile admin belum. |
| Payment QRIS Upload/Verify | Masuk sebagian | Upload bukti masih dari web/member, tetapi kasir mobile sudah bisa melihat popup bukti pembayaran, verify, dan reject bukti pembayaran. |
| Admin User Management | Backend API siap, mobile belum | API `/users` sudah tersedia untuk list/create/detail/update/toggle/delete. |
| Admin Notification Management | Backend API siap, mobile belum | API `/notifications` dan `/notifications/broadcast` sudah tersedia. |
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
| GET | `/transactions` | `Api\TransactionController@index` | `TransactionRepository.getTransactions()` dan `ReportScreen` |
| GET | `/transactions/{id}` | `Api\TransactionController@show` | `TransactionRepository.getTransaction()`, belum ada UI detail penuh |

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
GET    /api/v1/products/categories
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

Untuk produk dengan file upload, backend juga mengirim:

```json
{
  "image": "products/example.jpg",
  "gambar_url": "/api/v1/public/storage/products/example.jpg"
}
```

`gambar_url` dapat berupa URL eksternal jika produk dibuat memakai `image_url`, atau path publik API jika gambar berasal dari upload.

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
CRUD produk sudah masuk, termasuk upload gambar dari galeri/kamera dan kategori.
```

Catatan penting:

- Backend field `image_url`, mobile `imageUrl`.
- Backend field `created_at`, mobile `createdAt`.
- Backend `price` bisa berupa string `"18000.00"`, mobile `double`.
- Freezed generated default tidak otomatis parse string ke double.
- Upload file dikirim sebagai `multipart/form-data` field `image`.
- Kategori diambil dari `/products/categories`. Tambah kategori di mobile menambahkan pilihan lokal, lalu kategori tersimpan saat produk dibuat/disimpan.

Status rekomendasi integrasi:

- Mapping `image_url`, `created_at`, dan converter numeric sudah diterapkan.
- `gambar_url` dinormalisasi untuk render gambar produk.
- Kategori belum punya CRUD/tabel mandiri; backend masih memakai field `products.category`.

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
GET   /api/v1/orders/pending-review
GET   /api/v1/orders/ready-to-confirm
GET   /api/v1/orders/in-progress
GET   /api/v1/orders/{id}
POST  /api/v1/orders/{id}/payment/verify
POST  /api/v1/orders/{id}/payment/reject
POST  /api/v1/orders/{id}/confirm
POST  /api/v1/orders/{id}/deliver
POST  /api/v1/orders/{id}/complete
POST  /api/v1/orders/{id}/cancel
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
- Status cancel backend adalah `canceled`; mobile sekarang mengenali `canceled` dan `cancelled`.
- Cancel API idempotent: jika order sudah `canceled/cancelled`, backend membalas sukses agar request ganda tidak memunculkan error palsu.
- `payment_proof_url` memakai `/api/v1/public/storage/{path}` agar gambar bukti pembayaran bisa dibuka dari mobile.

Status rekomendasi integrasi:

- Mapping `user_id`, `payment_method`, `created_at`, `payment_status`, `order_type`, dan `delivery` sudah masuk.
- `itemCount` dihitung dari `item_count` atau `details.length`.
- Total dibaca dari `total_amount`, `grand_total`, atau `total`.
- Model detail order dan product summary sudah dibuat.

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
Sudah masuk sebagai fitur dasar.
```

Yang sudah ada:

- Constant endpoint `/transactions`
- `TransactionModel`
- `TransactionRepository`
- `transactionProvider`
- Route `/admin/reports`
- `ReportScreen` yang menampilkan daftar transaksi dari `/transactions`

Yang belum ada:

- Admin transaction detail screen
- Filter status/date/from_date/to_date
- Export report
- UI report yang setara dengan laporan web backend

## 6. Reports

### Backend

Di `routes/web.php`:

```text
GET  /reports
POST /reports/export
GET  /admin/reports
POST /admin/reports/export
```

Di `routes/api.php`:

```text
GET /api/v1/reports/summary
GET /api/v1/reports/export
```

### Mobile

Status:

```text
Masuk sebagian.
```

Yang ada di mobile:

```text
/admin/reports -> ReportScreen daftar transaksi dari endpoint /transactions
```

Catatan:

- Backend reports masih web/Blade route.
- API mobile untuk summary/export rows sudah ada.
- Mobile memakai `/api/v1/transactions` sebagai laporan dasar.

Rekomendasi:

- Hubungkan mobile report ke `/api/v1/reports/summary` untuk ringkasan dan chart.
- Gunakan `/api/v1/reports/export` untuk data export rows di mobile.

## 7. Laravel Reverb Real-Time Order

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
lib/core/constants/websocket_constants.dart
lib/core/services/laravel_websocket_service.dart
lib/shared/widgets/connection_indicator.dart
```

Status:

```text
Sudah masuk.
```

Catatan penting:

- Mobile `OrderModel` sudah membaca `transaction_id` sebagai `id`.
- Backend Reverb event mengirim `total_amount`, sesuai mobile.
- Backend event tidak mengirim `status`; mobile memberi default `pending`.
- Backend Reverb event tidak mengirim `payment_method`; mobile nullable aman.

Rekomendasi:

Saat menerima `new-order`, mobile sekarang bisa langsung parse payload. Untuk data penuh, mobile juga tetap melakukan polling fallback dan invalidate provider pada event status.

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
Masuk sebagian untuk order delivery kasir.
```

Catatan:

- `OrderModel` sudah punya `delivery`.
- Kasir bisa menandai delivery order sebagai `delivering` dan `completed`.
- Backend API admin untuk setting delivery sudah tersedia:

```text
GET   /api/v1/settings/delivery
PATCH /api/v1/settings/delivery
```

- Mobile admin untuk setting delivery belum dibuat.

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
Masuk sebagian.
```

Catatan:

- Mobile kasir sudah memakai API verify/reject pembayaran.
- Mobile kasir sudah menampilkan `payment_proof_url` jika tersedia.
- Upload bukti pembayaran dari sisi member/customer mobile belum ada karena mobile member belum dibuat.

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

Route API:

```text
GET    /api/v1/users
POST   /api/v1/users
GET    /api/v1/users/{id}
PUT    /api/v1/users/{id}
PATCH  /api/v1/users/{id}/toggle
DELETE /api/v1/users/{id}
```

### Mobile

Status:

```text
Backend API siap, mobile belum masuk.
```

Catatan:

- API mendukung search, role, status, stats, create, update, toggle active, delete, dan detail user.
- Mobile admin screen/repository/provider belum dibuat.

## 12. Admin Notification Management

### Backend

Route web:

```text
admin/notifications
admin/notifications/{notification}/toggle
admin/notifications/broadcast
notifications/{notification}/dismiss
```

Route API:

```text
GET    /api/v1/notifications
POST   /api/v1/notifications
POST   /api/v1/notifications/broadcast
GET    /api/v1/notifications/{id}
PUT    /api/v1/notifications/{id}
PATCH  /api/v1/notifications/{id}/toggle
DELETE /api/v1/notifications/{id}
```

### Mobile

Status:

```text
Backend API siap, mobile belum masuk.
```

Catatan:

- Mobile menerima real-time order via Laravel Reverb.
- Notification management mobile admin belum dibuat.

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

## C. Order Detail Item

Backend mengirim:

```text
details[].product
details[].quantity
details[].subtotal
```

Mobile sudah punya:

```text
OrderItemModel
```

Dampak:

- `OrderDetailScreen` dapat menampilkan item pesanan jika `details` dikirim backend.
- Jika `details` kosong, mobile menampilkan empty state.

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

## E. Reverb Payload

Backend `new-order` mengirim:

```text
transaction_id
```

Mobile membaca:

```text
id
```

Solusi:

- `OrderModel` sudah map `transaction_id` ke `id`.
- Provider tetap di-refresh pada event status agar list sesuai backend.

## Kesimpulan

Fitur backend yang sudah masuk ke mobile:

- Auth login/logout/profile
- Admin dashboard
- Product CRUD
- Kasir pending order
- Kasir confirm/cancel order
- Kasir update status transaction
- Laravel Reverb real-time order event
- Role-based routing admin/kasir

Fitur backend yang belum masuk ke mobile:

- Admin transaction list/detail
- Reports API/full report screen
- Member menu/cart/order
- Favorites
- Delivery management penuh
- Payment proof upload dari customer mobile
- Admin user management
- Admin notification management
- Profile edit/delete

Prioritas perbaikan sebelum integrasi live:

1. Perbaiki JSON mapping model mobile.
2. Tambahkan converter decimal string ke double.
3. Tambahkan `OrderItemModel` dan mapping `details`.
4. Uji realtime end-to-end dengan API server, Reverb server, dan queue worker aktif.
5. Lengkapi filter/detail/export transaksi untuk admin mobile.
