import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latihan/ui/api.dart';
import 'package:latihan/ui/produk.dart';
import 'package:latihan/ui/produk_page.dart';

class ProdukForm extends StatefulWidget {
  final Produk? produk;
  const ProdukForm({super.key, this.produk});

  @override
  State<ProdukForm> createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _kodeController = TextEditingController();
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _gambarController = TextEditingController();
  final _kategoriController = TextEditingController();
  final _deskripsiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.produk != null) {
      _kodeController.text = widget.produk!.kode ?? "";
      _namaController.text = widget.produk!.nama ?? "";
      _hargaController.text = widget.produk!.harga.toString();
      _gambarController.text = widget.produk!.urlGambar ?? "";
      _kategoriController.text = widget.produk!.kategori ?? "";
      _deskripsiController.text = widget.produk!.deskripsi ?? "";
    }
    _gambarController.addListener(() => setState(() {}));
  }

  Future<bool> simpanProduk() async {
    String url = (widget.produk == null) ? BaseUrl.tambah : BaseUrl.edit;
    
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id": widget.produk?.id, 
          "kode": _kodeController.text,
          "nama": _namaController.text,
          "harga": _hargaController.text,
          "url_gambar": _gambarController.text,
          "kategori": _kategoriController.text,
          "deskripsi": _deskripsiController.text,
        }),
      ).timeout(const Duration(seconds: 10));

      return response.statusCode == 200;
    } catch (e) {
      debugPrint("Error detail: $e");
      return false;
    }
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType type = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: type,
            maxLines: maxLines,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.blueAccent, size: 20),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blueAccent.withOpacity(0.1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        title: Text(
          widget.produk == null ? 'Tambah Produk' : 'Edit Produk',
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        centerTitle: true,
        elevation: 0,
      ),
      body: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 600),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, double value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 30 * (1 - value)),
              child: child,
            ),
          );
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Center(
                child: Hero(
                  tag: 'product_image',
                  child: Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.1),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _gambarController.text.isNotEmpty
                            ? Image.network(
                                _gambarController.text,
                                key: ValueKey(_gambarController.text),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                              )
                            : Icon(Icons.add_photo_alternate_rounded, size: 50, color: Colors.blueAccent.withOpacity(0.3)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(_kodeController, "KODE UNIK", Icons.qr_code_rounded),
              _buildTextField(_namaController, "NAMA PRODUK", Icons.shopping_cart_rounded),
              _buildTextField(
                _hargaController, 
                "HARGA (IDR)", 
                Icons.payments_rounded,
                type: TextInputType.number,
              ),
              _buildTextField(_gambarController, "URL FOTO PRODUK", Icons.image_search_rounded),
              _buildTextField(_kategoriController, "KATEGORI", Icons.category_rounded),
              _buildTextField(
                _deskripsiController, 
                "DESKRIPSI", 
                Icons.description_rounded,
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 60,
                margin: const EdgeInsets.only(bottom: 40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    elevation: 8,
                    shadowColor: Colors.blueAccent.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () async {
                    if (_kodeController.text.isEmpty ||
                        _namaController.text.isEmpty ||
                        _hargaController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Lengkapi Kode, Nama, dan Harga!"),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.orangeAccent,
                        ),
                      );
                      return;
                    }

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(color: Colors.blueAccent),
                      ),
                    );

                    bool sukses = await simpanProduk();
                    
                    if (!mounted) return;
                    Navigator.pop(context);

                    if (sukses) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const ProdukPage()),
                        (route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Terjadi kesalahan sistem."),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  child: Text(
                    widget.produk == null ? "TAMBAHKAN PRODUK" : "UPDATE DATA",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}