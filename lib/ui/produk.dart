class Produk {
  String? id, kode, nama, urlGambar, kategori, deskripsi;
  int? harga;

  Produk({
    this.id, 
    this.kode, 
    this.nama, 
    this.harga, 
    this.urlGambar,
    this.kategori,
    this.deskripsi,
  });

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id'].toString(),
      kode: json['kode'].toString(),
      nama: json['nama'].toString(),
      urlGambar: json['url_gambar'],
      kategori: json['kategori'] ?? "",
      deskripsi: json['deskripsi'] ?? "",
      harga: int.tryParse(json['harga'].toString()) ?? 0,
    );
  }

  static String formatRupiah(int nominal) {
    String nominalString = nominal.toString();
    String hasil = "";
    int counter = 0;
    for (int i = nominalString.length - 1; i >= 0; i--) {
      counter++;
      hasil = nominalString[i] + hasil;
      if (counter % 3 == 0 && i != 0) hasil = "." + hasil;
    }
    return "Rp $hasil";
  }
}