import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:yaldi/core/util/secure_storage.dart';
import 'package:yaldi/src/login/view/login_screen.dart';

import '../../../core/base/dependency_injection.dart';
import '../../../core/common/app_colors/app_colors.dart';
import '../../../core/common/app_component_style/component_style.dart';
import '../../../core/common/app_font_style/app_font_style_global.dart';
import '../../../core/common/assets.dart';
import '../../../core/notifier/generic_notifier.dart';
import '../../../core/shared_components/app_button/app_button.dart';
import '../../../core/shared_components/app_button/models/app_button_model.dart';
import '../../../core/shared_components/app_snack_bar/app_snack_bar.dart';
import '../../../core/shared_components/app_text/app_text.dart';
import '../../../core/shared_components/app_text/models/app_text_model.dart';
import '../data/models/user_info_model.dart';
import 'user_info_view_model.dart';

part 'widgets/profile_row.dart';
part 'widgets/profile_section.dart';

class WellcomPage extends StatefulWidget {
  const WellcomPage({super.key});
  static const String routeName = 'Wellcom Screen';

  @override
  State<WellcomPage> createState() => _WellcomPageState();
}

class _WellcomPageState extends State<WellcomPage> {
  final viewModel = sl<UserInfoViewModel>()..getUserInfo();
  DateTime? lastPressedTime;
  final Duration exitThreshold = const Duration(seconds: 2);
  @override
  Widget build(BuildContext context) {
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
          centerTitle: true,
          title: Image.asset(Assets.yaldi, height: 30.h, width: 100.w),
        ),
        body: ChangeNotifierProvider(
          create: (_) => viewModel.userInfoRes,
          child: Consumer<GenericNotifier<UserInfoModel>>(
            builder: (context, userNotifier, child) {
              final user = userNotifier.state.data;
              final isLoading =
                  userNotifier
                      is GenericLoadingState; // check if data still not loaded

              return Skeletonizer(
                enabled: isLoading,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Image + Name
                        Center(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(user.image ?? ""),
                              ),
                              const SizedBox(height: 10),
                              AppText(
                                text: "${user.firstName} ${user.lastName}",
                                model: AppTextModel(
                                  style: AppFontStyleGlobal(Locale("en")).label
                                      .copyWith(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              AppText(
                                text: user.email ?? "",
                                model: AppTextModel(
                                  style: AppFontStyleGlobal(Locale("en"))
                                      .bodyMedium1
                                      .copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Example usage with new widgets
                        ProfileSection(
                          title: "Basic Info",
                          children: [
                            ProfileRow(
                              title: "Username",
                              value: user.username ?? "",
                            ),
                            ProfileRow(
                              title: "Gender",
                              value: user.gender ?? "",
                            ),
                            ProfileRow(
                              title: "Age",
                              value: user.age.toString(),
                            ),
                            ProfileRow(
                              title: "Birth Date",
                              value: user.birthDate ?? "",
                            ),
                            ProfileRow(
                              title: "Blood Group",
                              value: user.bloodGroup ?? "",
                            ),
                            ProfileRow(
                              title: "Height",
                              value: "${user.height} cm",
                            ),
                            ProfileRow(
                              title: "Weight",
                              value: "${user.weight} kg",
                            ),
                            ProfileRow(
                              title: "Eye Color",
                              value: user.eyeColor ?? "",
                            ),
                          ],
                        ),

                        // Contact Info
                        ProfileSection(
                          title: "Contact Info",
                          children: [
                            ProfileRow(title: "Phone", value: user.phone ?? ""),
                            ProfileRow(title: "IP", value: user.ip ?? ""),
                            ProfileRow(
                              title: "Address",
                              value: user.address?.address ?? "",
                            ),
                            ProfileRow(
                              title: "City",
                              value: user.address?.city ?? "",
                            ),
                            ProfileRow(
                              title: "State",
                              value:
                                  "${user.address?.state ?? ""} (${user.address?.stateCode ?? ""})",
                            ),
                            ProfileRow(
                              title: "Postal Code",
                              value: user.address?.postalCode ?? "",
                            ),
                            ProfileRow(
                              title: "Country",
                              value: user.address?.country ?? "",
                            ),
                          ],
                        ),

                        // Hair Info
                        ProfileSection(
                          title: "Hair Info",
                          children: [
                            ProfileRow(
                              title: "Color",
                              value: user.hair?.color ?? "",
                            ),
                            ProfileRow(
                              title: "Type",
                              value: user.hair?.type ?? "",
                            ),
                          ],
                        ),

                        // Bank Info
                        ProfileSection(
                          title: "Bank Info",
                          children: [
                            ProfileRow(
                              title: "Card Number",
                              value: user.bank?.cardNumber ?? "",
                            ),
                            ProfileRow(
                              title: "Card Type",
                              value: user.bank?.cardType ?? "",
                            ),
                            ProfileRow(
                              title: "Expire",
                              value: user.bank?.cardExpire ?? "",
                            ),
                            ProfileRow(
                              title: "Currency",
                              value: user.bank?.currency ?? "",
                            ),
                            ProfileRow(
                              title: "IBAN",
                              value: user.bank?.iban ?? "",
                            ),
                          ],
                        ),

                        // Company Info
                        ProfileSection(
                          title: "Company Info",
                          children: [
                            ProfileRow(
                              title: "Name",
                              value: user.company?.name ?? "",
                            ),
                            ProfileRow(
                              title: "Department",
                              value: user.company?.department ?? "",
                            ),
                            ProfileRow(
                              title: "Title",
                              value: user.company?.title ?? "",
                            ),
                            ProfileRow(
                              title: "Address",
                              value: user.company?.address.address ?? "",
                            ),
                            ProfileRow(
                              title: "City",
                              value: user.company?.address.city ?? "",
                            ),
                            ProfileRow(
                              title: "State",
                              value:
                                  "${user.company?.address.state ?? ""} (${user.company?.address.stateCode ?? ""})",
                            ),
                            ProfileRow(
                              title: "Postal Code",
                              value: user.company?.address.postalCode ?? "",
                            ),
                            ProfileRow(
                              title: "Country",
                              value: user.company?.address.country ?? "",
                            ),
                          ],
                        ),

                        // Crypto Info
                        ProfileSection(
                          title: "Crypto Wallet",
                          children: [
                            ProfileRow(
                              title: "Coin",
                              value: user.crypto?.coin ?? "",
                            ),
                            ProfileRow(
                              title: "Wallet",
                              value: user.crypto?.wallet ?? "",
                            ),
                            ProfileRow(
                              title: "Network",
                              value: user.crypto?.network ?? "",
                            ),
                          ],
                        ),

                        // Other Info
                        ProfileSection(
                          title: "Other Info",
                          children: [
                            ProfileRow(
                              title: "University",
                              value: user.university ?? "",
                            ),
                            ProfileRow(title: "SSN", value: user.ssn ?? ""),
                            ProfileRow(title: "EIN", value: user.ein ?? ""),
                            ProfileRow(
                              title: "User Agent",
                              value: user.userAgent ?? "",
                            ),
                            ProfileRow(title: "Role", value: user.role ?? ""),
                            ProfileRow(
                              title: "MAC Address",
                              value: user.macAddress ?? "",
                            ),
                          ],
                        ),

                        20.h.verticalSpace,
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            bottom: 14,
                            start: 16.w,
                            end: 16.w,
                          ),
                          child: AppButton(
                            model: AppButtonModel(
                              child: AppText(
                                text: 'Logout',
                                model: AppTextModel(
                                  style: AppFontStyleGlobal(Locale("en")).label
                                      .copyWith(
                                        color: AppColors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              decoration: ComponentStyle.getButtonDecoration(
                                color: AppColors.red,
                              ),
                              buttonStyle: ComponentStyle.buttonStyle,
                            ),
                            onPressed: () async {
                              await SecureStorageHelper.instance.logout();
                              if (context.mounted) {
                                Navigator.pushNamed(
                                  context,
                                  LoginScreen.routeName,
                                ).then((_) {
                                  setState(() {});
                                });
                              }
                            },
                          ),
                        ),

                        10.h.verticalSpace,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
