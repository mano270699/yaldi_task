import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:yaldi/core/common/assets.dart';
import '../../../core/base/dependency_injection.dart';
import '../../../core/common/app_colors/app_colors.dart';
import 'splash_screen_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = 'Splash Screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final viewModel = sl<SplashScreenViewModel>();

  @override
  void initState() {
    viewModel.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Image.asset(Assets.yaldi, height: 120.h, width: 300.w),
      ),
    );
  }
}
