import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/storage_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageHelper.init();
  print('DEBUG: token di startup = ${StorageHelper.token}');

  runApp(
    GetMaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      title: "Application",
      initialRoute: Routes.SPLASH,
      getPages: AppPages.routes,
    ),
  );
}
