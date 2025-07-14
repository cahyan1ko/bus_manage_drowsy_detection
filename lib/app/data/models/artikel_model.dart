class ArtikelModel {
  final String artikelId;
  final String judul;
  final String gambar;
  final String? konten;

  ArtikelModel({
    required this.artikelId,
    required this.judul,
    required this.gambar,
    this.konten,
  });

  factory ArtikelModel.fromJson(Map<String, dynamic> json) {
    return ArtikelModel(
      artikelId: json['artikel_id'] ?? '',
      judul: json['judul'] ?? '',
      gambar: json['gambar'] ?? '',
      konten: json['konten'],
    );
  }
}
