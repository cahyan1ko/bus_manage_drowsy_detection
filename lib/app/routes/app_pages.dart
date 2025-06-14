import 'package:capstone_bus_manage/app/modules/onboarding/onboarding_view.dart';
import 'package:capstone_bus_manage/splash_view.dart';
import 'package:get/get.dart';

import '../../main_page.dart';
import '../modules/auth/forgot_password/bindings/auth_forgot_password_binding.dart';
import '../modules/auth/forgot_password/views/auth_forgot_password_view.dart';
import '../modules/auth/login/bindings/auth_login_binding.dart';
import '../modules/auth/login/views/auth_login_view.dart';
import '../modules/auth/register/bindings/auth_register_binding.dart';
import '../modules/auth/register/views/auth_register_view.dart';
import '../modules/auth/set_password/bindings/auth_set_password_binding.dart';
import '../modules/auth/set_password/views/auth_set_password_view.dart';
import '../modules/auth/verify_otp/bindings/auth_verify_otp_binding.dart';
import '../modules/auth/verify_otp/views/auth_verify_otp_view.dart';
import '../modules/beranda/bindings/beranda_binding.dart';
import '../modules/beranda/views/beranda_view.dart';
import '../modules/detection/bindings/detection_binding.dart';
import '../modules/detection/views/detection_view.dart';
import '../modules/informasi/bindings/informasi_binding.dart';
import '../modules/informasi/views/informasi_view.dart';
import '../modules/jadwal/bindings/jadwal_binding.dart';
import '../modules/jadwal/views/jadwal_view.dart';
import '../modules/notifikasi/bindings/notifikasi_binding.dart';
import '../modules/notifikasi/views/notifikasi_view.dart';
import '../modules/profil/bindings/profil_binding.dart';
import '../modules/profil/views/profil_view.dart';
import '../modules/riwayat/bindings/riwayat_binding.dart';
import '../modules/riwayat/views/riwayat_view.dart';
import '../modules/tips_detail/bindings/tips_detail_binding.dart';
import '../modules/tips_detail/views/tips_detail_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: '/main',
      page: () => MainPage(),
    ),
    GetPage(name: Routes.SPLASH, page: () => const SplashView()),
    GetPage(name: Routes.ONBOARDING, page: () => const OnboardingView()),

    GetPage(
      name: _Paths.BERANDA,
      page: () => const BerandaView(),
      binding: BerandaBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => AuthLoginView(),
      binding: AuthLoginBinding(),
    ),
    GetPage(
      name: _Paths.JADWAL,
      page: () => const JadwalView(),
      binding: JadwalBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => const ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT,
      page: () => RiwayatView(),
      binding: RiwayatBinding(),
    ),
    GetPage(
      name: _Paths.TIPS_DETAIL,
      page: () => const TipsDetailView(),
      binding: TipsDetailBinding(),
    ),
    GetPage(
      name: _Paths.DETECTION,
      page: () => const DetectionView(),
      binding: DetectionBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const AuthRegisterView(),
      binding: AuthRegisterBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: AuthForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => const VerifyOtpView(),
      binding: AuthVerifyOtpBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFIKASI,
      page: () => const NotifikasiView(),
      binding: NotifikasiBinding(),
    ),
    GetPage(
      name: _Paths.INFORMASI,
      page: () => const InformasiView(),
      binding: InformasiBinding(),
    ),
    GetPage(
      name: _Paths.SET_PASSWORD,
      page: () => const AuthSetPasswordView(),
      binding: AuthSetPasswordBinding(),
    ),
  ];
}
