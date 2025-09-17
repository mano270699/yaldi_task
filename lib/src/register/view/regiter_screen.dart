import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
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
import '../../login/view/login_screen.dart';
import '../data/models/register_model.dart';
import '../register_view_model.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  static const String routeName = 'Register Screen';
  final viewModel = sl<RegisterViewModel>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel.registerRes,
      child: Consumer<GenericNotifier<UserModel>>(
        builder: (context, registerNotifier, child) {
          final state = registerNotifier.state;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state is GenericLoadingState<UserModel>) {
              LoadingScreen.show(context);
            } else if (state is GenericErrorState<UserModel>) {
              Navigator.pop(context);
              showAppSnackBar(
                context: context,
                message: state.responseError?.errorMessage ?? "Error",
                color: AppColors.error,
              );
            } else if (state is GenericUpdatedState<UserModel>) {
              Navigator.pop(context);
              showAppSnackBar(
                context: context,
                message: "User Register Sucessfully",
              );

              if (context.mounted) {
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              }
            }
          });

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              surfaceTintColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  70.h.verticalSpace,
                  Center(
                    child: AppText(
                      text: 'Register',
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
                      text: "Please create your account",
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

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: ChangeNotifierProvider(
                            create: (_) => viewModel.firstNameValidation,
                            child: Consumer<GenericNotifier<String>>(
                              builder: (context, fullNameNotifier, _) {
                                final validation = fullNameNotifier.state;
                                return AppTextField(
                                  model: AppTextFieldModel(
                                    controller: viewModel.firstName,
                                    isRtl: false,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    borderRadius: BorderRadius.circular(10.r),
                                    decoration:
                                        ComponentStyle.inputDecoration(
                                          Locale("en"),
                                        ).copyWith(
                                          filled: true,
                                          fillColor: AppColors.txtGreyColor,
                                          hintText: "First Name",
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
                        5.w.horizontalSpace,
                        Expanded(
                          child: ChangeNotifierProvider(
                            create: (_) => viewModel.lastNameValidation,
                            child: Consumer<GenericNotifier<String>>(
                              builder: (context, fullNameNotifier, _) {
                                final validation = fullNameNotifier.state;
                                return AppTextField(
                                  model: AppTextFieldModel(
                                    controller: viewModel.lastName,
                                    isRtl: false,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    borderRadius: BorderRadius.circular(10.r),
                                    decoration:
                                        ComponentStyle.inputDecoration(
                                          Locale("en"),
                                        ).copyWith(
                                          filled: true,
                                          fillColor: AppColors.txtGreyColor,
                                          hintText: 'Last Name',
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
                      ],
                    ),
                  ),
                  15.h.verticalSpace,

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: ChangeNotifierProvider(
                      create: (_) => viewModel.emailValidation,
                      child: Consumer<GenericNotifier<String>>(
                        builder: (context, emailNotifier, _) {
                          final validation = emailNotifier.state;
                          return AppTextField(
                            model: AppTextFieldModel(
                              controller: viewModel.email,
                              isRtl: false,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              borderRadius: BorderRadius.circular(10.r),
                              decoration:
                                  ComponentStyle.inputDecoration(
                                    Locale("en"),
                                  ).copyWith(
                                    filled: true,
                                    fillColor: AppColors.txtGreyColor,
                                    hintText: 'Email',
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

                  15.h.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: ChangeNotifierProvider(
                      create: (_) => viewModel.userNameValidation,
                      child: Consumer<GenericNotifier<String>>(
                        builder: (context, emailNotifier, _) {
                          final validation = emailNotifier.state;
                          return AppTextField(
                            model: AppTextFieldModel(
                              controller: viewModel.userName,
                              isRtl: false,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              borderRadius: BorderRadius.circular(10.r),
                              decoration:
                                  ComponentStyle.inputDecoration(
                                    Locale("en"),
                                  ).copyWith(
                                    filled: true,
                                    fillColor: AppColors.txtGreyColor,
                                    hintText: 'User Name',
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

                  15.h.verticalSpace,

                  ChangeNotifierProvider(
                    create: (_) => viewModel.passwordValidation,
                    child: Consumer<GenericNotifier<String>>(
                      builder: (context, passwordNotifier, _) {
                        final validation = passwordNotifier.state;
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: ChangeNotifierProvider(
                            create: (_) => viewModel.showPassWordText,
                            child: Consumer<GenericNotifier<bool>>(
                              builder: (context, showPasswordNotifier, _) {
                                final state = showPasswordNotifier.state;
                                return AppTextField(
                                  model: AppTextFieldModel(
                                    obscureInputText: state.data,
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
                                                state.data
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
                                          hintText: 'password',
                                          errorText: validation.data.isNotEmpty
                                              ? validation.data
                                              : null,
                                        ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  15.h.verticalSpace,
                  ChangeNotifierProvider(
                    create: (_) => viewModel.confirmPasswordValidation,
                    child: Consumer<GenericNotifier<String>>(
                      builder: (context, passwordNotifier, _) {
                        final validation = passwordNotifier.state;
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: ChangeNotifierProvider(
                            create: (_) => viewModel.showConfirmPassWordText,
                            child: Consumer<GenericNotifier<bool>>(
                              builder: (context, showPasswordNotifier, _) {
                                final state = showPasswordNotifier.state;
                                return AppTextField(
                                  model: AppTextFieldModel(
                                    obscureInputText: state.data,
                                    maxLines: 1,
                                    controller: viewModel.confirmPassword,
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
                                                    .changeConfirmPasswordVisibility();
                                              },
                                              child: Icon(
                                                state.data
                                                    ? Icons.remove_red_eye
                                                    : Icons.remove_red_eye,
                                              ),
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: AppColors.txtGreyColor,
                                          hintText: 'confirm password',
                                          errorText: validation.data.isNotEmpty
                                              ? validation.data
                                              : null,
                                        ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
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
                          text: 'Create Account',
                          model: AppTextModel(
                            style: AppFontStyleGlobal(Locale("en")).label
                                .copyWith(
                                  color: AppColors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        decoration: ComponentStyle.getButtonDecoration(),
                        buttonStyle: ComponentStyle.buttonStyle,
                      ),
                      onPressed: () {
                        viewModel.registerUserData(context: context);
                      },
                    ),
                  ),

                  10.h.verticalSpace,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        text: "Already have an account?",
                        model: AppTextModel(
                          textDirection:
                              Localizations.localeOf(context).languageCode ==
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
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        child: AppText(
                          text: ' Login',
                          model: AppTextModel(
                            style: AppFontStyleGlobal(Locale("en")).button
                                .copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primaryColor,
                                  color: AppColors.primaryColor,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
