# Status Perkembangan Project Arpul

Dokumen ini menjelaskan sejauh mana project **Arpul Mobile** dan backend **Arpul-Coffee-shop** sudah berjalan. Status ini dibuat sebagai catatan dokumentasi karena project belum selesai sepenuhnya, terutama pada bagian flow order di mobile.

## Ringkasan

Project sudah memiliki fondasi backend Laravel dan aplikasi Flutter mobile untuk role **admin** dan **kasir**. Mobile sudah bisa login, membaca role user, mengakses endpoint API utama, menampilkan dashboard admin, menampilkan produk, dan menerima order pending untuk kasir.

Namun aplikasi belum bisa dianggap selesai. Bagian mobile untuk kasir masih perlu dilengkapi, terutama detail proses order, bukti pembayaran/order, validasi status, dan workflow kasir setelah order diterima.

## Kondisi Backend

Backend berada di:

```text
Arpul-Coffee-shop
```

Backend menggunakan Laravel dan sudah menyediakan API untuk mobile dengan base path:

```text
/api/v1
```

Endpoint utama yang sudah tersedia:

```text
POST   /api/v1/auth/login
POST   /api/v1/auth/logout
GET    /api/v1/auth/me
GET    /api/v1/dashboard
GET    /api/v1/products
POST   /api/v1/products
GET    /api/v1/products/{id}
PUT    /api/v1/products/{id}
DELETE /api/v1/products/{id}
GET    /api/v1/orders/pending
POST   /api/v1/orders/{id}/confirm
POST   /api/v1/orders/{id}/cancel
GET    /api/v1/transactions
GET    /api/v1/transactions/{id}
PATCH  /api/v1/transactions/{id}/status
```

Backend juga sudah disiapkan untuk realtime order menggunakan **Laravel Reverb**:

```text
Channel: orders
Event: new-order
Event: order-status-updated
```

Konfigurasi lokal backend saat ini diarahkan ke:

```text
API: http://127.0.0.1:8001
Reverb: ws://127.0.0.1:6001
```

Untuk Android emulator, mobile mengakses host komputer lewat:

```text
API: http://10.0.2.2:8001/api/v1
WebSocket: ws://10.0.2.2:6001
```

## Kondisi Mobile

Mobile berada di:

```text
arpul_mobile
```

Tech stack utama:

```text
Flutter
Riverpod
GoRouter
Dio
Freezed
json_serializable
flutter_secure_storage
web_socket_channel
intl
shimmer
cached_network_image
```

## Fitur yang Sudah Dibangun

### 1. Core Mobile

Sudah dibuat:

- Struktur folder core, feature, shared, dan test.
- Konstanta API dan aplikasi.
- Secure storage untuk token dan data user.
- Dio client dengan bearer token.
- Mapping error API ke `AppException`.
- Theme aplikasi dengan nuansa brand kedai kopi Arpul.
- Widget reusable untuk loading, empty state, error state, status badge, dan indikator koneksi realtime.

Status:

```text
Sudah berjalan sebagai fondasi aplikasi.
```

### 2. Auth

Sudah dibuat:

- Login screen.
- Validasi email dan password.
- Login ke backend Laravel Sanctum.
- Simpan token ke secure storage.
- Ambil profile user dari `/auth/me`.
- Logout dan hapus token.
- Route guard berdasarkan role `admin` dan `kasir`.

Status:

```text
Sudah berjalan untuk kebutuhan dasar login/logout.
```

Catatan:

- Masih perlu testing langsung dengan data user produksi/staging.
- Error message sudah ada, tetapi UX masih bisa diperhalus.

### 3. Routing

Sudah dibuat route:

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

- User belum login diarahkan ke `/login`.
- Admin diarahkan ke area admin.
- Kasir diarahkan ke area kasir.
- Kasir tidak boleh masuk `/admin`.
- Admin tidak boleh masuk `/kasir`.

Status:

```text
Sudah berjalan untuk role utama.
```

### 4. Admin

Sudah dibuat:

- Dashboard admin.
- Stat card untuk transaksi hari ini, revenue, total produk, dan order pending.
- Product list.
- Product card dengan gambar, harga, kategori, stok, edit, dan hapus.
- Product create/edit form.
- Repository dan provider untuk dashboard dan produk.
- Placeholder/navigation untuk reports.

Status:

```text
Sebagian besar admin sudah masuk untuk MVP.
```

Yang belum selesai:

- Reports admin belum lengkap.
- Transaction list dan transaction detail admin belum dibuat penuh.
- Upload gambar produk masih placeholder.
- Validasi form produk masih basic.

### 5. Kasir

Sudah dibuat:

- Kasir dashboard.
- Ambil daftar pending order dari `/orders/pending`.
- Realtime listener order baru dari Laravel Reverb.
- Indikator koneksi realtime di AppBar.
- Banner mode offline jika realtime disconnected.
- Pull to refresh.
- Loading shimmer.
- Empty state ketika belum ada pesanan.
- Order card.
- Tombol konfirmasi dan batalkan.
- Modal konfirmasi sebelum aksi.
- Order detail screen dasar.

Status:

```text
Kasir baru sampai tahap menerima order dan aksi dasar.
Belum lengkap untuk flow operasional kasir end-to-end.
```

Yang masih kurang di kasir:

- Detail order masih perlu diperbaiki agar sesuai data real dari backend.
- Bukti order atau bukti pembayaran belum ditampilkan lengkap di mobile.
- Jika order memakai pembayaran online/QRIS, mobile belum menampilkan bukti transfer/upload payment proof.
- Belum ada flow kasir untuk memverifikasi bukti pembayaran.
- Belum ada tampilan status order yang lengkap dari pending sampai selesai.
- Belum ada proses finalisasi order yang jelas setelah order dikonfirmasi.
- Belum ada riwayat order kasir yang sudah diproses.
- Belum ada filter/search order.
- Belum ada notifikasi visual/audio yang matang ketika order baru masuk.
- Cancel order masih basic dan perlu UX alasan pembatalan yang lebih baik.

Dengan kondisi sekarang, kasir sudah bisa melihat order masuk, tetapi belum cukup lengkap untuk dipakai sebagai sistem kasir harian tanpa perbaikan lanjutan.

### 6. Realtime Order

Sebelumnya realtime diarahkan ke Pusher cloud. Sekarang sudah diubah menjadi Laravel Reverb/self-hosted WebSocket.

Sudah dibuat di mobile:

```text
lib/core/constants/websocket_constants.dart
lib/core/services/laravel_websocket_service.dart
lib/shared/widgets/connection_indicator.dart
```

Backend sudah disiapkan:

```text
config/reverb.php
routes/channels.php
BROADCAST_CONNECTION=reverb
```

Status:

```text
Fondasi realtime sudah siap.
```

Catatan:

- Realtime membutuhkan tiga proses backend aktif: Laravel API, Reverb server, dan queue worker.
- Jika queue worker tidak berjalan, event broadcast tidak akan sampai ke mobile.
- Jika Reverb mati, mobile tetap bisa refresh order lewat API, tetapi indikator realtime akan disconnected.

## Cara Menjalankan Saat Ini

### 1. Jalankan Backend API

Di folder backend:

```bash
cd Arpul-Coffee-shop
php artisan serve --host=127.0.0.1 --port=8001
```

### 2. Jalankan Reverb

Terminal kedua:

```bash
php artisan reverb:start --host=0.0.0.0 --port=6001
```

### 3. Jalankan Queue Worker

Terminal ketiga:

```bash
php artisan queue:work
```

### 4. Jalankan Flutter

Di folder mobile:

```bash
cd arpul_mobile
flutter pub get
flutter run
```

## Status Testing

Backend terakhir sudah dites:

```text
php artisan test
35 passed
```

Mobile sebelumnya sudah dites:

```text
flutter analyze
No issues found

flutter test
All tests passed
```

Catatan:

- Testing tersebut memastikan kode tidak error secara teknis.
- Testing belum berarti semua flow bisnis order sudah lengkap.
- Flow kasir dengan data order real masih perlu dites manual dari backend/web/member sampai masuk ke mobile.

## Batasan Saat Ini

Project belum selesai karena beberapa fitur penting belum lengkap:

- Mobile kasir belum lengkap untuk memproses order dari awal sampai akhir.
- Bukti order/pembayaran belum ditampilkan dan belum diverifikasi dari mobile.
- Admin reports belum lengkap.
- Transaction list/detail admin belum penuh.
- Upload gambar produk belum dikerjakan.
- Member/customer mobile belum dibuat.
- Fitur favorite, delivery, payment proof, dan profile masih dominan di backend/web, belum masuk mobile.
- Belum ada konfigurasi production final untuk domain, HTTPS, signing APK, dan Reverb production.

## Prioritas Pekerjaan Berikutnya

Urutan pengerjaan yang disarankan:

1. Perbaiki model dan UI detail order kasir agar menampilkan data real lengkap.
2. Tambahkan tampilan bukti pembayaran/order di mobile.
3. Tambahkan aksi kasir untuk verifikasi pembayaran jika backend mendukung.
4. Lengkapi status order: pending, confirmed, completed, cancelled.
5. Tambahkan riwayat order kasir.
6. Lengkapi reports admin dan transaction list/detail.
7. Tambahkan upload gambar produk.
8. Uji realtime end-to-end dari order dibuat sampai muncul di dashboard kasir.
9. Siapkan konfigurasi APK release untuk HP fisik.
10. Siapkan konfigurasi production: domain API, HTTPS, dan Reverb production.

## Kesimpulan

Project Arpul sudah memiliki pondasi yang cukup kuat untuk MVP mobile admin dan kasir. Backend API sudah tersedia, mobile sudah terhubung ke endpoint utama, dan realtime order sudah disiapkan menggunakan Laravel Reverb.

Namun project belum finish. Bagian kasir saat ini baru bisa menerima order dan melakukan aksi dasar. Untuk bisa digunakan operasional penuh, mobile masih perlu menyelesaikan detail order, bukti pembayaran/order, verifikasi pembayaran, status order lengkap, dan riwayat order.
