# 📦 Produk App - Flutter & PHP Backend

[![Flutter](https://img.shields.io/badge/Framework-Flutter-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![PHP](https://img.shields.io/badge/Backend-PHP-777BB4?logo=php&logoColor=white)](https://www.php.net)
[![MySQL](https://img.shields.io/badge/Database-MySQL-4479A1?logo=mysql&logoColor=white)](https://www.mysql.com)

Aplikasi manajemen produk yang terintegrasi dengan database MySQL melalui REST API yang dibangun menggunakan PHP. Proyek ini mencakup sisi Frontend (Flutter) dan Backend (PHP API).

---

## 📸 Tampilan Aplikasi

| Halaman Utama | Form Tambah Produk | Detail Produk |
| :---: | :---: | :---: |
| <img width="1366" height="632" alt="dashboard" src="https://github.com/user-attachments/assets/60359871-33de-4133-a60d-8a7deecc985e" /> | <img width="1366" height="633" alt="form" src="https://github.com/user-attachments/assets/6dc2b71d-c426-426d-ad80-e3b6cd74ce29" /> | <img width="1366" height="632" alt="dashboard" src="https://github.com/user-attachments/assets/0a29ce95-9d5f-4d05-9ed1-8ffb79c6ab68" /> |

---

## 🚀 Fitur Utama
* **🌐 REST API Integration**: Komunikasi data lancar antara Flutter dan PHP.
* **📊 CRUD Operations**: Mendukung Create (Tambah), Read (Lihat), Update (Edit), dan Delete (Hapus) data produk.
* **📂 Database Management**: Disertai file PHP dan skema SQL untuk setup backend yang cepat.

---

## 📂 Struktur Folder
```text
.
├── database/             # ⬅️ Backend (PHP API & SQL)
│   ├── SQL.txt           # Skema Database (Import ke phpMyAdmin)
│   ├── konekdb.php       # Konfigurasi Koneksi Database
│   └── *.php             # Endpoint API (list, create, detail, update, delete)
├── lib/                  # ⬅️ Frontend (Flutter)
│   ├── ui/               # UI Components (Form, Page, Detail, Widget)
│   └── main.dart         # Entry Point Utama Aplikasi
└── pubspec.yaml          # File Konfigurasi Library & Dependencies
