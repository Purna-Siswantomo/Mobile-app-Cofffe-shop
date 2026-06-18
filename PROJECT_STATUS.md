# Status Perkembangan Project Arpul

Dokumen ini menjelaskan sejauh mana project **Arpul Mobile** dan backend **Arpul-Coffee-shop** sudah berjalan.

**Status Terbaru (2026-06-18): Aplikasi sudah berjalan di Android fisik tanpa error. Siap untuk testing operasional penuh.**

Audit detail flow kasir backend web vs mobile ada di [KASIR_FLOW_BACKEND_GAP.md](KASIR_FLOW_BACKEND_GAP.md).

## Ringkasan

Project sudah memiliki fondasi backend Laravel dan aplikasi Flutter mobile untuk role **admin** dan **kasir**. Mobile sudah bisa login, membaca role user, mengakses endpoint API utama, menampilkan dashboard admin, menampilkan produk, membaca transaksi admin dasar, dan menjalankan flow kasir utama **termasuk verifikasi pembayaran, confirm, deliver, complete, cancel, POS cash, dan realtime Reverb**.

Aplikasi sudah **terverifikasi berjalan di HP fisik Android tanpa error** pada tanggal 2026-06-18. Fitur utama yang sudah working end-to-end:
- Login admin/kasir
- Dashboard admin & kasir
- CRUD produk admin
- Order list kasir (pending review, ready-to-confirm, in-progress)
- Verifikasi/tolak pembayaran QRIS
- Confirm, deliver, complete, cancel order
- Detail order dengan item & bukti pembayaran
- Realtime order via Laravel Reverb
- POS cash walk-in

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
GET    /api/v1/orders/pending-review
GET    /api/v1/orders/ready-to-confirm
GET    /api/v1/orders/in-progress
GET    /api/v1/orders/{id}
POST   /api/v1/orders/{id}/payment/verify
POST   /api/v1/orders/{id}/payment/reject
POST   /api/v1/orders/{id}/confirm
POST   /api/v1/orders/{id}/deliver
POST   /api/v1/orders/{id}/complete
POST   /api/v1/orders/{id}/cancel
GET    /api/v1/pos/products
POST   /api/v1/pos/transactions
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

**Status verifikasi (2026-06-18):** Aplikasi sudah diuji di HP fisik Android dan berjalan tanpa error. Semua fitur core, admin, kasir, realtime, dan POS sudah working end-to-end.

## Fitur yang Sudah Dibangun

### 1. Core Mobile

Sudah dibuat:

- Struktur folder core, feature, shared, dan test.
- Konstanta API dan aplikasi (support `--dart-define` untuk environment).
- Secure storage untuk token dan data user.
- Dio client dengan bearer token.
- Mapping error API ke `AppException`.
- Theme aplikasi dengan nuansa brand kedai kopi Arpul.
- Widget reusable untuk loading, empty state, error state, status badge, dan indikator koneksi realtime.

Status:

```text
Sudah berjalan dan terverifikasi di HP fisik Android.
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
Sudah berjalan dan terverifikasi di HP fisik Android.
```

Catatan:

- **Terverifikasi login admin & kasir di HP fisik dengan seeder backend.**
- Error message sudah ada dan berfungsi.

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

- Dashboard admin dengan stat card real-time (transaksi hari ini, revenue, total produk, order pending).
- Product list dengan pull-to-refresh, shimmer loading, empty state.
- Product card dengan gambar (CachedNetworkImage), harga, kategori, stok, edit, dan hapus.
- Product create/edit form dengan upload gambar dari galeri/kamera & preview.
- Field gambar wajib saat create product.
- Dropdown kategori dari data backend dan tambah kategori lokal pada form.
- Repository dan provider untuk dashboard dan produk.
- Reports admin dasar dari endpoint transaksi.

Status:

```text
Admin MVP sudah selesai dan terverifikasi di HP fisik Android.
```

Yang belum selesai (untuk fase selanjutnya):

- Reports admin mobile belum memakai API `/reports/summary` dan `/reports/export` baru.
- User management, notification management, dan delivery setting admin belum dibuat di mobile meskipun backend API sudah siap.
- Kategori masih berupa field produk, belum menjadi tabel/CRUD kategori mandiri.
- Validasi form produk sudah ada untuk field wajib dan gambar, pesan error bisa dipoles lebih lanjut.

### 5. Kasir

Sudah dibuat:

- Kasir dashboard dengan indikator koneksi realtime & banner offline.
- Ambil daftar order dari `/orders/pending-review`, `/orders/ready-to-confirm`, dan `/orders/in-progress`.
- Realtime listener order baru dari Laravel Reverb.
- Pull to refresh.
- Loading shimmer.
- Empty state ketika belum ada pesanan.
- Order card dengan status badge.
- Tombol verifikasi/tolak pembayaran QRIS.
- Tombol konfirmasi, deliver, complete, dan batalkan.
- Modal konfirmasi sebelum aksi.
- Dialog alasan cancel/reject dengan validasi wajib isi.
- Order detail screen dengan item, customer, delivery, dan bukti pembayaran jika tersedia.
- Popup bukti pembayaran full/fleksibel.
- POS cash sederhana dengan keranjang, paid amount, dan kembalian.

Status:

```text
Flow kasir utama sudah lengkap untuk MVP dan terverifikasi di HP fisik Android.
```

Yang masih kurang di kasir (untuk fase selanjutnya):

- Belum ada riwayat order kasir yang sudah diproses.
- Belum ada filter/search order.
- Belum ada notifikasi visual/audio yang matang ketika order baru masuk.
- Cancel order sudah idempotent di backend API, sudah terverifikasi di HP fisik.

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
Realtime sudah berjalan dan terverifikasi di HP fisik Android.
```

Catatan:

- Realtime membutuhkan tiga proses backend aktif: Laravel API, Reverb server, dan queue worker.
- Jika queue worker tidak berjalan, event broadcast tidak akan sampai ke mobile.
- Jika Reverb mati, mobile tetap bisa refresh order lewat API, tetapi indikator realtime akan disconnected.
- **Terverifikasi: order baru muncul realtime di dashboard kasir saat Reverb & queue worker aktif.**

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

Mobile terakhir sudah dites:

```text
flutter analyze
No issues found

flutter test
All tests passed
```

**Verifikasi fisik Android (2026-06-18):**

```text
✅ Login admin & kasir
✅ Dashboard admin & kasir
✅ CRUD produk admin (termasuk upload gambar)
✅ Order list kasir (pending review, ready-to-confirm, in-progress)
✅ Verifikasi/tolak pembayaran QRIS
✅ Confirm, deliver, complete, cancel order
✅ Detail order dengan item & bukti pembayaran
✅ Realtime order via Laravel Reverb (order baru muncul otomatis)
✅ POS cash walk-in
✅ Connection indicator & offline banner
```

Catatan:

- Testing teknis (analyze & unit test) passed.
- **Verifikasi manual end-to-end di HP fisik Android sudah selesai dan tanpa error.**
- Flow kasir dengan data order real sudah dites dari backend/web/member sampai masuk ke mobile.

## Batasan Saat Ini

**Core MVP sudah selesai dan terverifikasi di HP fisik Android.** Fitur berikut masih untuk fase pengembangan lanjutan:

- Riwayat order kasir yang sudah diproses.
- Filter/search order di dashboard kasir.
- Notifikasi visual/audio yang lebih matang ketika order baru masuk.
- Admin reports belum memakai API `/reports/summary` dan `/reports/export` baru.
- Admin user management, notification management, dan delivery setting belum masuk mobile (backend API sudah siap).
- Product CRUD admin sudah mendukung upload gambar, tetapi kategori belum punya CRUD mandiri.
- Member/customer mobile belum dibuat.
- Fitur favorite, profile, delivery management penuh, dan upload payment proof dari customer masih dominan di backend/web, belum masuk mobile.
- Belum ada konfigurasi production final untuk domain, HTTPS, signing APK, dan Reverb production.

## Prioritas Pekerjaan Berikutnya

**✅ Sudah selesai (terverifikasi 2026-06-18):**
1. ~~Uji manual flow real: member order, upload bukti, verify, confirm, deliver/complete, cancel, dan POS cash.~~
2. ~~Uji realtime end-to-end dari order dibuat sampai muncul di dashboard kasir.~~

Urutan pengerjaan untuk fase selanjutnya:

1. Tambahkan riwayat order kasir.
2. Tambahkan filter/search order.
3. Hubungkan reports admin ke API `/reports/summary` dan `/reports/export`.
4. Tambahkan mobile admin user management dari API `/users`.
5. Tambahkan mobile admin notification management dari API `/notifications`.
6. Tambahkan mobile admin delivery setting dari API `/settings/delivery`.
7. Pertimbangkan CRUD kategori mandiri jika kategori harus bisa dibuat tanpa membuat produk.
8. Siapkan konfigurasi APK release untuk HP fisik.
9. Siapkan konfigurasi production: domain API, HTTPS, dan Reverb production.

## Kesimpulan

Project Arpul sudah memiliki pondasi yang cukup kuat untuk MVP mobile admin dan kasir. **Backend API sudah tersedia, mobile sudah terhubung ke endpoint utama, flow kasir utama sudah lengkap (termasuk verifikasi pembayaran, confirm, deliver, complete, cancel, POS cash), dan realtime order sudah berjalan menggunakan Laravel Reverb.**

**Status terbaru (2026-06-18): MVP mobile admin & kasir sudah selesai dan terverifikasi berjalan di HP fisik Android tanpa error.**

Untuk fase production, mobile masih perlu:
- Riwayat/filter order kasir
- Admin user/notification/delivery settings
- Report summary/export
- Kategori CRUD mandiri
- Konfigurasi production final (domain, HTTPS, signing APK, Reverb production)
