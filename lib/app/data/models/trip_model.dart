class Trip {
  final String ruteId;
  final String terminalAwal;
  final String terminalTujuan;
  final String tanggal;
  final String namaBus;
  final String nopol;
  final int jumlahPenumpang;
  final String kedatangan;
  final List<Deteksi> deteksi;

  Trip({
    required this.ruteId,
    required this.terminalAwal,
    required this.terminalTujuan,
    required this.tanggal,
    required this.namaBus,
    required this.nopol,
    required this.jumlahPenumpang,
    required this.kedatangan,
    required this.deteksi,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      ruteId: json['rute_operasional_id'] ?? '',
      terminalAwal: json['terminal_awal'] ?? '',
      terminalTujuan: json['terminal_tujuan'] ?? '',
      tanggal: json['tanggal'] ?? '',
      namaBus: json['nama_bus'] ?? '',
      nopol: json['nopol'] ?? '',
      jumlahPenumpang: json['jumlah_penumpang'] ?? 0,
      kedatangan: json['kedatangan'] ?? '-',
      deteksi: (json['deteksi'] as List<dynamic>)
          .map((e) => Deteksi.fromJson(e))
          .toList(),
    );
  }
}

class Deteksi {
  final String label;
  final String timestamp;

  Deteksi({required this.label, required this.timestamp});

  factory Deteksi.fromJson(Map<String, dynamic> json) {
    return Deteksi(
      label: json['label_detection'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }
}
