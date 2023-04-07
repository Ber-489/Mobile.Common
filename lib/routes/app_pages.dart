import 'package:get/get.dart';
import 'package:source_base/modules/change_password/binding/change_password_binding.dart';
import 'package:source_base/modules/change_password/view/change_password_screen.dart';
import 'package:source_base/modules/list_chat/binding/list_chat_binding.dart';
import 'package:source_base/modules/list_chat/view/list_chat_screen.dart';
import 'package:source_base/modules/register/binding/register_binding.dart';
import 'package:source_base/modules/register/view/register_screen.dart';

import '../modules/account/binding/setting_binding.dart';
import '../modules/account/view/setting_screen.dart';
import '../modules/home/binding/home_binding.dart';
import '../modules/home/view/home_screen.dart';
import '../modules/login/binding/login_binding.dart';
import '../modules/login/view/login_screen.dart';
import '../modules/main/binding/main_binding.dart';
import '../modules/main/view/main_screen.dart';
import '../modules/splash/binding/splash_binding.dart';
import '../modules/splash/view/splash_screen.dart';
import '../modules/verifyOTP/binding/verify_otp_binding.dart';
import '../modules/verifyOTP/view/verify_otp_screen.dart';

part 'app_routes.dart';

final routePages = [
  GetPage(
    name: Routes.SPLASH,
    page: () => SplashScreen(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: Routes.MAIN,
    page: () => MainScreen(),
    binding: MainBinding(),
  ),
  GetPage(
    name: Routes.HOME,
    page: () => HomeScreen(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: Routes.LOGIN,
    page: () => LoginScreen(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: Routes.REGISTER,
    page: () => RegisterScreen(),
    binding: RegisterBinding(),
  ),
  GetPage(
    name: Routes.VERIFYOTP,
    page: () => VerifyOTPScreen(),
    binding: VerifyOTPBinding(),
  ),
  GetPage(
    name: Routes.ACCOUNT,
    page: () => AccountScreen(),
    binding: AccountBinding(),
  ),
  GetPage(
    name: Routes.LISTCHAT,
    page: () => ListChatScreen(),
    binding: ListChatBinding(),
  ),
  GetPage(
    name: Routes.CHANGEPASSWORD,
    page: () => ChangePasswordScreen(),
    binding: ChangePasswordBinding(),
  ),
];
