import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latihan/ui/produk.dart';
import 'package:latihan/ui/api.dart';
import 'package:latihan/ui/produk_form.dart';
import 'package:latihan/ui/produk_detail.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});
  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  List<Produk> listProduk = [], listProdukFilter = [];
  bool loading = true;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ambilData();
  }

  Future<void> ambilData() async {
    try {
      final res = await http.get(Uri.parse(BaseUrl.data));
      if (res.statusCode == 200) {
        setState(() {
          listProduk = (json.decode(res.body) as List).map((i) => Produk.fromJson(i)).toList();
          listProdukFilter = listProduk;
          loading = false;
        });
      }
    } catch (e) { debugPrint("$e"); }
  }

  void filterSearch(String q) {
    setState(() => listProdukFilter = listProduk.where((p) => 
      p.nama!.toLowerCase().contains(q.toLowerCase()) || p.kode!.toLowerCase().contains(q.toLowerCase())).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Text('Katalog Produk Kecantikan', style: TextStyle(fontWeight: FontWeight.w900)),
        centerTitle: true, backgroundColor: Colors.blueAccent, foregroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController, onChanged: filterSearch,
              decoration: InputDecoration(
                hintText: "Cari produk...", prefixIcon: const Icon(Icons.search),
                filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProdukForm())),
        label: const Text("TAMBAH"), icon: const Icon(Icons.add), backgroundColor: Colors.blueAccent,
      ),
      body: loading ? const Center(child: CircularProgressIndicator()) : RefreshIndicator(
        onRefresh: ambilData,
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: listProdukFilter.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final item = listProdukFilter[i];
            return TweenAnimationBuilder(
              duration: Duration(milliseconds: 300 + (i * 50)),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double val, child) => Opacity(opacity: val, child: Transform.translate(offset: Offset(0, 20 * (1-val)), child: child)),
              child: Card(
                elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProdukDetail(produk: item))),
                  leading: Hero(tag: 'img${item.id}', child: ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network(item.urlGambar!, width: 50, height: 50, fit: BoxFit.cover, errorBuilder: (_,__,___) => const Icon(Icons.image)))),
                  title: Text(item.nama!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(Produk.formatRupiah(item.harga ?? 0), style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                  trailing: const Icon(Icons.chevron_right, size: 18),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}