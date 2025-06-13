import 'package:capstone_bus_manage/app/data/providers/api_services.dart';
import 'package:capstone_bus_manage/app/utils/storage_helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/models/rute_model.dart';

class JadwalController extends GetxController {
  var ruteList = <RuteModel>[].obs;
  var isLoading = false.obs;

  var jadwalHariIni = Rxn<RuteModel>();

  @override
  void onInit() {
    super.onInit();
    fetchRuteUser();
  }

  void fetchRuteUser() async {
    try {
      isLoading.value = true;
      final userId = StorageHelper.userId;
      final token = StorageHelper.token;

      print('DEBUG: userId = $userId');
      print('DEBUG: token = $token');

      if (userId == null || token == null) {
        Get.snackbar('Error', 'User belum login atau token tidak tersedia');
        return;
      }

      final result = await ApiServices.getRuteByUser(userId, token);
      ruteList.assignAll(result);

      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final hariIni = result.firstWhereOrNull((rute) {
        final ruteTanggal =
            DateFormat('yyyy-MM-dd').format(DateTime.parse(rute.tanggal));
        return ruteTanggal == today;
      });

      jadwalHariIni.value = hariIni;
    } catch (e, stackTrace) {
      Get.snackbar('Error', 'Gagal mengambil data rute');
      print('DEBUG: error = $e');
      print('DEBUG: stackTrace = $stackTrace');
    } finally {
      isLoading.value = false;
    }
  }
}
