import 'package:flutter/material.dart';
import 'package:yaldi/core/util/enum_initialization.dart';
import 'package:yaldi/core/util/secure_storage.dart';
import 'package:yaldi/src/login/view/login_screen.dart';
import 'package:yaldi/src/wellcome_page/view/wellcom_page.dart';

class SplashScreenViewModel {
  Future<void> init(BuildContext context) async {
    final token = await SecureStorageHelper.instance.read(
      key: CachingKey.token,
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        if (token != null) {
          Navigator.pushReplacementNamed(context, WellcomPage.routeName);
        } else {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }
      }
    });
  }
}
