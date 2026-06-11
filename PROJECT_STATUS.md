# Status Perkembangan Project Arpul

Dokumen ini menjelaskan sejauh mana project **Arpul Mobile** dan backend **Arpul-Coffee-shop** sudah berjalan. Status ini dibuat sebagai catatan dokumentasi karena project belum selesai sepenuhnya, terutama pada bagian flow order di mobile.

Audit detail flow kasir backend web vs mobile ada di [KASIR_FLOW_BACKEND_GAP.md](KASIR_FLOW_BACKEND_GAP.md).

## Ringkasan

Project sudah memiliki fondasi backend Laravel dan aplikasi Flutter mobile untuk role **admin** dan **kasir**. Mobile sudah bisa login, membaca role user, mengakses endpoint API utama, menampilkan dashboard admin, menampilkan produk, membaca transaksi admin dasar, dan menjalankan flow kasir utama.

Namun aplikasi belum bisa dianggap selesai. Bagian mobile masih perlu dilengkapi untuk kualitas operasional penuh, terutama detail laporan admin, route list order kasir, UX detail order, upload gambar produk, dan uji end-to-end realtime di device.

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
- Upload gambar produk dari galeri/kamera dengan preview.
- Field gambar wajib saat create product.
- Dropdown kategori dari data backend dan tambah kategori lokal pada form.
- Repository dan provider untuk dashboard dan produk.
- Reports admin dasar dari endpoint transaksi.

Status:

```text
Sebagian besar admin sudah masuk untuk MVP.
```

Yang belum selesai:

- Reports admin mobile sudah punya filter dan detail transaksi, tetapi belum memakai API summary/export baru.
- User management, notification management, dan delivery setting admin belum dibuat di mobile meskipun backend API sudah siap.
- Kategori masih berupa field produk, belum menjadi tabel/CRUD kategori mandiri.
- Validasi form produk sudah ada untuk field wajib dan gambar, tetapi pesan error bisa dipoles lebih lanjut.

### 5. Kasir

Sudah dibuat:

- Kasir dashboard.
- Ambil daftar order dari `/orders/pending-review`, `/orders/ready-to-confirm`, dan `/orders/in-progress`.
- Realtime listener order baru dari Laravel Reverb.
- Indikator koneksi realtime di AppBar.
- Banner mode offline jika realtime disconnected.
- Pull to refresh.
- Loading shimmer.
- Empty state ketika belum ada pesanan.
- Order card.
- Tombol verifikasi/tolak pembayaran.
- Tombol konfirmasi, deliver, complete, dan batalkan.
- Modal konfirmasi sebelum aksi.
- Dialog alasan cancel/reject dengan validasi wajib isi.
- Order detail screen dengan item, customer, delivery, dan bukti pembayaran jika tersedia.
- Popup bukti pembayaran full/fleksibel.
- POS cash sederhana dengan keranjang, paid amount, dan kembalian.

Status:

```text
Flow kasir utama sudah masuk untuk MVP, tetapi belum dipoles untuk operasional penuh.
```

Yang masih kurang di kasir:

- Belum ada riwayat order kasir yang sudah diproses.
- Belum ada filter/search order.
- Belum ada notifikasi visual/audio yang matang ketika order baru masuk.
- Cancel order sudah idempotent di backend API, tetapi tetap perlu uji manual berulang di HP fisik dengan data real.

Dengan kondisi sekarang, kasir sudah bisa menjalankan flow utama, tetapi masih perlu pengujian manual dengan data real dan penyempurnaan UX sebelum dipakai sebagai sistem kasir harian.

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

- Mobile kasir sudah punya flow utama, tetapi route list, detail action, riwayat, filter/search, dan notifikasi masih perlu dilengkapi.
- Bukti pembayaran sudah bisa ditampilkan dari card/detail kasir melalui endpoint publik API `/api/v1/public/storage/{path}`.
- Admin reports belum memakai API summary/export baru.
- Admin user management, notification management, dan delivery setting belum masuk mobile.
- Product CRUD admin sudah mendukung upload gambar, tetapi kategori belum punya CRUD mandiri.
- Member/customer mobile belum dibuat.
- Fitur favorite, profile, delivery management penuh, dan upload payment proof dari customer masih dominan di backend/web, belum masuk mobile.
- Belum ada konfigurasi production final untuk domain, HTTPS, signing APK, dan Reverb production.

## Prioritas Pekerjaan Berikutnya

Urutan pengerjaan yang disarankan:

1. Uji manual flow real: member order, upload bukti, verify, confirm, deliver/complete, cancel, dan POS cash.
2. Tambahkan riwayat order kasir.
3. Tambahkan filter/search order.
4. Hubungkan reports admin ke API `/reports/summary` dan `/reports/export`.
5. Tambahkan mobile admin user management dari API `/users`.
6. Tambahkan mobile admin notification management dari API `/notifications`.
7. Tambahkan mobile admin delivery setting dari API `/settings/delivery`.
8. Pertimbangkan CRUD kategori mandiri jika kategori harus bisa dibuat tanpa membuat produk.
9. Uji realtime end-to-end dari order dibuat sampai muncul di dashboard kasir.
10. Siapkan konfigurasi APK release untuk HP fisik.
11. Siapkan konfigurasi production: domain API, HTTPS, dan Reverb production.

## Kesimpulan

Project Arpul sudah memiliki pondasi yang cukup kuat untuk MVP mobile admin dan kasir. Backend API sudah tersedia, mobile sudah terhubung ke endpoint utama, flow kasir utama sudah masuk, dan realtime order sudah disiapkan menggunakan Laravel Reverb.

Namun project belum finish. Untuk bisa digunakan operasional penuh, mobile masih perlu menyelesaikan route list kasir, konsistensi action detail order, riwayat/filter, admin user/notification/delivery settings, report summary/export, upload gambar produk, dan pengujian end-to-end dengan backend + Reverb + queue worker.
