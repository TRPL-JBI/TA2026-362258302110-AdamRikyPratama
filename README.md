# 🎭 KITA BANYUWANGI - KARTU INDUK KESENIAN DIGITAL BANYUWANGI

> Platform digital untuk pendataan, verifikasi, dan pusat informasi kelompok/organisasi kesenian daerah — dari pendaftaran mandiri oleh komunitas seni, verifikasi berjenjang oleh admin, hingga penerbitan Kartu Tanda Anggota (KTA) digital.

![Laravel](https://img.shields.io/badge/Laravel-FF2D20?style=flat&logo=laravel&logoColor=white)
![PHP](https://img.shields.io/badge/PHP-777BB4?style=flat&logo=php&logoColor=white)
![Status](https://img.shields.io/badge/status-active--development-brightgreen)

---

## 📖 Daftar Isi

- [Gambaran Umum](#-gambaran-umum)
- [Alur Program Secara Garis Besar](#-alur-program-secara-garis-besar)
- [Peta Controller](#-peta-controller)
- [🆕 Fitur Baru: Input Kegiatan Kesenian](#-fitur-baru-input-kegiatan-kesenian)
- [🆕 Fitur Baru: Landing Page Pusat Informasi Kegiatan Kesenian](#-fitur-baru-landing-page-pusat-informasi-kegiatan-kesenian)
- [Role & Hak Akses](#-role--hak-akses)
- [Struktur Status Organisasi](#-struktur-status-organisasi)
- [Instalasi Singkat](#-instalasi-singkat)
- [Roadmap](#-roadmap)

---

## 🧭 Gambaran Umum

Aplikasi ini dibangun untuk membantu **Dinas Kebudayaan Dan Pariwisata Kabupaten Banyuwangi** mendata seluruh kelompok kesenian di wilayahnya secara digital — menggantikan proses manual berbasis kertas dengan alur **daftar → upload dokumen → verifikasi → terbit KTA**.

Ada dua "dunia" utama dalam sistem ini:

| Dunia                                 | Untuk siapa                      | Tujuan                                                                                                                |
| ------------------------------------- | -------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| 🙋 **Panel User (Pengurus Kesenian)** | Ketua/pengurus kelompok kesenian | Mendaftarkan organisasi, melengkapi data anggota, inventaris & dokumen pendukung, memantau status verifikasi          |
| 🛡️ **Panel Admin (Dinas)**            | Petugas verifikator/admin        | Meninjau & memvalidasi pengajuan, mengelola master data wilayah & jenis kesenian, mencetak laporan, menerbitkan kartu |

---

## 🔄 Alur Program Secara Garis Besar

Berikut perjalanan satu kelompok kesenian dari nol sampai punya kartu anggota resmi:

```
┌─────────────┐      ┌──────────────┐      ┌────────────────────┐
│  1. Register │ ───► │ 2. Verifikasi│ ───► │ 3. Isi Data         │
│  & Login     │      │    Email     │      │    Organisasi       │
└─────────────┘      └──────────────┘      └──────────┬──────────┘
                                                        ▼
┌───────────────────┐   ┌────────────────────┐   ┌──────────────────────┐
│ 6. Terbit Kartu     │◄──│ 5. Admin Verifikasi│◄──│ 4. Lengkapi Anggota,  │
│    Anggota (KTA)    │   │    per-item data   │   │    Inventaris & Berkas│
└─────────┬───────────┘   └──────────┬─────────┘   └───────────┬───────────┘
          │                          │ (ditolak)                │
          │                          ▼                          │
          │              ┌────────────────────┐                 │
          │              │ Revisi & submit ulang│◄───────────────┘
          │              └────────────────────┘
          ▼
┌─────────────────────┐      ┌────────────────────────┐
│ 7. Kartu Kedaluwarsa │ ───► │ 8. Perpanjangan (klaim  │
│    (masa aktif habis)│      │    data lama via KTA)   │
└─────────────────────┘      └────────────────────────┘
```

### Penjelasan tahap demi tahap

1. **Registrasi & Autentikasi** — `AuthController`
   User mendaftar akun, menerima **kode verifikasi via email**, lalu login. Admin punya panel terpisah untuk kelola akun user (aktif/nonaktif, reset verifikasi).

2. **Isi Data Organisasi** — `OrganisasiController`
   Pengurus mengisi profil kelompok kesenian: nama, tanggal berdiri, jenis & sub-jenis kesenian, jumlah anggota, serta lokasi (kabupaten → kecamatan → desa) yang **dropdown-nya berjenjang otomatis** lewat endpoint AJAX (`getKecamatan`, `getDesa`, `getSubKesenian`).

3. **Formulir Pendaftaran Multi-Step** — `DaftarController`
   Setelah profil dasar tersimpan, sistem mengarahkan ke form berkelanjutan untuk melengkapi:
    - Data anggota (`DataAnggotaController`)
    - Data pendukung / dokumen wajib: **KTP, Pas Foto, Banner** (`DataPendukungController`)
    - Inventaris kesenian, alat/properti (`InventarisController`)

    Sistem otomatis **mengunci ulang pengajuan** jika sebelumnya ditolak, dan mencegah submit ganda saat status masih _menunggu verifikasi_ atau sudah _disetujui_.

4. **Submit ke Admin** — `DaftarController::submit()`
   Sistem memvalidasi kelengkapan dokumen wajib sebelum mengizinkan pengajuan dikirim. Status berubah menjadi `Menunggu Verifikasi`.

5. **Verifikasi Berjenjang oleh Admin** — `VerifikasiController`
   Admin meninjau **per item** (data organisasi, tiap anggota, tiap dokumen, tiap inventaris) — bukan asal approve/reject satu tombol. Tiap item bisa ditandai _valid_ atau _tidak valid_ lengkap dengan catatan revisi. Sistem otomatis mengecek `checkAllVerifikasiValid()` untuk menentukan kapan pengajuan bisa disetujui penuh.

6. **Approve / Reject** — status organisasi berubah menjadi `Allow` (disetujui) atau `Denny` (ditolak, dengan catatan revisi yang tampil ke user).

7. **Penerbitan Kartu Tanda Anggota (KTA)** — `KartuController` & `VerifikasiController::generateImageCard()` / `generateCard()`
   Setelah disetujui, sistem men-generate **kartu digital berbasis gambar** (nama ketua, nomor induk, alamat, masa berlaku) menggunakan library image processing, siap dicetak atau diunduh sebagai PDF.

8. **Perpanjangan Kartu** — `PerpanjangController`
   Untuk kelompok lama yang kartunya kedaluwarsa, tersedia mekanisme **klaim data lama** cukup dengan memasukkan nomor kartu + nama ketua — tanpa perlu mendaftar dari nol.

### Di sisi Admin

- **Dashboard & Statistik** — `AdminController` menyajikan ringkasan jumlah kesenian aktif/nonaktif, jumlah user aktif/nonaktif, lengkap dengan detail sekali klik (AJAX modal) dan laporan.
- **Data Kesenian Terpusat** — `KesenianController` menyediakan tabel besar dengan filter (pencarian nama, jenis, kecamatan, status) + **export PDF** (dikelompokkan per kecamatan) dan **export Excel**.
- **Master Data** — `WilayahController` (data wilayah kabupaten/kecamatan/desa) dan `JenisKesenianController` (kategori & sub-kategori kesenian) dikelola terpisah agar dropdown pendaftaran selalu konsisten.
- **Manajemen User** — `UsersController` & bagian admin di `AuthController` untuk CRUD akun, ubah status, dan reset verifikasi email.
- **Dokumen Resmi** — `WordController` men-generate surat/berkas resmi (misalnya surat keterangan) dalam format Word secara otomatis dari data organisasi.

---

## 🗂️ Peta Controller

| Controller                                | Fungsi Utama                                                              |
| ----------------------------------------- | ------------------------------------------------------------------------- |
| `RoleController`                          | Register, login, verifikasi email (kode OTP), logout, kelola user (admin) |
| `DashboardController`                     | Landing page, dashboard user, dashboard admin (routing awal)              |
| `OrgController`                           | Profil organisasi kesenian + dropdown wilayah/jenis kesenian berjenjang   |
| `RegisterController`                      | Formulir pendaftaran multi-step, submit, halaman status pengajuan         |
| `AnggotaController` / `AnggotaController` | CRUD anggota kelompok kesenian (sisi user & sisi admin)                   |
| `PendukungController`                     | Upload dokumen pendukung (KTP, pas foto, banner, dll)                     |
| `InventarisasiController`                 | CRUD data inventaris/aset kesenian                                        |
| `VerifikasiController`                    | Verifikasi berjenjang per item, approve/reject, generate kartu            |
| `CardController`                          | Generator gambar Kartu Tanda Anggota (KTA)                                |
| `Extontroller`                            | Klaim/perpanjangan data organisasi lama via nomor kartu                   |
| `AdmController`                           | Dashboard statistik & laporan admin                                       |
| `KesenianController`                      | Data terpusat kesenian: filter, pencarian, export PDF/Excel               |
| `WilayahController`                       | Master data wilayah (kabupaten/kecamatan/desa)                            |
| `JenisKesenianController`                 | Master data jenis & sub-jenis kesenian                                    |
| `UsersController`                         | Manajemen akun pengguna oleh admin                                        |
| `WordController`                          | Generate dokumen resmi (Word)                                             |
| `LayoutController`                        | Helper role & hak akses untuk view (isAdmin, isUserKik, dll)              |
| `DashboardController` (namespace `User`)  | Dashboard ringkas untuk user                                              |

---

## 🆕 Fitur Baru: Input Kegiatan Kesenian

> ⚠️ **Catatan:** Detail spesifik fitur ini belum tercatat di riwayat percakapan yang bisa saya akses, sehingga rancangan di bawah adalah usulan berdasarkan konteks aplikasi (sistem pendataan kesenian). Silakan sesuaikan field/alur bila berbeda dari yang pernah didiskusikan sebelumnya.

Setiap organisasi kesenian yang **sudah terverifikasi (`status = Allow`)** dapat mencatat **kegiatan/pentas** yang pernah atau akan mereka lakukan — pentas budaya, festival, latihan rutin, undangan tampil, dsb. Data ini menjadi bahan untuk:

- Portofolio digital kelompok kesenian (ditampilkan di halaman publik).
- Bahan laporan Dinas terkait aktivitas kesenian di wilayahnya.
- Sumber konten untuk **Landing Page Pusat Informasi Kegiatan Kesenian** (lihat bagian berikutnya).

### Rancangan Controller: `KegiatanController`

| Method                   | Endpoint (contoh)                 | Deskripsi                                                    |
| ------------------------ | --------------------------------- | ------------------------------------------------------------ |
| `index()`                | `GET /kegiatan`                   | Daftar kegiatan milik organisasi login (user)                |
| `create()`               | `GET /kegiatan/create`            | Form tambah kegiatan                                         |
| `store()`                | `POST /kegiatan`                  | Simpan kegiatan baru                                         |
| `edit($id)`              | `GET /kegiatan/{id}/edit`         | Form edit kegiatan                                           |
| `update($id)`            | `PUT /kegiatan/{id}`              | Update kegiatan                                              |
| `destroy($id)`           | `DELETE /kegiatan/{id}`           | Hapus kegiatan                                               |
| `uploadDokumentasi($id)` | `POST /kegiatan/{id}/dokumentasi` | Upload foto/video dokumentasi                                |
| `publish($id)` (admin)   | `PATCH /kegiatan/{id}/publish`    | Admin menyetujui kegiatan agar tampil di landing page publik |

### Rancangan skema data `Kegiatan`

| Kolom                               | Tipe                 | Keterangan                                             |
| ----------------------------------- | -------------------- | ------------------------------------------------------ |
| `id`                                | bigint               | PK                                                     |
| `organisasi_id`                     | FK → `organisasi`    | Pemilik kegiatan                                       |
| `judul_kegiatan`                    | string               | Nama kegiatan/pentas                                   |
| `jenis_kegiatan`                    | enum                 | `Pentas`, `Latihan`, `Festival`, `Undangan`, `Lainnya` |
| `deskripsi`                         | text                 | Ringkasan kegiatan                                     |
| `tanggal_mulai` / `tanggal_selesai` | date                 | Rentang waktu kegiatan                                 |
| `lokasi`                            | string               | Tempat kegiatan berlangsung                            |
| `dokumentasi`                       | json/relasi 1-banyak | Foto/video kegiatan                                    |
| `status_publikasi`                  | enum                 | `Draft`, `Menunggu Review`, `Terbit`, `Ditolak`        |
| `dilihat_oleh` (opsional)           | int                  | Counter kunjungan halaman publik                       |

### Alur singkat

```
Pengurus input kegiatan → status "Menunggu Review"
        │
        ▼
Admin review (opsional, mirip pola verifikasi organisasi)
        │
   ┌────┴────┐
   ▼         ▼
Terbit     Ditolak (+ catatan revisi)
   │
   ▼
Tampil otomatis di Landing Page Pusat Informasi Kegiatan Kesenian
```

Pola ini **konsisten dengan alur verifikasi yang sudah ada** (`VerifikasiController`), sehingga admin tetap punya kendali kualitas atas konten yang tayang ke publik — tanpa perlu membangun mekanisme approval baru dari nol.

---

## 🆕 Fitur Baru: Landing Page Pusat Informasi Kegiatan Kesenian

Halaman publik (**tanpa perlu login**) yang berfungsi sebagai etalase digital kesenian daerah — dari sisi marketing, ini adalah **halaman akuisisi & engagement** yang menonjolkan aktivitas budaya secara visual dan mudah dibagikan ke media sosial.

### Tujuan halaman

1. **Showcase** — menampilkan kegiatan kesenian terbaru & mendatang dari seluruh organisasi terverifikasi.
2. **Discovery** — pengunjung bisa menjelajah berdasarkan jenis kesenian, wilayah (kecamatan/desa), atau rentang tanggal.
3. **Kredibilitas & SEO** — mendukung citra Dinas Kebudayaan sebagai pusat data seni daerah yang aktif & transparan, sekaligus jadi konten yang mudah diindeks mesin pencari dan dibagikan.

### Rancangan struktur halaman

```
┌───────────────────────────────────────────────┐
│  🎭 Hero Section                                │
│  "Pusat Informasi Kegiatan Kesenian [Daerah]"  │
│  + search bar (nama kegiatan / kelompok)        │
├───────────────────────────────────────────────┤
│  📅 Kegiatan Mendatang (highlight/carousel)     │
├───────────────────────────────────────────────┤
│  🔍 Filter: Jenis Kesenian | Kecamatan | Tanggal│
├───────────────────────────────────────────────┤
│  🗂️ Grid Kartu Kegiatan (gambar, judul, tanggal,│
│      lokasi, nama kelompok kesenian)            │
├───────────────────────────────────────────────┤
│  📊 Statistik Publik: total kelompok kesenian,  │
│      total kegiatan tahun ini, sebaran wilayah  │
├───────────────────────────────────────────────┤
│  📍 Peta sebaran kelompok kesenian per kecamatan│
└───────────────────────────────────────────────┘
```

### Rancangan Controller: `LandingKegiatanController`

| Method                     | Endpoint                               | Deskripsi                           |
| -------------------------- | -------------------------------------- | ----------------------------------- |
| `index()`                  | `GET /kegiatan-kesenian`               | Halaman utama landing page publik   |
| `show($id)`                | `GET /kegiatan-kesenian/{id}`          | Detail satu kegiatan + dokumentasi  |
| `filter(Request $request)` | `GET /kegiatan-kesenian/filter` (AJAX) | Filter dinamis tanpa reload halaman |

Sumber data halaman ini murni dari kegiatan dengan `status_publikasi = Terbit` milik organisasi yang `status = Allow` — jadi hanya konten yang sudah lolos verifikasi yang tampil ke publik, sejalan dengan filosofi data quality yang sudah dipakai di seluruh aplikasi ini.

> 💡 **Insight marketing:** halaman ini idealnya juga dilengkapi meta tag Open Graph per kegiatan (judul, gambar, deskripsi) agar tampilan preview saat dibagikan ke WhatsApp/Instagram/Facebook menarik — mendorong warga untuk datang menonton pentas kesenian lokal.

---

## 🔐 Role & Hak Akses

Dikelola lewat `LayoutController` sebagai helper role check yang dipakai di view/middleware:

| Role                         | Bisa Apa Saja                                                                                                                  |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| **Guest**                    | Lihat landing page, register, login                                                                                            |
| **User (Pengurus Kesenian)** | Kelola data organisasi sendiri, anggota, inventaris, dokumen, kegiatan, lihat status verifikasi, unduh kartu setelah disetujui |
| **Admin (Dinas)**            | Semua di atas + verifikasi pengajuan, kelola master data, kelola user, export laporan, publish kegiatan ke landing page        |

---

## 🟢 Struktur Status Organisasi

| Status                | Arti                                       |
| --------------------- | ------------------------------------------ |
| `Request`             | Baru dibuat, belum submit lengkap          |
| `Menunggu Verifikasi` | Sudah submit, menunggu admin               |
| `Allow`               | Disetujui — kartu bisa diterbitkan         |
| `Denny`               | Ditolak — user harus revisi & submit ulang |

---

## ⚙️ Instalasi Singkat

```bash
git clone <repo-url>
cd project
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate --seed
php artisan serve
```

Pastikan konfigurasi **mail** (untuk verifikasi email OTP) dan library **Intervention Image** (untuk generate kartu) sudah terpasang & dikonfigurasi di `.env`.

---

## 🗺️ Roadmap

- [ ] Modul **Input Kegiatan Kesenian** (`KegiatanController`)
- [ ] **Landing Page Pusat Informasi Kegiatan Kesenian** publik
- [ ] Notifikasi WhatsApp/Email otomatis saat status verifikasi berubah
- [ ] Statistik & dashboard analytics kegiatan per wilayah
- [ ] API publik read-only untuk integrasi dengan portal Pemda

---

<p align="center">Dibuat dengan 🎨 untuk pelestarian & digitalisasi kesenian daerah.</p>
