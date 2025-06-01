import 'package:get/get.dart';

import '../controllers/tips_detail_controller.dart';

class TipsDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TipsDetailController>(
      () => TipsDetailController(),
    );
  }
}
