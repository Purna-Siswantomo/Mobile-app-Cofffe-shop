# Audit Flow Kasir Backend Web vs Mobile

Dokumen ini mencatat flow kasir yang sudah ada di backend web `Arpul-Coffee-shop`, lalu membandingkannya dengan integrasi yang sudah ada di `arpul_mobile`.

Kesimpulan utama setelah audit terbaru: **flow kasir mobile sudah jauh lebih lengkap daripada catatan awal, tetapi belum selesai untuk operasional penuh**. Mobile sekarang sudah menangani pending review, verifikasi/tolak pembayaran, ready-to-confirm, in-progress, deliver, complete, cancel idempotent, detail order dengan item/bukti pembayaran, realtime Reverb, dan POS cash sederhana.

Gap yang masih tersisa terutama:

- Riwayat order kasir, filter/search, dan notifikasi audio/visual belum matang.
- Cetak/download struk POS belum masuk mobile, walaupun backend mengembalikan `receipt_url`.
- Flow delivery admin/kurir penuh masih web/backend, mobile baru menangani status delivery pada order kasir.

## Sumber Backend yang Dicek

File utama:

```text
Arpul-Coffee-shop/routes/web.php
Arpul-Coffee-shop/routes/api.php
Arpul-Coffee-shop/app/Http/Controllers/TransactionController.php
Arpul-Coffee-shop/app/Http/Controllers/PaymentController.php
Arpul-Coffee-shop/app/Http/Controllers/MenuController.php
Arpul-Coffee-shop/app/Http/Controllers/Api/OrderController.php
Arpul-Coffee-shop/app/Http/Controllers/Api/TransactionController.php
Arpul-Coffee-shop/resources/views/transactions/index.blade.php
Arpul-Coffee-shop/resources/views/member/payment.blade.php
Arpul-Coffee-shop/resources/views/kasir/delivery
```

File mobile yang dibandingkan:

```text
arpul_mobile/lib/features/kasir/data/repositories/order_repository.dart
arpul_mobile/lib/features/kasir/data/models/order_model.dart
arpul_mobile/lib/features/kasir/presentation/providers/order_provider.dart
arpul_mobile/lib/features/kasir/presentation/screens/kasir_dashboard_screen.dart
arpul_mobile/lib/features/kasir/presentation/screens/order_detail_screen.dart
arpul_mobile/lib/features/kasir/presentation/widgets/order_card.dart
```

## Flow Kasir di Backend Web

### 1. Customer/member membuat order

Di web member, order dibuat dari `MenuController::placeOrder()`.

Flow:

1. Customer pilih produk.
2. Customer pilih `order_type`: `dinein` atau `delivery`.
3. Jika dine-in, customer mengisi nomor meja.
4. Jika delivery, customer mengisi nama penerima, alamat, nomor HP, koordinat jika ada.
5. Backend membuat `Transaction`.
6. Default pembayaran member adalah QRIS.
7. Status awal:

```text
status = pending_payment
payment_status = pending_payment
payment_method = qris
```

8. Customer diarahkan ke halaman pembayaran QRIS.

Status integrasi mobile kasir:

```text
Belum lengkap.
Mobile kasir sekarang memisahkan order melalui endpoint pending-review, ready-to-confirm, dan in-progress. Order `pending_payment` murni belum ditampilkan karena belum ada bukti pembayaran untuk direview kasir.
```

### 2. Customer upload bukti pembayaran

Di backend web, upload bukti ada di `PaymentController::upload()`.

Flow:

1. Customer upload file `payment_proof`.
2. File disimpan ke storage public.
3. Transaction diubah:

```text
payment_proof = path file bukti
payment_status = awaiting_review
status = pending
```

4. Backend membuat notifikasi untuk role kasir.
5. Order baru muncul di halaman kasir bagian "Menunggu Konfirmasi".

Status integrasi mobile kasir:

```text
Belum lengkap.
Mobile sudah punya field `payment_proof_url`, menampilkan gambar bukti pembayaran, serta menyediakan aksi verifikasi dan tolak pembayaran pada tab/card kasir.
```

### 3. Kasir cek bukti pembayaran

Di web kasir, `resources/views/transactions/index.blade.php` menampilkan thumbnail bukti pembayaran.

Jika `payment_status = awaiting_review`, kasir bisa:

```text
Verifikasi pembayaran
Tolak pembayaran
```

Route web:

```text
POST /transactions/{transaction}/payment/verify
POST /transactions/{transaction}/payment/reject
```

Controller:

```text
TransactionController::verifyPayment()
TransactionController::rejectPayment()
```

Efek verifikasi:

```text
payment_status = verified
paid_amount = grand_total atau total
```

Efek tolak:

```text
payment_status = rejected
```

Status integrasi mobile kasir:

```text
Sudah masuk.
Mobile memiliki tab cek bukti, preview/popup bukti pembayaran, tombol verifikasi pembayaran, dan tombol tolak pembayaran dengan alasan.
```

Catatan penting:

Di backend web, order **tidak boleh dikonfirmasi** sebelum `payment_status = verified`.

### 4. Kasir konfirmasi order

Di backend web, konfirmasi order dilakukan oleh `TransactionController::confirmOrder()`.

Syarat:

```text
status harus pending
payment_status harus verified
```

Efek:

```text
status = in_progress
stok produk dikurangi
```

Route web:

```text
POST /transactions/confirm-order/{transaction}
```

Status integrasi mobile kasir:

```text
Sebagian, tapi belum sesuai backend web.
```

Mobile memakai endpoint API:

```text
POST /api/v1/orders/{id}/confirm
```

Masalahnya, `Api\OrderController::confirm()` saat ini hanya mengubah:

```text
status = confirmed
```

API belum mengikuti logic web:

```text
cek payment_status verified
ubah status ke in_progress
kurangi stok
```

Jadi mobile dan web saat ini memakai state machine yang berbeda.

### 5. Order sedang diproses

Di backend web, order yang sudah dikonfirmasi masuk bagian "Sedang Diproses".

Query backend web:

```text
status in_progress atau delivering
```

Di tahap ini web kasir bisa:

- Membatalkan order.
- Untuk delivery: tandai sedang diantar.
- Menyelesaikan order.
- Untuk order non-prepaid: load order ke POS dan proses bayar cash.

Status integrasi mobile kasir:

```text
Belum ada.
Mobile hanya mengambil order pending.
Setelah confirm, order dihapus dari list mobile dan tidak ada layar "Sedang Diproses".
```

### 6. Delivery order

Backend web punya flow delivery:

Route web dari `routes/web.php`:

```text
GET  /kasir/deliveries
GET  /kasir/deliveries/{delivery}
POST /kasir/deliveries/{delivery}/accept
POST /kasir/deliveries/{delivery}/mark-delivered
POST /transactions/{transaction}/deliver
POST /transactions/{transaction}/complete-order
```

Data delivery:

```text
recipient_name
address
phone
delivery_fee
latitude
longitude
status
```

Status delivery di backend:

```text
pending
accepted
on_way / on_the_way
delivered
cancelled
```

Status integrasi mobile kasir:

```text
Belum ada.
Mobile `OrderModel` sudah punya `DeliveryModel` untuk data delivery yang dikirim backend.
Mobile belum bisa melihat alamat, nomor HP, penerima, fee, koordinat, atau status delivery.
Mobile belum bisa tandai order sedang diantar atau delivered.
```

### 7. POS kasir offline / walk-in

Di backend web, halaman kasir juga berfungsi sebagai POS.

Route web:

```text
POST /transactions/add-to-cart
POST /transactions/update-cart-quantity
POST /transactions/remove-from-cart
POST /transactions/complete
GET  /transactions/success/{id}
GET  /transactions/receipt/{id}
```

Flow POS offline:

1. Kasir pilih produk.
2. Produk masuk keranjang.
3. Kasir input uang dibayar.
4. Backend validasi uang cukup.
5. Backend membuat transaksi baru:

```text
order_type = dinein
payment_method = cash
payment_status = verified
status = paid
paid_amount = nominal uang
```

6. Stok dikurangi.
7. Kasir masuk ke halaman sukses.
8. Kasir bisa cetak struk PDF.

Status integrasi mobile kasir:

```text
Belum ada.
Mobile kasir sudah punya POS cash sederhana: produk POS, cart, input `paid_amount`, hitung kembalian, dan create transaction melalui `/api/v1/pos/transactions`.

Yang belum masuk:

- Cetak/download struk dari `receipt_url`.
- UX POS lanjutan seperti edit catatan per item, hold bill, atau riwayat transaksi POS.
```

### 8. Selesaikan order

Backend web punya `TransactionController::completeOrder()`.

Aturan:

```text
dinein: hanya bisa selesai dari in_progress
delivery: hanya bisa selesai dari delivering
```

Efek:

```text
status = completed
jika ada delivery, delivery.status = delivered
```

Status integrasi mobile kasir:

```text
Belum ada.
Mobile hanya mengenal pending, confirmed, completed secara sederhana.
Mobile sudah punya flow `in_progress -> delivering -> completed` melalui provider dan action card kasir.
```

### 9. Cancel order

Backend web:

```text
TransactionController::cancelOrder()
```

Aturan:

```text
Bisa cancel jika status pending, in_progress, atau delivering.
Jika sudah in_progress/delivering, stok dikembalikan.
```

Status integrasi mobile kasir:

```text
Sudah masuk untuk flow utama.
Mobile bisa cancel order pending_payment, pending, in_progress, dan delivering melalui API dengan alasan pembatalan.
Jika status sudah in_progress/delivering, backend API mengembalikan stok.
Jika request cancel terkirim ulang saat order sudah canceled/cancelled, backend API membalas sukses agar mobile tidak menampilkan error palsu.
```

## Perbandingan Endpoint Web vs API Mobile

### Endpoint yang sudah ada di API mobile

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
GET   /api/v1/transactions
GET   /api/v1/transactions/{id}
GET   /api/v1/pos/products
POST  /api/v1/pos/transactions
```

### Endpoint web yang belum punya API setara atau belum dipakai penuh di mobile

```text
GET  /kasir/deliveries
GET  /kasir/deliveries/{delivery}
POST /kasir/deliveries/{delivery}/accept
POST /kasir/deliveries/{delivery}/mark-delivered
POST /transactions/add-to-cart
POST /transactions/update-cart-quantity
POST /transactions/remove-from-cart
POST /transactions/complete
GET  /transactions/receipt/{id}
```

Catatan:

- Endpoint payment/order utama sudah punya padanan API mobile.
- Endpoint delivery khusus `/kasir/deliveries/*` dan cetak receipt web belum masuk mobile.

## Gap Data Model Mobile

`OrderModel` mobile saat ini baru punya:

```text
id
userId
totalAmount
status
paymentMethod
createdAt
itemCount
details
```

Field backend yang belum masuk ke model order kasir:

```text
order_type
payment_status
payment_proof
paid_amount
grand_total
delivery_fee
table_number
notes
user/customer name
delivery object
delivery.recipient_name
delivery.address
delivery.phone
delivery.status
delivery.latitude
delivery.longitude
```

Tanpa field tersebut, mobile tidak bisa meniru flow web kasir dengan benar.

## Gap UI Mobile Kasir

Yang masih belum matang di mobile:

1. Riwayat order yang sudah selesai/dibatalkan.
2. Filter/search order.
3. Notifikasi visual/audio yang lebih matang.
4. Cetak/download struk POS mobile dari `receipt_url`.
5. Delivery management khusus `/kasir/deliveries/*`.

## Rekomendasi Integrasi Berikutnya

### Tahap 1: Samakan state machine API dengan web

Backend API perlu disesuaikan agar sama dengan web:

```text
pending_payment -> awaiting_review -> verified -> in_progress -> completed
delivery: in_progress -> delivering -> completed
cancel: pending/in_progress/delivering -> canceled
```

Ubah atau tambah endpoint API:

```text
GET  /api/v1/orders/pending-review
GET  /api/v1/orders/in-progress
POST /api/v1/orders/{id}/payment/verify
POST /api/v1/orders/{id}/payment/reject
POST /api/v1/orders/{id}/confirm
POST /api/v1/orders/{id}/deliver
POST /api/v1/orders/{id}/complete
POST /api/v1/orders/{id}/cancel
```

`POST /api/v1/orders/{id}/confirm` sebaiknya mengikuti logic web:

- Hanya bisa jika `status = pending`.
- Hanya bisa jika `payment_status = verified`.
- Kurangi stok.
- Ubah status ke `in_progress`.

### Tahap 2: Lengkapi response order API

Endpoint order kasir perlu mengembalikan:

```text
user
details.product
delivery
payment_proof_url
order_type
payment_status
table_number
notes
paid_amount
grand_total
delivery_fee
```

Untuk bukti pembayaran, jangan hanya kirim path storage. Kirim URL penuh:

```text
payment_proof_url = asset('storage/' . payment_proof)
```

### Tahap 3: Update mobile kasir

Mobile perlu:

1. Update `OrderModel`.
2. Tambah repository method untuk verify/reject/deliver/complete.
3. Tambah provider untuk pending review dan in-progress order.
4. Update dashboard kasir menjadi beberapa tab:

```text
Menunggu Review
Siap Dikonfirmasi
Sedang Diproses
POS Offline
Riwayat
```

5. Tambah detail screen yang menampilkan:

```text
customer
items
total/grand total
payment status
payment proof
order type
table number
delivery info
notes
aksi sesuai status
```

### Tahap 4: POS mobile

Buat POS mobile sendiri untuk order offline:

```text
GET  /api/v1/pos/products
POST /api/v1/pos/transactions
GET  /api/v1/transactions/{id}/receipt
```

Atau gunakan endpoint produk yang sudah ada, lalu tambah endpoint create transaksi cash.

Payload transaksi cash:

```json
{
  "items": [
    {"product_id": 1, "quantity": 2}
  ],
  "paid_amount": 50000,
  "notes": "Walk-in",
  "table_number": "3"
}
```

Expected backend:

```text
payment_method = cash
payment_status = verified
status = paid atau completed
stok dikurangi
paid_amount tersimpan
receipt tersedia
```

## Kesimpulan

Backend web sudah punya flow kasir yang lebih lengkap daripada mobile. Flow paling penting yang belum masuk mobile adalah:

- Cek bukti pembayaran.
- Verifikasi/tolak pembayaran.
- Konfirmasi order hanya setelah pembayaran verified.
- Status `in_progress`, `delivering`, dan `completed`.
- Delivery handling.
- POS offline kasir sudah masuk dasar; cetak struk dan UX lanjutan belum.
- Pembayaran cash dan kembalian.
- Cetak struk.

Sebelum mobile dilanjutkan, backend API sebaiknya disamakan dulu dengan logic web agar mobile tidak memakai flow status yang berbeda.
