import 'package:get/get.dart';

class Trip {
  final String dari;
  final String tujuan;
  final String tanggal;
  final String namaSupir;
  final String armada;
  final String? kedatangan; // nullable
  final int? jumlahPenumpangAwal; // nullable
  final String status;

  Trip({
    required this.dari,
    required this.tujuan,
    required this.tanggal,
    required this.namaSupir,
    required this.armada,
    this.kedatangan,
    this.jumlahPenumpangAwal,
    required this.status,
  });

  String get route => "$dari - $tujuan";
}

class RiwayatController extends GetxController {
  var isLoading = true.obs;
  var tripHistory = <Trip>[].obs;
  var selectedStatus = 'Semua'.obs;
  var expandedIndex = RxnInt();

  @override
  void onInit() {
    super.onInit();
    fetchTripHistory();
  }

  void fetchTripHistory() async {
    await Future.delayed(const Duration(seconds: 2));
    tripHistory.value = [
      Trip(
        dari: "Jakarta",
        tujuan: "Bandung",
        tanggal: "2025-05-05",
        namaSupir: "Andi",
        armada: "Bus A1",
        kedatangan: "2025-05-05 12:00",
        jumlahPenumpangAwal: 40,
        status: "Selesai",
      ),
      Trip(
        dari: "Jakarta",
        tujuan: "Bandung",
        tanggal: "2025-05-05",
        namaSupir: "Andi",
        armada: "Bus A1",
        kedatangan: "2025-05-05 12:00",
        jumlahPenumpangAwal: 40,
        status: "Selesai",
      ),
      Trip(
        dari: "Jakarta",
        tujuan: "Bandung",
        tanggal: "2025-05-05",
        namaSupir: "Andi",
        armada: "Bus A1",
        kedatangan: "2025-05-05 12:00",
        jumlahPenumpangAwal: 40,
        status: "Selesai",
      ),
      Trip(
        dari: "Jakarta",
        tujuan: "Bandung",
        tanggal: "2025-05-05",
        namaSupir: "Andi",
        armada: "Bus A1",
        kedatangan: "2025-05-05 12:00",
        jumlahPenumpangAwal: 40,
        status: "Selesai",
      ),
      Trip(
        dari: "Jakarta",
        tujuan: "Bandung",
        tanggal: "2025-05-05",
        namaSupir: "Andi",
        armada: "Bus A1",
        kedatangan: "2025-05-05 12:00",
        jumlahPenumpangAwal: 40,
        status: "Selesai",
      ),
      Trip(
        dari: "Jakarta",
        tujuan: "Bandung",
        tanggal: "2025-05-05",
        namaSupir: "Andi",
        armada: "Bus A1",
        kedatangan: "2025-05-05 12:00",
        jumlahPenumpangAwal: 40,
        status: "Selesai",
      ),
      Trip(
        dari: "Jakarta",
        tujuan: "Bandung",
        tanggal: "2025-05-05",
        namaSupir: "Andi",
        armada: "Bus A1",
        kedatangan: "2025-05-05 12:00",
        jumlahPenumpangAwal: 40,
        status: "Selesai",
      ),
      Trip(
        dari: "Jakarta",
        tujuan: "Bandung",
        tanggal: "2025-05-05",
        namaSupir: "Andi",
        armada: "Bus A1",
        kedatangan: "2025-05-05 12:00",
        jumlahPenumpangAwal: 40,
        status: "Selesai",
      ),
      Trip(
        dari: "Jakarta",
        tujuan: "Bandung",
        tanggal: "2025-05-05",
        namaSupir: "Andi",
        armada: "Bus A1",
        kedatangan: "2025-05-05 12:00",
        jumlahPenumpangAwal: 40,
        status: "Selesai",
      ),
      Trip(
        dari: "Jakarta",
        tujuan: "Bandung",
        tanggal: "2025-05-05",
        namaSupir: "Andi",
        armada: "Bus A1",
        kedatangan: "2025-05-05 12:00",
        jumlahPenumpangAwal: 40,
        status: "Selesai",
      ),
      Trip(
        dari: "Jakarta",
        tujuan: "Bandung",
        tanggal: "2025-05-05",
        namaSupir: "Andi",
        armada: "Bus A1",
        kedatangan: "2025-05-05 12:00",
        jumlahPenumpangAwal: 40,
        status: "Selesai",
      ),
      Trip(
        dari: "Bandung",
        tujuan: "Surabaya",
        tanggal: "2025-05-04",
        namaSupir: "Budi",
        armada: "Bus B2",
        kedatangan: null,
        jumlahPenumpangAwal: 35,
        status: "Dalam Perjalanan",
      ),
      // Tambahkan data lainnya...
    ];
    isLoading.value = false;
  }

  List<Trip> get filteredTrips {
    if (selectedStatus.value == 'Semua') {
      return tripHistory;
    } else {
      return tripHistory
          .where((trip) => trip.status == selectedStatus.value)
          .toList();
    }
  }

  int get total => tripHistory.length;
  int get selesai =>
      tripHistory.where((trip) => trip.status == 'Selesai').length;
  int get dalamPerjalanan =>
      tripHistory.where((trip) => trip.status == 'Dalam Perjalanan').length;
}
