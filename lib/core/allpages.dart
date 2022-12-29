import 'package:chatapp/core/routes.dart';
import 'package:chatapp/features/home/home_bind.dart';
import 'package:chatapp/features/home/home_view.dart';
import 'package:chatapp/features/login/login_bind.dart';
import 'package:chatapp/features/login/login_view.dart';
import 'package:chatapp/features/splash/splash_bind.dart';
import 'package:chatapp/features/splash/splash_view.dart';
import 'package:get/get.dart';

import '../features/profile/profile_bind.dart';
import '../features/profile/profile_view.dart';

List<GetPage> allpage=[
  GetPage(
    name: Routes.home,
    page: () => HomePage(),
    binding: HomeBinding()
  ),
  GetPage(
    name: Routes.splash,
    page: () => SplashPage(),
    binding: SplashBinding()
  ),
  GetPage(
    name: Routes.login,
    page:() => LoginPage(),
    binding: LoginBinding()
  ),
  GetPage(
    name: Routes.profile,
    page:() => ProfilePage(),
    binding: ProfileBinding()
  ),
];