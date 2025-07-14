import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/artikel_model.dart';
import '../../../data/providers/api_services.dart';

class TipsDetailView extends StatelessWidget {
  const TipsDetailView({super.key});
  static const baseColor = Color(0xFFE25353);

  @override
  Widget build(BuildContext context) {
    final artikelId = Get.arguments;
    print('DEBUG: artikelId = $artikelId');

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text("Tips Detail"),
        backgroundColor: baseColor,
        elevation: 3,
        centerTitle: true,
        foregroundColor: Colors.white, // <- teks AppBar jadi putih
        iconTheme:
            const IconThemeData(color: Colors.white), // <- ikon jadi putih
      ),
      body: FutureBuilder<ArtikelModel>(
        future: ApiServices.fetchArtikelDetail(artikelId.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
              child: Text(
                'Gagal memuat detail tips.',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          final artikel = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: artikel.gambar.isNotEmpty
                        ? Image.network(
                            artikel.gambar.trim(),
                            width: double.infinity,
                            height: 220,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 220,
                            color: Colors.grey[200],
                            child:
                                const Center(child: Text("Tidak ada gambar")),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  artikel.judul,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: baseColor,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Text(
                    artikel.konten ?? 'Konten tidak tersedia',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}
