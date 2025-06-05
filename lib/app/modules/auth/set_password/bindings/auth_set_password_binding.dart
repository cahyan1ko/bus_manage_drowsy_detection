import 'package:get/get.dart';

import '../controllers/auth_set_password_controller.dart';

class AuthSetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthSetPasswordController>(
      () => AuthSetPasswordController(),
    );
  }
}
