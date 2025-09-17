import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/base/dependency_injection.dart';
import '../../../core/common/app_colors/app_colors.dart';
import '../../../core/common/app_component_style/component_style.dart';
import '../../../core/common/app_font_style/app_font_style_global.dart';
import '../../../core/common/app_icon_svg.dart';
import '../../../core/notifier/generic_notifier.dart';
import '../../../core/shared_components/app_button/app_button.dart';
import '../../../core/shared_components/app_button/models/app_button_model.dart';
import '../../../core/shared_components/app_snack_bar/app_snack_bar.dart';
import '../../../core/shared_components/app_text/app_text.dart';
import '../../../core/shared_components/app_text/models/app_text_model.dart';
import '../../../core/shared_components/text_form_field/app_text_field.dart';
import '../../../core/shared_components/text_form_field/models/app_text_field_model.dart';
import '../../../core/util/loading.dart';
import 'package:provider/provider.dart';

import '../../register/view/regiter_screen.dart';
import '../../wellcome_page/view/wellcom_page.dart';
import '../data/models/user_login.dart';
import '../login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = 'Login Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final viewModel = sl<LoginViewModel>();
  DateTime? lastPressedTime;
  final Duration exitThreshold = const Duration(seconds: 2);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel.loginResponse,

      child: Consumer<GenericNotifier<LoginModel>>(
        builder: (context, notifier, child) {
          final state = notifier.state;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state is GenericLoadingState<LoginModel>) {
              LoadingScreen.show(context);
            } else if (state is GenericUpdatedState<LoginModel>) {
              showAppSnackBar(context: context, message: "Login Successfully");
              if (context.mounted) {
                Navigator.of(context).popAndPushNamed(WellcomPage.routeName);
              }
            } else if (state is GenericErrorState<LoginModel>) {
              Navigator.pop(context);
              showAppSnackBar(
                context: context,
                message: state.responseError?.errorMessage ?? '',
                color: AppColors.error,
              );
            }
          });

          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool didPop, _) {
              if (didPop) {
                return;
              }

              final now = DateTime.now();
              final isFirstPress =
                  lastPressedTime == null ||
                  now.difference(lastPressedTime!) > exitThreshold;

              if (isFirstPress) {
                lastPressedTime = now;

                showAppSnackBar(
                  context: context,
                  message: "Press back twice to exit",
                  color: AppColors.error,
                );
              } else {
                SystemNavigator.pop();
              }
            },
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                surfaceTintColor: Colors.white,
              ),
              body: child,
            ),
          );
        },
        child: Column(
          children: [
            70.h.verticalSpace,
            Center(
              child: AppText(
                text: 'Login',
                model: AppTextModel(
                  style: AppFontStyleGlobal(Locale("en")).button.copyWith(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
            24.h.verticalSpace,
            Center(
              child: AppText(
                text: "Please enter your email and password",
                model: AppTextModel(
                  style: AppFontStyleGlobal(Locale("en")).button.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondLightGray,
                  ),
                ),
              ),
            ),
            85.h.verticalSpace,
            ChangeNotifierProvider(
              create: (_) => viewModel.userNameValidation,
              child: Consumer<GenericNotifier<String>>(
                builder: (context, notifier, child) {
                  final validation = notifier.state;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: AppTextField(
                      model: AppTextFieldModel(
                        controller: viewModel.userName,
                        isRtl: false,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        borderRadius: BorderRadius.circular(10.r),
                        decoration: ComponentStyle.inputDecoration(Locale("en"))
                            .copyWith(
                              filled: true,
                              fillColor: AppColors.txtGreyColor,
                              hintText: 'User Name',
                            ),
                        errorText: validation.data.isNotEmpty
                            ? validation.data
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            15.h.verticalSpace,
            ChangeNotifierProvider(
              create: (_) => viewModel.passwordValidation,
              child: Consumer<GenericNotifier<String>>(
                builder: (context, validationNotifier, child) {
                  final validation = validationNotifier.state;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ChangeNotifierProvider(
                          create: (_) => viewModel.showPassWordText,
                          child: Consumer<GenericNotifier<bool>>(
                            builder: (context, showPasswordNotifier, _) {
                              final showPassword = showPasswordNotifier.state;

                              return AppTextField(
                                model: AppTextFieldModel(
                                  obscureInputText: showPassword.data,
                                  maxLines: 1,
                                  controller: viewModel.password,
                                  isRtl: false,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  borderRadius: BorderRadius.circular(10.r),
                                  decoration:
                                      ComponentStyle.inputDecoration(
                                        Locale("en"),
                                      ).copyWith(
                                        suffixIconConstraints:
                                            const BoxConstraints(
                                              minHeight: 20,
                                              minWidth: 20,
                                            ),
                                        suffixIcon: Padding(
                                          padding: EdgeInsetsDirectional.only(
                                            end: 8.w,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              viewModel
                                                  .changePasswordVisibility();
                                            },
                                            child: SvgPicture.asset(
                                              showPassword.data
                                                  ? AppIconSvg.passEyeIcon
                                                  : AppIconSvg.openEyeIcon,

                                              colorFilter: ColorFilter.mode(
                                                AppColors.secondLightGray,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: AppColors.txtGreyColor,
                                        hintText: 'Password',
                                      ),
                                  errorText: validation.data.isNotEmpty
                                      ? validation.data
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      50.h.verticalSpace,
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          bottom: 14,
                          start: 16.w,
                          end: 16.w,
                        ),
                        child: AppButton(
                          model: AppButtonModel(
                            child: AppText(
                              text: 'Login',
                              model: AppTextModel(
                                style: AppFontStyleGlobal(Locale("en")).label
                                    .copyWith(
                                      color: AppColors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                            decoration: ComponentStyle.getButtonDecoration(),
                            buttonStyle: ComponentStyle.buttonStyle,
                          ),
                          onPressed: () {
                            viewModel.login(context: context);
                          },
                          // : null,
                        ),
                      ),
                      10.h.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: "Don't have an account?",
                            model: AppTextModel(
                              textDirection:
                                  Localizations.localeOf(
                                        context,
                                      ).languageCode ==
                                      'ar'
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              style: AppFontStyleGlobal(Locale("en")).button
                                  .copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black,
                                  ),
                            ),
                          ),
                          3.w.horizontalSpace,
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RegisterScreen.routeName,
                              );
                            },
                            child: AppText(
                              text: 'register',
                              model: AppTextModel(
                                style: AppFontStyleGlobal(Locale("en")).button
                                    .copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.primaryColor,
                                      color: AppColors.primaryColor,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      20.h.verticalSpace,
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
