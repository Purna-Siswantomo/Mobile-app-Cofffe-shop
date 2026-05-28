# Arpul Mobile

Flutter mobile app untuk operasional kedai kopi **Arpul**. Aplikasi ini terhubung ke backend Laravel `Arpul-Coffee-shop` dan mendukung role **admin** dan **kasir**.

Status progress terbaru project ada di [PROJECT_STATUS.md](PROJECT_STATUS.md).

## Fitur

- Login/logout dengan Laravel Sanctum token
- Role guard admin/kasir
- Dashboard admin
- CRUD produk admin
- Reports admin dari endpoint transaksi
- Backend API admin siap untuk user management, notification management, delivery setting, report summary, dan export rows
- Dashboard kasir
- Pending order list
- Confirm/cancel order
- Detail order dan item pesanan
- Real-time order notification via Laravel Reverb
- Theme brand kedai kopi Arpul
- Unit test repository dan notifier

## Tech Stack

- Flutter
- Riverpod + riverpod_generator
- GoRouter
- Dio
- Freezed + json_serializable
- Flutter Secure Storage
- Web Socket Channel
- Cached Network Image
- Intl
- Shimmer

## Requirement

- Flutter SDK 3.38.x atau lebih baru
- Dart 3.10.x atau lebih baru
- Android Studio
- Android SDK
- Android emulator atau device Android fisik
- Backend Laravel `Arpul-Coffee-shop`

## Setup Project

Clone repository, lalu masuk ke folder project Flutter:

```bash
cd arpul_mobile
flutter pub get
```

Generate file Freezed/Riverpod jika diperlukan:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Konfigurasi API

Base URL API ada di:

```text
lib/core/constants/api_constants.dart
```

Saat ini default untuk Android emulator:

```dart
static const String kBaseUrl = 'http://10.0.2.2:8001/api/v1';
```

Catatan URL:

- Android emulator ke backend lokal: `http://10.0.2.2:8001/api/v1`
- Windows/Chrome/iOS simulator ke backend lokal: `http://127.0.0.1:8001/api/v1`
- HP fisik: gunakan IP LAN komputer backend, contoh `http://192.168.1.10:8001/api/v1`

Jika ingin test di HP fisik, ganti `kBaseUrl` ke IP komputer yang menjalankan Laravel.

## Menjalankan Backend Laravel

Masuk ke folder backend:

```bash
cd ../Arpul-Coffee-shop
```

Untuk Android emulator:

```bash
php artisan serve --host=127.0.0.1 --port=8001
```

Untuk HP fisik di Wi-Fi yang sama:

```bash
php artisan serve --host=0.0.0.0 --port=8001
```

Pastikan firewall mengizinkan akses ke port `8001` jika memakai HP fisik.

## Menjalankan Flutter di Android Emulator

Start emulator dari Android Studio, lalu cek device:

```bash
flutter devices
```

Jika emulator muncul, jalankan:

```bash
flutter run
```

Atau pilih device spesifik:

```bash
flutter run -d emulator-5554
```

## Menjalankan di HP Fisik

1. Aktifkan Developer Options di HP.
2. Aktifkan USB Debugging.
3. Sambungkan HP ke komputer.
4. Jalankan:

```bash
flutter devices
flutter run -d <device_id>
```

Untuk API, jangan pakai `10.0.2.2` di HP fisik. Gunakan IP LAN komputer backend.

Contoh:

```dart
static const String kBaseUrl = 'http://192.168.1.10:8001/api/v1';
```

## Build APK

Untuk APK debug:

```bash
flutter build apk --debug
```

Output:

```text
build/app/outputs/flutter-apk/app-debug.apk
```

Untuk APK release yang lebih aman dikirim ke teman/device fisik:

```bash
flutter build apk --release
```

Output:

```text
build/app/outputs/flutter-apk/app-release.apk
```

Rekomendasi kirim ke tester:

```text
app-release.apk
```

Jangan kirim APK debug emulator jika hasilnya hanya berisi native library x86_64.

## Testing

Jalankan analyze:

```bash
flutter analyze
```

Jalankan test:

```bash
flutter test
```

Status terakhir:

```text
flutter analyze
No issues found!

flutter test
All tests passed!
```

## Akun Testing

Gunakan akun dari database/seeder backend Laravel.

Contoh umum:

```text
Admin
email: admin@arpul.com
password: password

Kasir
email: kasir@arpul.com
password: password
```

Jika tidak bisa login, cek data user di backend dan pastikan:

- password benar
- role adalah `admin` atau `kasir`
- `is_active` bernilai true

## Laravel Reverb Setup

Konfigurasi WebSocket Flutter ada di:

```text
lib/core/constants/websocket_constants.dart
```

Default untuk Android emulator:

```dart
static const String kWebSocketHost = '10.0.2.2';
static const int kWebSocketPort = 6001;
static const String kWebSocketAppKey = 'arpul-local-key';
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

Backend Laravel memakai Laravel Reverb. Reverb tetap kompatibel dengan protokol Pusher, sehingga Flutter bisa connect langsung memakai `web_socket_channel`.

Contoh `.env` backend untuk lokal:

```env
BROADCAST_CONNECTION=reverb
QUEUE_CONNECTION=database

REVERB_APP_ID=arpul-local
REVERB_APP_KEY=arpul-local-key
REVERB_APP_SECRET=arpul-local-secret
REVERB_HOST=127.0.0.1
REVERB_PORT=6001
REVERB_SCHEME=http
REVERB_SERVER_HOST=0.0.0.0
REVERB_SERVER_PORT=6001
```

Jalankan server Reverb backend:

```bash
php artisan reverb:start --host=0.0.0.0 --port=6001
```

Jalankan queue worker agar event broadcast diproses:

```bash
php artisan queue:work
```

Jika memakai host/port/key berbeda, jalankan Flutter dengan `--dart-define`:

```bash
flutter run \
  --dart-define=LARAVEL_WS_HOST=10.0.2.2 \
  --dart-define=LARAVEL_WS_PORT=6001 \
  --dart-define=LARAVEL_WS_APP_KEY=arpul-local-key
```

Untuk build APK:

```bash
flutter build apk --release \
  --dart-define=LARAVEL_WS_HOST=192.168.1.10 \
  --dart-define=LARAVEL_WS_PORT=6001 \
  --dart-define=LARAVEL_WS_APP_KEY=arpul-local-key
```

Untuk development tanpa WebSocket aktif, tersedia:

```dart
LaravelWebSocketService.mock()
```

Mock ini dapat membuat fake order setiap 10 detik.

## Struktur Folder Penting

```text
lib/core/constants
lib/core/network
lib/core/storage
lib/core/services
lib/core/models
lib/features/auth
lib/features/admin
lib/features/kasir
lib/shared/router
lib/shared/theme
lib/shared/widgets
lib/shared/utils
test/unit
```

## Endpoint Backend yang Dipakai

Base path:

```text
/api/v1
```

Auth:

```text
POST /auth/login
POST /auth/logout
GET  /auth/me
```

Admin:

```text
GET    /dashboard
GET    /products
POST   /products
GET    /products/{id}
PUT    /products/{id}
DELETE /products/{id}
GET    /transactions
GET    /transactions/{id}
GET    /reports/summary
GET    /reports/export
GET    /users
POST   /users
GET    /users/{id}
PUT    /users/{id}
PATCH  /users/{id}/toggle
DELETE /users/{id}
GET    /notifications
POST   /notifications
POST   /notifications/broadcast
GET    /notifications/{id}
PUT    /notifications/{id}
PATCH  /notifications/{id}/toggle
DELETE /notifications/{id}
GET    /settings/delivery
PATCH  /settings/delivery
```

Kasir:

```text
GET   /orders/pending
GET   /orders/pending-review
GET   /orders/ready-to-confirm
GET   /orders/in-progress
GET   /orders/{id}
POST  /orders/{id}/payment/verify
POST  /orders/{id}/payment/reject
POST  /orders/{id}/confirm
POST  /orders/{id}/deliver
POST  /orders/{id}/complete
POST  /orders/{id}/cancel
PATCH /transactions/{id}/status
GET   /pos/products
POST  /pos/transactions
```

## Troubleshooting

### `No supported devices connected`

Pastikan Android emulator sudah benar-benar running.

```bash
flutter devices
```

Jika emulator belum muncul, buka Android Studio > Device Manager > Start emulator.

### APK force close di HP teman

Gunakan APK release:

```text
build/app/outputs/flutter-apk/app-release.apk
```

Jika masih force close, ambil log:

```bash
flutter logs
```

atau dengan Android Studio Logcat.

### Tidak bisa akses API dari Android emulator

Pastikan backend berjalan:

```bash
php artisan serve --host=127.0.0.1 --port=8001
```

Pastikan Flutter memakai:

```dart
http://10.0.2.2:8001/api/v1
```

### Tidak bisa akses API dari HP fisik

Jalankan backend:

```bash
php artisan serve --host=0.0.0.0 --port=8001
```

Ganti `kBaseUrl` ke IP LAN komputer:

```dart
http://192.168.1.10:8001/api/v1
```

Pastikan HP dan komputer berada di Wi-Fi yang sama.

### Error Laravel Reverb / WebSocket

Jika WebSocket belum aktif, aplikasi tidak crash. Kasir akan melihat indikator real-time disconnected dan banner mode offline. Pending order tetap refresh otomatis lewat polling fallback setiap 5 detik.

## Catatan Production

Sebelum production:

- Gunakan HTTPS
- Jangan gunakan `android:usesCleartextTraffic="true"`
- Ganti base URL ke domain production
- Konfigurasi Laravel Reverb production
- Buat signing config release sendiri
- Jangan pakai debug signing untuk release production
- Review logging dan error reporting
