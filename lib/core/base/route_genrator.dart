import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../src/login/view/login_screen.dart';
import '../../src/register/view/regiter_screen.dart';

import '../../src/splash_screen/view/splash_screen.dart';

import '../../src/wellcome_page/view/wellcom_page.dart';
import '../common/app_colors/app_colors.dart';
import '../common/app_font_style/app_font_style_global.dart';
import '../shared_components/app_text/app_text.dart';
import '../shared_components/app_text/models/app_text_model.dart';

class RouteGenerator {
  Map<String, dynamic> routs;
  RouteGenerator({required this.routs});
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case RegisterScreen.routeName:
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case WellcomPage.routeName:
        return MaterialPageRoute(builder: (_) => WellcomPage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute({String? routeName}) {
    return MaterialPageRoute(
      builder: (context) {
        final String message =
            'No route defined for ${routeName ?? 'this screen'}';
        return Scaffold(
          body: Center(
            child: AppText(
              text: message,
              model: AppTextModel(
                style: AppFontStyleGlobal(Locale("en")).button.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
