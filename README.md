# Arpul Mobile

Flutter mobile app untuk operasional kedai kopi **Arpul**. Aplikasi ini terhubung ke backend Laravel `Arpul-Coffee-shop` dan mendukung role **admin** dan **kasir**.

## Fitur

- Login/logout dengan Laravel Sanctum token
- Role guard admin/kasir
- Dashboard admin
- CRUD produk admin
- Reports admin dari endpoint transaksi
- Dashboard kasir
- Pending order list
- Confirm/cancel order
- Detail order dan item pesanan
- Real-time order notification via Pusher Channels
- Theme brand kedai kopi Arpul
- Unit test repository dan notifier

## Tech Stack

- Flutter
- Riverpod + riverpod_generator
- GoRouter
- Dio
- Freezed + json_serializable
- Flutter Secure Storage
- Pusher Channels Flutter
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

## Pusher Setup

Konfigurasi Pusher ada di:

```text
lib/core/constants/pusher_constants.dart
```

Isi sesuai Pusher app:

```dart
static const String kPusherAppKey = 'your_pusher_app_key';
static const String kPusherCluster = 'mt1';
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

Untuk development tanpa Pusher aktif, tersedia:

```dart
PusherService.mock()
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
```

Kasir:

```text
GET   /orders/pending
POST  /orders/{id}/confirm
POST  /orders/{id}/cancel
PATCH /transactions/{id}/status
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

### Error Pusher

Jika Pusher belum dikonfigurasi, aplikasi tidak crash. Kasir akan melihat indikator real-time disconnected dan banner mode offline.

## Catatan Production

Sebelum production:

- Gunakan HTTPS
- Jangan gunakan `android:usesCleartextTraffic="true"`
- Ganti base URL ke domain production
- Konfigurasi Pusher key asli
- Buat signing config release sendiri
- Jangan pakai debug signing untuk release production
- Review logging dan error reporting
