# Arpul Mobile

Flutter mobile app untuk operasional kedai kopi Arpul, dengan role kasir dan admin.

## Setup

```bash
flutter pub get
```

Konfigurasi base URL API ada di:

```text
lib/core/constants/api_constants.dart
```

Default development Android emulator:

```dart
const String kBaseUrl = 'http://10.0.2.2:8000/api/v1';
```

`10.0.2.2` adalah alamat localhost host machine dari Android emulator. Untuk device fisik, gunakan IP lokal komputer yang menjalankan backend Laravel.

## Run di Emulator

Pastikan backend Laravel berjalan, lalu jalankan:

```bash
flutter run
```

Pilih Android emulator dari daftar device.

## Build APK Debug

```bash
flutter build apk --debug
```

Output APK debug biasanya berada di:

```text
build/app/outputs/flutter-apk/app-debug.apk
```

## Testing Login

Gunakan kredensial yang tersedia di backend Laravel.

Contoh akun yang umum dipakai saat development:

```text
Admin
email: admin@example.com
password: password

Kasir
email: kasir@example.com
password: password
```

Jika berbeda, sesuaikan dengan seeder atau database backend.

## Pusher Setup

Konfigurasi Pusher ada di:

```text
lib/core/constants/pusher_constants.dart
```

Ubah nilai berikut sesuai app Pusher:

```dart
static const String kPusherAppKey = 'your_pusher_app_key';
static const String kPusherCluster = 'mt1';
```

Channel dan event yang digunakan:

```text
channel: orders
event: new-order
event: order-status-updated
```

Untuk development tanpa Pusher aktif, `PusherService.mock()` tersedia dan dapat dipakai sementara di dashboard kasir untuk membuat fake order tiap 10 detik.

## Catatan Dev

`android:usesCleartextTraffic="true"` aktif untuk koneksi HTTP development ke localhost. Untuk production, gunakan HTTPS dan nonaktifkan cleartext traffic.
