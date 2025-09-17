import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_colors/app_colors.dart';
import '../app_font_style/app_font_style_global.dart';

class ComponentStyle {
  static InputDecoration inputDecoration(
    Locale locale, {
    BorderRadius? borderRadius,
  }) => InputDecoration(
    hintStyle: AppFontStyleGlobal(
      locale,
    ).bodyRegular1.copyWith(color: AppColors.secondLightGray, height: 0),
    filled: false,
    contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.r),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.r),
      borderSide: BorderSide(color: AppColors.primaryColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.r),
      borderSide: const BorderSide(color: AppColors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.red),
    ),
    errorStyle: AppFontStyleGlobal(
      locale,
    ).overLine.copyWith(color: AppColors.red),
  );
  static ButtonStyle get buttonStyle => ButtonStyle(
    fixedSize: WidgetStatePropertyAll(Size(358.w, 45.h)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        // side: const BorderSide(color: AppColors.outlinedBorder, width: 1),
        borderRadius: BorderRadius.circular(12.r),
      ),
    ),
  );
  static ButtonStyle get smallButtonStyle => ButtonStyle(
    fixedSize: WidgetStatePropertyAll(Size(78.w, 33.h)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        // side: const BorderSide(color: AppColors.outlinedBorder, width: 1),
        borderRadius: BorderRadius.circular(12.r),
      ),
    ),
  );
  static BoxDecoration getButtonDecoration({Color? color}) => BoxDecoration(
    color: color ?? AppColors.primaryColor,
    borderRadius: BorderRadius.circular(25.r),
  );
}
