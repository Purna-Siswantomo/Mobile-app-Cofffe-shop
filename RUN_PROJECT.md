# Cara Menjalankan Project Arpul

Dokumen ini menjelaskan cara menjalankan backend Laravel `Arpul-Coffee-shop` dan aplikasi Flutter `arpul_mobile` untuk development lokal.

**✅ Status verifikasi (2026-06-18): Aplikasi sudah diuji di HP fisik Android dan berjalan tanpa error menggunakan konfigurasi di bawah ini.**

## Struktur Folder

```text
C:\Users\Purna Siswantomo\Documents\bekas project
├── Arpul-Coffee-shop   # Backend Laravel
└── arpul_mobile        # Aplikasi Flutter
```

## 1. Menjalankan Backend Laravel

Masuk ke folder backend:

```bash
cd "C:\Users\Purna Siswantomo\Documents\bekas project\Arpul-Coffee-shop"
```

Install dependency jika belum:

```bash
composer install
npm install
```

Siapkan file `.env`:

```bash
copy .env.example .env
php artisan key:generate
```

Pastikan konfigurasi lokal utama di `.env` seperti ini:

```env
APP_URL=http://127.0.0.1:8001

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

Jalankan migrasi dan seeder:

```bash
php artisan migrate --seed
```

Buat storage link agar file upload bisa diakses:

```bash
php artisan storage:link
```

Jalankan backend API di terminal pertama:

```bash
php artisan serve --host=127.0.0.1 --port=8001
```

Untuk HP fisik di Wi-Fi yang sama, gunakan:

```bash
php artisan serve --host=0.0.0.0 --port=8001
```

## 2. Menjalankan Reverb dan Queue

Realtime order memakai Laravel Reverb. Jalankan terminal kedua:

```bash
cd "C:\Users\Purna Siswantomo\Documents\bekas project\Arpul-Coffee-shop"
php artisan reverb:start --host=0.0.0.0 --port=6001
```

Jalankan queue worker di terminal ketiga:

```bash
cd "C:\Users\Purna Siswantomo\Documents\bekas project\Arpul-Coffee-shop"
php artisan queue:work
```

Tanpa Reverb dan queue worker, aplikasi mobile tetap bisa membaca data via API, tetapi realtime order tidak akan aktif.

## 3. Menjalankan Flutter Mobile

Masuk ke folder mobile:

```bash
cd "C:\Users\Purna Siswantomo\Documents\bekas project\arpul_mobile"
```

Install dependency:

```bash
flutter pub get
```

Generate file Freezed/Riverpod jika diperlukan:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Jalankan emulator Android dari Android Studio, lalu cek device:

```bash
flutter devices
```

Jalankan aplikasi:

```bash
flutter run
```

## 4. Konfigurasi URL Mobile

File konfigurasi API:

```text
lib/core/constants/api_constants.dart
```

Default aplikasi saat ini:

```dart
static const String kBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://172.10.98.90:8001/api/v1',
);
```

Gunakan `--dart-define=API_BASE_URL=...` untuk menyesuaikan host tanpa mengubah source code.

Untuk Android emulator:

```powershell
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8001/api/v1
```

Untuk HP fisik pada WiFi yang sama:

```powershell
flutter run -d <DEVICE_ID> --dart-define=API_BASE_URL=http://192.168.1.10:8001/api/v1
```

File konfigurasi WebSocket:

```text
lib/core/constants/websocket_constants.dart
```

Default untuk Android emulator:

```dart
static const String kWebSocketHost = '10.0.2.2';
static const int kWebSocketPort = 6001;
static const String kWebSocketAppKey = 'arpul-local-key';
```

Untuk HP fisik, jalankan API dan WebSocket memakai IP LAN komputer:

```powershell
flutter run -d <DEVICE_ID> `
  --dart-define=API_BASE_URL=http://192.168.1.10:8001/api/v1 `
  --dart-define=LARAVEL_WS_HOST=192.168.1.10 `
  --dart-define=LARAVEL_WS_PORT=6001 `
  --dart-define=LARAVEL_WS_APP_KEY=arpul-local-key
```

Catatan PowerShell: gunakan backtick `` ` `` untuk multi-line, bukan caret `^`. Alternatif paling aman adalah satu baris.

## 5. Akun Testing

Gunakan akun dari seeder backend.

```text
Admin
email: admin@arpul.com
password: admin123

Kasir
email: kasir@arpul.com
password: kasir123

Member
email: member@arpul.com
password: member123
```

Jika login gagal, cek data user di database dan pastikan:

- `role` sesuai: `admin`, `kasir`, atau `member`
- `is_active` bernilai `true`
- password sesuai seeder terbaru

## 6. Menjalankan Test

Backend:

```bash
cd "C:\Users\Purna Siswantomo\Documents\bekas project\Arpul-Coffee-shop"
php artisan test --testsuite=Feature --filter=Api
```

Mobile:

```bash
cd "C:\Users\Purna Siswantomo\Documents\bekas project\arpul_mobile"
flutter analyze
flutter test
```

**Status verifikasi (2026-06-18):**

```text
flutter analyze
No issues found!

flutter test
All tests passed!
```

**Verifikasi fisik Android:** Aplikasi sudah diuji di HP fisik Android dan berjalan tanpa error (login, dashboard admin, dashboard kasir, order list, order detail, realtime Reverb, POS cash).

## 7. Build APK

Debug APK:

```bash
flutter build apk --debug
```

Release APK:

```bash
flutter build apk --release
```

Output:

```text
build/app/outputs/flutter-apk/app-debug.apk
build/app/outputs/flutter-apk/app-release.apk
```

Untuk HP fisik, pastikan `kBaseUrl` dan `LARAVEL_WS_HOST` mengarah ke IP LAN komputer backend.

## 8. Urutan Terminal Saat Development

Minimal gunakan 4 terminal:

```text
Terminal 1: php artisan serve --host=127.0.0.1 --port=8001
Terminal 2: php artisan reverb:start --host=0.0.0.0 --port=6001
Terminal 3: php artisan queue:work
Terminal 4: flutter run
```

Untuk HP fisik:

```text
Terminal 1: php artisan serve --host=0.0.0.0 --port=8001
Terminal 2: php artisan reverb:start --host=0.0.0.0 --port=6001
Terminal 3: php artisan queue:work
Terminal 4: flutter run dengan dart-define host LAN
```

## 9. Troubleshooting

### Mobile tidak bisa login

- Pastikan Laravel berjalan di port `8001`.
- Android emulator harus memakai `http://10.0.2.2:8001/api/v1`.
- HP fisik harus memakai IP LAN komputer backend.
- Pastikan firewall mengizinkan port `8001`.

### Realtime disconnected

- Pastikan `php artisan reverb:start` berjalan.
- Pastikan `php artisan queue:work` berjalan.
- Pastikan `LARAVEL_WS_HOST` cocok dengan environment device.
- Aplikasi tetap bisa berjalan via polling/API walaupun realtime disconnected.

### Gambar upload tidak muncul

Untuk web Laravel, jalankan:

```bash
php artisan storage:link
```

Untuk mobile, backend mengembalikan URL upload lewat endpoint:

```text
/api/v1/public/storage/{path}
```

Jika gambar produk atau bukti pembayaran tidak muncul di HP fisik, cek:

- Laravel berjalan dengan `--host=0.0.0.0 --port=8001`.
- `API_BASE_URL` mengarah ke IP LAN komputer yang sama dengan HP.
- File benar-benar ada di `storage/app/public`.
- Firewall Windows mengizinkan port `8001`.

### Database kosong

Jalankan ulang:

```bash
php artisan migrate:fresh --seed
```

Perintah ini menghapus data lama dan mengisi ulang data seeder.
