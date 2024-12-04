import 'package:flutter/material.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/domain/enum/e_role.dart';
import 'package:openqrx/feature/editor/home/home_editor_page.dart';
import 'package:openqrx/feature/owner/farm/farm_page.dart';
import 'package:openqrx/feature/owner/farm/farm_qr_code_page.dart';
import 'package:openqrx/feature/owner/home/home_owner_page.dart';
import 'package:openqrx/feature/shared/error/home_no_farm_page.dart';
import 'package:openqrx/feature/shared/error/home_none_page.dart';
import 'package:openqrx/feature/shared/error/not_found_page.dart';
import 'package:openqrx/feature/shared/login/login_page.dart';
import 'package:openqrx/feature/shared/login/phone_pin_page.dart';
import 'package:openqrx/feature/shared/menu/menu_page.dart';
import 'package:openqrx/feature/shared/product/product_page.dart';
import 'package:openqrx/feature/shared/profile/profile_setup_form.dart';
import 'package:openqrx/feature/shared/report/report_page.dart';
import 'package:openqrx/feature/shared/shop/shop_page.dart';
import 'package:openqrx/feature/shared/splash/splash_page.dart';
import 'package:openqrx/feature/shared/test/test_page.dart';

class AppRoutes {
  static const String splash = "/";
  static const String shop = "/shop";
  static const String menu = "/menu";
  static const String order = "/order";
  static const String login = "/login";
  static const String home = "/home";
  static const String test = "/test";
  static const String farm = "/farm";
  static const String farmQr = "/farm-qr";
  static const String expense = "/expense";
  static const String buy = "/buy";
  static const String report = "/report";
  static const String product = "/product";
  static const String profileSetup = "/profile-setup";
  static const String supply = "/supply";
  static const String verifyCode = "/verify-code";
}

class RouteGenerator {
  static Widget _getPage(String? route, String id, dynamic arguments) {
    if (AppRoutes.splash == route) {
      return const SplashPage();
    }
    final user = UserProvider.instance;
    switch (route) {
      case AppRoutes.login:
        return const LoginPage();
      case AppRoutes.verifyCode:
        return const PhonePinPage();
      case AppRoutes.menu:
        return const MenuPage();
      case AppRoutes.test:
        return const WidgetToImageConverter();
      case AppRoutes.profileSetup:
        return const ProfileSetupForm();
      case AppRoutes.farm:
        return const FarmPage();
      case AppRoutes.product:
        return const ProductPage();
      case AppRoutes.shop:
        return const ShopPage();
      case AppRoutes.report:
        return const ReportPage();
      case AppRoutes.farmQr:
        return FarmQrCodePage(farm: arguments);
      // case AppRoutes.buy:
      //   return const BuyPage();
      // case AppRoutes.lend:
      //   return const LendPage();
      // case AppRoutes.feed:
      //   return const FeedPage();
      // return VerifyCodePage(phone: arguments);
      case AppRoutes.home:
        if (user.defaultFarm == null) {
          return user.role == ERole.admin || user.role == ERole.owner
              ? const HomeNoFarmPage()
              : const HomeNonePage(isFarm: true);
        }
        switch (user.role) {
          case ERole.owner || ERole.admin:
            return const HomeOwnerPage();
          case ERole.editor || ERole.creator || ERole.viewer:
            return const HomeEditorPage();
          default:
            return const HomeNonePage();
        }
      // case Routes.home:
      default:
        return const NotFoundPage();
    }
  }

  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments as dynamic;
    final routes = routeSettings.name?.split('/');
    final routeName =
        routes?.length == 2 ? routeSettings.name : '/${routes?[1]}';
    final id = routes?.last ?? '';
    xPrint('Route Generator $routeName');
    return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => _getPage(routeName, id, arguments));
  }
}
