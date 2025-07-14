import 'package:capstone_bus_manage/app/data/providers/api_services.dart';
import 'package:capstone_bus_manage/app/utils/storage_helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Deteksi {
  final String label;
  final String timestamp;

  Deteksi({
    required this.label,
    required this.timestamp,
  });

  factory Deteksi.fromJson(Map<String, dynamic> json) {
    return Deteksi(
      label: json['label_detection'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }
}

class Trip {
  final String ruteOperasionalId;
  final String dari;
  final String tujuan;
  final String tanggal;
  final String namaBus;
  final String nopol;
  final int jumlahPenumpang;
  final String kedatangan;
  final List<Deteksi> deteksi;
  final String status;

  Trip({
    required this.ruteOperasionalId,
    required this.dari,
    required this.tujuan,
    required this.tanggal,
    required this.namaBus,
    required this.nopol,
    required this.jumlahPenumpang,
    required this.kedatangan,
    required this.deteksi,
    required this.status,
  });

  factory Trip.fromMap(Map<String, dynamic> json) {
    final List<dynamic> deteksiList = json['deteksi'] ?? [];
    return Trip(
      ruteOperasionalId: json['rute_operasional_id'] ?? '',
      dari: json['terminal_awal'] ?? '',
      tujuan: json['terminal_tujuan'] ?? '',
      tanggal: json['tanggal'] ?? '',
      namaBus: json['nama_bus'] ?? '',
      nopol: json['nopol'] ?? '',
      jumlahPenumpang: json['jumlah_penumpang'] is int
          ? json['jumlah_penumpang']
          : int.tryParse(json['jumlah_penumpang']?.toString() ?? '0') ?? 0,
      kedatangan: json['kedatangan'] ?? '',
      deteksi: deteksiList.map((d) => Deteksi.fromJson(d)).toList(),
      status: (json['status'] ?? 'off').toString().toLowerCase(),
    );
  }
  String get kedatanganFormatted {
    if (kedatangan.isEmpty) return "Belum tiba";

    try {
      final parsed = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'", 'en_US')
          .parseUTC(kedatangan)
          .toLocal();

      return DateFormat("EEEE, dd MMM yyyy, HH:mm", "id_ID").format(parsed);
    } catch (e) {
      return kedatangan;
    }
  }

  String get persentaseMengantuk {
    if (deteksi.isEmpty) return '0%';

    final total = deteksi.length;
    final jumlahDrowsy =
        deteksi.where((d) => d.label.toLowerCase() == 'drowsy').length;

    final persen = (jumlahDrowsy / total * 100).round();

    return '$persen%';
  }

  DateTime get tanggalDateTime {
    try {
      return DateFormat("yyyy-MM-dd").parse(tanggal);
    } catch (e) {
      return DateTime(2000);
    }
  }

  String get statusLabel {
    switch (status) {
      case 'off':
        return 'Belum Berangkat';
      case 'ongoing':
        return 'Dalam Perjalanan';
      case 'finish':
        return 'Selesai';
      default:
        return 'Tidak Diketahui';
    }
  }

  String get route => "$dari - $tujuan";
}

class RiwayatController extends GetxController {
  var isLoading = true.obs;
  var tripHistory = <Trip>[].obs;
  var selectedOrder = 'Terbaru'.obs;
  var expandedIndex = RxnInt();
  var showChart = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRiwayat();
  }

  void fetchRiwayat() async {
    try {
      isLoading.value = true;
      final userId = StorageHelper.userId!;
      final riwayat = await ApiServices.getRiwayatOperasional(userId: userId);

      final loadedTrips = riwayat.map((map) => Trip.fromMap(map)).toList()
        ..sort((a, b) => b.tanggalDateTime.compareTo(a.tanggalDateTime));

      tripHistory.assignAll(loadedTrips);
      print("✅ Total trip: ${loadedTrips.length}");
    } catch (e) {
      print("❌ Gagal memuat riwayat: $e");
    } finally {
      isLoading.value = false;
    }
  }

  List<Trip> get filteredTrips {
    List<Trip> result = tripHistory;

    // Urutkan berdasarkan dropdown
    if (selectedOrder.value == 'Terlama') {
      result = result.reversed.toList();
    }

    return result;
  }

  int get totalPerjalanan => tripHistory.length;

  int get totalDeteksi {
    return tripHistory.fold(0, (sum, trip) => sum + trip.deteksi.length);
  }

  int get totalDrowsy {
    return tripHistory.fold(0, (sum, trip) {
      return sum +
          trip.deteksi.where((d) => d.label.toLowerCase() == 'drowsy').length;
    });
  }

  int get persentaseMengantukAllValue {
    if (totalDeteksi == 0) return 0;
    return (totalDrowsy / totalDeteksi * 100).round();
  }

  DateTime? parseTanggal(String raw) {
    try {
      if (raw.contains(',')) {
        // Format dengan nama hari
        return DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz', 'en_US').parse(raw);
      } else if (raw.length == 10) {
        return DateFormat('yyyy-MM-dd').parse(raw);
      } else if (raw.length > 10) {
        return DateFormat('yyyy-MM-dd HH:mm:ss').parse(raw);
      }
    } catch (_) {
      // fallback
    }
    return null;
  }

  Map<String, Map<String, int>> get grafikDeteksiByTanggal {
    Map<String, Map<String, int>> hasil = {};

    for (var trip in tripHistory) {
      for (var deteksi in trip.deteksi) {
        DateTime? parsedDate = parseTanggal(deteksi.timestamp);
        if (parsedDate == null) continue;

        final tanggal = DateFormat('yyyy-MM-dd').format(parsedDate);
        final label = deteksi.label.toLowerCase();

        hasil[tanggal] ??= {'drowsy': 0, 'awake': 0};

        if (label == 'drowsy') {
          hasil[tanggal]!['drowsy'] = hasil[tanggal]!['drowsy']! + 1;
        } else if (label == 'awake') {
          hasil[tanggal]!['awake'] = hasil[tanggal]!['awake']! + 1;
        }
      }
    }

    return hasil;
  }
}
