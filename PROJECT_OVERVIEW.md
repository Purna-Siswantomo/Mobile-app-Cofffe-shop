# Arpul Coffee Shop Mobile and Backend System

## Abstract / Description

Arpul Coffee Shop Mobile and Backend System adalah sistem operasional kedai kopi yang terdiri dari backend Laravel dan aplikasi mobile Flutter. Sistem ini dirancang untuk membantu proses administrasi, kasir, pengelolaan produk, pemantauan transaksi, pemrosesan pesanan, serta komunikasi realtime antara backend dan aplikasi mobile.

Backend Laravel menyediakan REST API untuk autentikasi, dashboard admin, produk, transaksi, laporan, manajemen user, notifikasi, pengaturan delivery, flow kasir, POS kasir, file storage publik, dan realtime event melalui Laravel Reverb. Aplikasi mobile Flutter menggunakan API tersebut untuk menyediakan antarmuka role-based bagi admin dan kasir. Admin dapat memantau ringkasan bisnis, mengelola produk termasuk upload gambar dan kategori, melihat laporan transaksi, mengatur user, notifikasi, dan delivery. Kasir dapat memproses order masuk, melihat bukti pembayaran, memverifikasi pembayaran, mengelola status order, membatalkan order dengan alasan, serta membuat transaksi POS cash.

Sistem ini dibangun dengan pendekatan mobile-first untuk operasional harian, namun tetap mempertahankan backend web Laravel sebagai pusat data, business logic, dan API service.

## Problem Statement

Operasional kedai kopi membutuhkan proses yang cepat, akurat, dan mudah dipantau. Tanpa sistem yang terintegrasi, beberapa masalah umum dapat terjadi:

- Admin sulit memantau transaksi, pendapatan, stok produk, dan order pending secara real-time.
- Kasir harus memproses order, pembayaran, dan status pesanan secara manual atau melalui alur yang terpisah.
- Data produk, transaksi, user, dan laporan berpotensi tidak konsisten jika tidak dikelola dari satu sumber backend.
- Bukti pembayaran QRIS, status order, dan flow delivery membutuhkan validasi yang jelas agar tidak terjadi kesalahan operasional.
- Sistem web saja kurang praktis untuk penggunaan kasir harian, terutama saat dibutuhkan perangkat mobile yang fleksibel.

Berdasarkan masalah tersebut, dibutuhkan sistem backend dan mobile yang saling terintegrasi, memiliki role access yang jelas, dan mendukung realtime update untuk proses order.

## Objectives

Tujuan utama project ini adalah membangun sistem operasional Arpul Coffee Shop yang dapat digunakan oleh admin dan kasir melalui aplikasi mobile dengan dukungan backend Laravel.

Tujuan spesifik:

- Menyediakan autentikasi berbasis Laravel Sanctum untuk role admin dan kasir.
- Menyediakan dashboard admin untuk melihat ringkasan transaksi, revenue, produk, dan order pending.
- Menyediakan fitur CRUD produk, termasuk dukungan gambar melalui URL, upload galeri/kamera dari mobile, dan kategori produk.
- Menyediakan laporan transaksi dengan filter, detail transaksi, dan ringkasan report.
- Menyediakan API admin untuk manajemen user, notifikasi, dan pengaturan delivery.
- Menyediakan flow kasir untuk melihat order, melihat bukti pembayaran, memverifikasi pembayaran, mengonfirmasi order, membatalkan order dengan alasan, mengatur delivery, dan menyelesaikan order.
- Menyediakan POS kasir untuk transaksi cash/walk-in.
- Menyediakan realtime update order menggunakan Laravel Reverb.
- Menyediakan aplikasi Flutter dengan UI konsisten berdasarkan design system yang sudah ditentukan.

## Methodology

Pengembangan project dilakukan dengan pendekatan bertahap berdasarkan pemisahan backend, mobile, dan integrasi.

### 1. Requirement Analysis

Tahap awal dilakukan dengan mengidentifikasi kebutuhan utama sistem berdasarkan role pengguna:

- Admin: dashboard, produk, laporan, user management, notification management, delivery setting.
- Kasir: order masuk, verifikasi pembayaran, status order, POS cash, realtime order.
- Backend: API, validasi data, autentikasi, role middleware, database, dan event broadcasting.

### 2. Backend Development

Backend dibangun menggunakan Laravel dengan beberapa komponen utama:

- REST API dengan base path `/api/v1`.
- Laravel Sanctum untuk autentikasi token.
- Middleware role untuk membatasi akses admin dan kasir.
- Controller API untuk auth, dashboard, product, transaction, order, admin user, notification, report, delivery setting, dan profile.
- Model dan relasi untuk user, product, transaction, transaction detail, notification, delivery, dan favorite.
- Laravel Reverb untuk realtime broadcasting.
- Queue worker untuk memproses event broadcast.
- Feature test untuk memastikan API berjalan sesuai kontrak.

### 3. Mobile Development

Aplikasi mobile dibangun menggunakan Flutter dengan arsitektur feature-based:

- `core` untuk network, constants, storage, services, dan model umum.
- `features/auth` untuk login, logout, profile, dan role guard.
- `features/admin` untuk dashboard, produk, laporan, user management, notification management, delivery setting, dan report summary.
- `features/kasir` untuk order flow, payment review, order status, POS, dan realtime order.
- `shared` untuk router, theme, widgets, dan utility.

State management menggunakan Riverpod, routing menggunakan GoRouter, HTTP client menggunakan Dio, dan model data menggunakan Freezed/json_serializable.

### 4. API Integration

Mobile diintegrasikan dengan backend melalui endpoint yang sudah disiapkan:

- Auth: `/auth/login`, `/auth/logout`, `/auth/me`, `/profile`
- Admin: `/dashboard`, `/products`, `/transactions`, `/reports/summary`, `/reports/export`, `/users`, `/notifications`, `/settings/delivery`
- Kasir: `/orders/*`, `/pos/products`, `/pos/transactions`
- Realtime: channel `orders` dengan event `new-order` dan `order-status-updated`

Integrasi dilakukan dengan repository layer agar UI tidak langsung bergantung pada detail HTTP request.

### 5. UI Design Implementation

Desain mobile disesuaikan dengan design system pada `frontend.md`, menggunakan:

- Primary color hijau gelap.
- Background terang.
- Surface putih dan container biru muda.
- Border tipis dan rounded card.
- Typography bersih dengan pendekatan dashboard operasional.
- Komponen UI berbasis card, status badge, tab, filter, dan action button.

Desain diterapkan agar sesuai dengan kebutuhan aplikasi operasional, bukan landing page atau tampilan promosi.

### 6. Testing and Validation

Validasi dilakukan melalui:

- Backend feature test menggunakan `php artisan test --testsuite=Feature --filter=Api`.
- Flutter static analysis menggunakan `flutter analyze`.
- Flutter unit/widget test menggunakan `flutter test`.
- Manual testing pada Android emulator atau HP fisik dengan backend lokal.
- Pengujian koneksi API, Reverb, dan queue worker untuk realtime order.

### 7. Deployment Preparation

Untuk development lokal, backend dijalankan melalui:

```bash
php artisan serve --host=0.0.0.0 --port=8001
php artisan reverb:start --host=0.0.0.0 --port=6001
php artisan queue:work
```

Mobile dijalankan melalui:

```bash
flutter run
```

Untuk perangkat Android fisik, API dan WebSocket diarahkan ke IP LAN komputer backend.
