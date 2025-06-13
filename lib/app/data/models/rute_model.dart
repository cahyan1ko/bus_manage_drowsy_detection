class RuteModel {
  final String id;
  final String terminalAwal;
  final String terminalTujuan;
  final String tanggal;
  final String jam;
  final int jumlahPenumpang;
  final String armadaId;
  final String namaBus;
  final String nopol;
  final String? createdAt;

  RuteModel({
    required this.id,
    required this.terminalAwal,
    required this.terminalTujuan,
    required this.tanggal,
    required this.jam,
    required this.jumlahPenumpang,
    required this.armadaId,
    required this.namaBus,
    required this.nopol,
    this.createdAt,
  });

  factory RuteModel.fromJson(Map<String, dynamic> json) {
    return RuteModel(
      id: json['_id'],
      terminalAwal: json['terminal_awal'],
      terminalTujuan: json['terminal_tujuan'],
      tanggal: json['tanggal'],
      jam: json['jam'],
      jumlahPenumpang: int.tryParse(json['jumlah_penumpang'].toString()) ?? 0,
      armadaId: json['armada_id'],
      namaBus: json['nama_bus'],
      nopol: json['nopol'],
      createdAt: json['created_at'],
    );
  }
}
