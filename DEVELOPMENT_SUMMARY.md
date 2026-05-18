# Dokumentasi Pembangunan Arpul Mobile

## Ringkasan Proyek

**Arpul Mobile** adalah aplikasi Flutter untuk operasional kedai kopi Arpul. Aplikasi ini dibangun untuk dua role utama:

- **Admin**: melihat dashboard, mengelola produk, dan membuka halaman laporan.
- **Kasir**: menerima order masuk, melihat daftar order pending, mengonfirmasi order, dan membatalkan order.

Lokasi project:

```text
C:\Users\Purna Siswantomo\Documents\bekas project\arpul_mobile
```

Backend yang diasumsikan:

```text
http://10.0.2.2:8000/api/v1
```

`10.0.2.2` digunakan agar Android emulator dapat mengakses localhost dari komputer host.

## Inisialisasi Project

Project dibuat dengan command:

```bash
flutter create arpul_mobile --org com.arpul --platforms android,ios
```

Dependencies utama yang ditambahkan:

- `dio`
- `pretty_dio_logger`
- `flutter_riverpod`
- `riverpod_annotation`
- `flutter_secure_storage`
- `go_router`
- `json_annotation`
- `freezed_annotation`
- `pusher_channels_flutter`
- `cached_network_image`
- `intl`
- `shimmer`
- `build_runner`
- `json_serializable`
- `freezed`
- `riverpod_generator`
- `flutter_lints`

`flutter pub get` berhasil tanpa dependency conflict.

## Constants

File constants yang dibuat:

```text
lib/core/constants/api_constants.dart
lib/core/constants/app_constants.dart
lib/core/constants/pusher_constants.dart
```

Konfigurasi penting:

- Base URL development: `http://10.0.2.2:8000/api/v1`
- Base URL production placeholder: `https://your-domain.com/api/v1`
- Endpoint auth, dashboard, produk, transaksi, dan order
- App name: `Arpul`
- Token key: `sanctum_token`
- User key: `user_data`
- Role: `admin`, `kasir`
- Timeout request: 15 detik
- Pusher channel: `orders`
- Pusher event:
  - `new-order`
  - `order-status-updated`

## Core Layer

### Secure Storage

File:

```text
lib/core/storage/secure_storage.dart
```

Fitur:

- Simpan token
- Ambil token
- Hapus token
- Simpan user JSON
- Ambil user JSON
- Clear semua storage saat logout
- Backend storage dapat dioverride untuk unit test

### Network Layer

File:

```text
lib/core/network/dio_client.dart
lib/core/network/app_exception.dart
```

`DioClient` berisi:

- Base URL dari `ApiConstants`
- Timeout dari `AppConstants`
- Default header JSON
- `AuthInterceptor` untuk menambahkan Bearer token
- `ErrorInterceptor` untuk mapping error menjadi `AppException`
- Auto delete token saat response `401`
- `PrettyDioLogger` hanya di debug mode

`AppException` berisi:

- `UnauthorizedException`
- `ForbiddenException`
- `NotFoundException`
- `ValidationException`
- `ServerException`
- `NetworkException`
- `UnknownException`

## Data Models

Model dibuat menggunakan Freezed dan json_serializable.

File:

```text
lib/features/auth/data/models/user_model.dart
lib/features/admin/data/models/product_model.dart
lib/features/kasir/data/models/order_model.dart
lib/features/admin/data/models/dashboard_stats_model.dart
lib/core/models/api_response_model.dart
```

Model yang dibuat:

- `UserModel`
  - `id`
  - `name`
  - `email`
  - `role`
  - `isActive`
  - getter `isAdmin`
  - getter `isKasir`

- `ProductModel`
  - `id`
  - `name`
  - `category`
  - `description`
  - `price`
  - `stock`
  - `imageUrl`
  - `createdAt`

- `OrderModel`
  - `id`
  - `userId`
  - `totalAmount`
  - `status`
  - `paymentMethod`
  - `createdAt`
  - `itemCount`
  - getter `statusLabel`

- `DashboardStatsModel`
  - `totalTransaksiHariIni`
  - `totalRevenueHariIni`
  - `totalProduk`
  - `orderPending`

- `ApiResponseModel<T>`
  - Generic response wrapper untuk API

`build_runner` sudah berhasil dijalankan untuk generate file `.freezed.dart` dan `.g.dart`.

## Repository Layer

File repository:

```text
lib/features/auth/data/repositories/auth_repository.dart
lib/features/admin/data/repositories/product_repository.dart
lib/features/admin/data/repositories/dashboard_repository.dart
lib/features/kasir/data/repositories/order_repository.dart
```

Repository yang dibuat:

### AuthRepository

Fungsi:

- `login(String email, String password)`
- `logout()`
- `getProfile()`

Saat login berhasil:

- token disimpan ke `SecureStorage`
- data user disimpan sebagai JSON string

### ProductRepository

Fungsi:

- `getProducts({int page = 1})`
- `getProduct(int id)`
- `createProduct(Map<String, dynamic> data)`
- `updateProduct(int id, Map<String, dynamic> data)`
- `deleteProduct(int id)`

### DashboardRepository

Fungsi:

- `getStats()`

### OrderRepository

Fungsi:

- `getPendingOrders()`
- `confirmOrder(int id)`
- `cancelOrder(int id, String reason)`
- `updateOrderStatus(int id, String status)`

Semua repository menggunakan `DioClient`, melakukan parsing JSON ke model, dan melempar `AppException` saat error.

## Riverpod Providers

Provider dibuat menggunakan Riverpod code generation.

File:

```text
lib/features/auth/presentation/providers/auth_provider.dart
lib/features/admin/presentation/providers/product_provider.dart
lib/features/admin/presentation/providers/dashboard_provider.dart
lib/features/kasir/presentation/providers/order_provider.dart
```

Provider utama:

- `authRepositoryProvider`
- `authStateProvider`
- `productRepositoryProvider`
- `productsProvider`
- `productDetailProvider`
- `dashboardRepositoryProvider`
- `dashboardStatsProvider`
- `orderRepositoryProvider`
- `pendingOrdersProvider`

Fitur provider:

- Auth bootstrap dari token secure storage
- Login/logout
- Role helper admin/kasir
- Auto refresh dashboard stats setiap 30 detik
- Fetch pending orders
- Optimistic update saat confirm/cancel order
- Add new order dari Pusher

## Routing

Routing dibuat menggunakan GoRouter.

File:

```text
lib/shared/router/app_router.dart
```

Routes:

```text
/login
/kasir
/kasir/orders
/kasir/orders/:id
/admin
/admin/products
/admin/products/create
/admin/products/:id/edit
/admin/reports
```

Route guard:

- Jika belum login, redirect ke `/login`
- Jika sudah login dan membuka `/login`, redirect sesuai role
- Jika kasir membuka `/admin/*`, redirect ke `/kasir`
- Jika admin membuka `/kasir/*`, redirect ke `/admin`

`main.dart` sudah menggunakan:

- `ProviderScope`
- `MaterialApp.router`
- `GoRouter`
- Locale `id_ID`
- `AppTheme.lightTheme`
- `AppTheme.darkTheme`

## Theme dan Shared Widgets

### Theme

File:

```text
lib/shared/theme/app_theme.dart
```

Brand color:

- Primary: coklat kopi `#4A2C2A`
- Secondary: krem/beige `#D4A373`
- Accent: oranye hangat `#E76F51`

Theme yang dibuat:

- Light theme
- Dark theme
- Text theme yang mudah dibaca
- Card rounded 12px
- Elevated button style konsisten
- Input decoration style

### Shared Widgets

File:

```text
lib/shared/widgets/loading_widget.dart
lib/shared/widgets/app_error_widget.dart
lib/shared/widgets/empty_state_widget.dart
lib/shared/widgets/status_badge.dart
lib/shared/widgets/connection_indicator.dart
lib/shared/utils/currency_formatter.dart
```

Fungsi:

- Shimmer loading list/card
- Error state dengan tombol retry
- Empty state
- Badge status order
- Indicator koneksi real-time
- Formatter Rupiah: `Rp 1.500.000`

## Auth Screen

File:

```text
lib/features/auth/presentation/screens/login_screen.dart
```

Fitur:

- Logo/nama Arpul
- Form email dan password
- Password show/hide toggle
- Validasi email wajib format email
- Validasi password minimal 6 karakter
- Tombol `Masuk` dengan loading state
- Error SnackBar dari `AppException`
- Keyboard overlap ditangani dengan `SingleChildScrollView`
- Redirect otomatis setelah login sukses melalui GoRouter route guard

## Kasir Screens

### Kasir Dashboard

File:

```text
lib/features/kasir/presentation/screens/kasir_dashboard_screen.dart
```

Fitur:

- AppBar `Kasir - Arpul`
- Tombol logout
- Badge counter order pending
- Indicator koneksi real-time
- Banner `Mode offline` saat Pusher disconnected
- List pending order
- Pull-to-refresh
- Shimmer loading
- Empty state

### Order Card

File:

```text
lib/features/kasir/presentation/widgets/order_card.dart
```

Fitur:

- Nomor order
- Total Rupiah
- Jumlah item
- Waktu masuk
- Status badge
- Tombol `Konfirmasi`
- Tombol `Batalkan`
- Dialog konfirmasi sebelum aksi

### Order Detail

File:

```text
lib/features/kasir/presentation/screens/order_detail_screen.dart
```

Fitur:

- Detail order
- Status badge
- Total
- Jumlah item
- Metode pembayaran
- Waktu masuk
- Tombol aksi sesuai status
- Section item pesanan masih placeholder karena `OrderModel` belum memiliki field daftar item

## Admin Screens

### Admin Dashboard

File:

```text
lib/features/admin/presentation/screens/admin_dashboard_screen.dart
```

Fitur:

- AppBar `Dashboard - Arpul`
- Tombol logout
- Grid 2x2 stat cards:
  - Total transaksi hari ini
  - Revenue hari ini
  - Total produk
  - Order pending
- Warna accent berbeda per card
- Tombol navigasi ke Products
- Tombol navigasi ke Reports
- Auto-refresh dari `dashboardStatsProvider` setiap 30 detik

### Product List

File:

```text
lib/features/admin/presentation/screens/product_list_screen.dart
lib/features/admin/presentation/widgets/product_card.dart
```

Fitur:

- AppBar produk
- Tombol tambah produk
- FAB tambah produk
- GridView 2 kolom
- ProductCard berisi:
  - gambar produk via `CachedNetworkImage`
  - nama produk
  - kategori
  - harga Rupiah
  - stok
  - tombol edit
  - tombol hapus
- Pull-to-refresh
- Shimmer loading
- Empty state
- Dialog konfirmasi sebelum hapus

### Product Form

File:

```text
lib/features/admin/presentation/screens/product_form_screen.dart
```

Fitur:

- Mode create
- Mode edit berdasarkan route parameter
- Field:
  - nama
  - kategori
  - deskripsi
  - harga
  - stok
- Placeholder upload gambar
- Validasi field wajib
- Tombol `Simpan` dengan loading state
- Setelah simpan berhasil:
  - pop screen
  - invalidate `productsProvider`

## Real-Time Pusher

File:

```text
lib/core/services/pusher_service.dart
```

Fitur:

- Singleton pattern
- `init()`
- `disconnect()`
- Subscribe channel `orders`
- Event `new-order`:
  - parse payload ke `OrderModel`
  - panggil `pendingOrdersProvider.notifier.addNewOrder(order)`
- Event `order-status-updated`:
  - invalidate `pendingOrdersProvider`
- Log status koneksi
- Error handling tidak crash aplikasi
- Status koneksi:
  - connecting
  - connected
  - disconnected
- `PusherService.mock()` untuk fake order setiap 10 detik saat development

Kasir dashboard sudah:

- memanggil `PusherService().init()` di `initState`
- memanggil `PusherService().disconnect()` di `dispose`
- menampilkan connection indicator
- menampilkan banner offline

## Android Configuration

File:

```text
android/app/src/main/AndroidManifest.xml
```

Permission yang ditambahkan:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
```

Untuk development HTTP localhost:

```xml
android:usesCleartextTraffic="true"
```

Catatan: untuk production harus menggunakan HTTPS dan cleartext traffic sebaiknya dinonaktifkan.

## Testing

Unit test dibuat:

```text
test/unit/auth_repository_test.dart
test/unit/order_notifier_test.dart
```

Auth repository test:

- login berhasil return `UserModel` dan simpan token
- login gagal throw `UnauthorizedException`
- logout berhasil clear token dari storage

Order notifier test:

- fetch pending orders berhasil
- confirmOrder update state optimistically
- addNewOrder menambah item ke list

Widget smoke test:

```text
test/widget_test.dart
```

Test terakhir:

```text
00:00 +0: loading ... auth_repository_test.dart
00:00 +0: login berhasil return UserModel dan simpan token
00:00 +1: login gagal throw UnauthorizedException
00:00 +2: logout berhasil clear token dari storage
00:00 +3: fetch pending orders berhasil
00:00 +4: confirmOrder update state optimistically
00:00 +5: addNewOrder menambah item ke list
00:00 +6: shows login screen for unauthenticated user
00:01 +7: All tests passed!
```

## Analyze dan Build

Analyze terakhir:

```text
Analyzing arpul_mobile...
No issues found! (ran in 1.7s)
```

Build APK debug:

```bash
flutter build apk --debug
```

Output:

```text
√ Built build\app\outputs\flutter-apk\app-debug.apk
```

Ada warning Java source/target 8 dari Gradle/dependency, tetapi build tetap berhasil.

## README

README dibuat di:

```text
README.md
```

Berisi:

- cara setup
- konfigurasi URL API
- cara run emulator
- cara build APK debug
- credential testing admin/kasir
- catatan Pusher setup
- catatan cleartext traffic untuk development

## Status Akhir

Aplikasi sudah berada pada tahap **MVP mobile app siap integrasi backend**.

Yang sudah selesai:

- Setup project Flutter
- Dependency management
- Constants
- Secure storage
- Dio client
- Error handling
- Model Freezed
- Repository layer
- Riverpod provider
- GoRouter dengan role guard
- Theme brand Arpul
- Shared widgets
- Login screen
- Kasir dashboard
- Order card
- Order detail
- Admin dashboard
- Product list
- Product form
- Pusher real-time service
- Android permission
- Unit test
- README
- Debug APK build

## Lanjutan yang Direkomendasikan

Pekerjaan berikutnya:

- Integrasi langsung dengan backend Laravel live
- Sesuaikan parsing JSON jika response backend berbeda
- Tambahkan model detail item order
- Implementasi reports screen penuh
- Implementasi upload gambar produk
- Konfigurasi Pusher key asli
- Setup environment dev/prod
- Build release APK/AAB
- Konfigurasi app signing
- Production hardening:
  - HTTPS wajib
  - nonaktifkan cleartext traffic
  - validasi token/session lebih lengkap
  - logging production dikurangi
