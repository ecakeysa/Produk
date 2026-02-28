# 📦 Produk App - Flutter & PHP Backend

[![Flutter](https://img.shields.io/badge/Framework-Flutter-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![PHP](https://img.shields.io/badge/Backend-PHP-777BB4?logo=php&logoColor=white)](https://www.php.net)
[![MySQL](https://img.shields.io/badge/Database-MySQL-4479A1?logo=mysql&logoColor=white)](https://www.mysql.com)

Aplikasi manajemen produk yang terintegrasi dengan database MySQL melalui REST API yang dibangun menggunakan PHP. Proyek ini mencakup sisi Frontend (Flutter) dan Backend (PHP API).

---

## 📸 Tampilan Aplikasi

| Halaman Utama | Form Tambah Produk | Detail Produk |
| :---: | :---: | :---: |
| <img src="https://github.com/user-attachments/assets/7e4ae4f8-7360-4462-af8c-dc979267ed10" width="250"> | <img src="https://github.com/user-attachments/assets/00e99d25-c0da-4009-b19d-0df05327747c" width="250"> | <img src="https://github.com/user-attachments/assets/9c9d30de-cf45-46c7-8ebd-d8a9743d8ca5" width="250"> |

---

## 🚀 Fitur Utama
* **🌐 REST API Integration**: Komunikasi data lancar antara Flutter dan PHP.
* **📊 CRUD Operations**: Mendukung Create, Read, Update, dan Delete data produk.
* **📂 Structured Code**: Pemisahan folder antara Frontend (Flutter) dan Backend (PHP).
* **💾 Database Management**: Disertai file konfigurasi SQL untuk setup database cepat.

---

## 📂 Struktur Folder
```text
.
├── api_produk/           # ⬅️ Backend (PHP API & SQL)
│   ├── SQL.txt           # Skema Database
│   ├── konekdb.php       # Koneksi Database
│   └── *.php             # Endpoint API (List, Create, Update, Delete)
├── lib/                  # ⬅️ Frontend (Flutter)
│   ├── ui/               # Tampilan Halaman (Form, Page, Detail)
│   └── main.dart         # Entry Point Aplikasi
└── pubspec.yaml          # Library & Dependencies
