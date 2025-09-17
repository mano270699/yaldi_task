import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/common/models/failure.dart';

import '../../core/notifier/generic_notifier.dart';
import '../../core/util/enum_initialization.dart';
import '../../core/util/secure_storage.dart';
import '../../core/util/validation.dart';

import 'data/models/user_login.dart';
import 'domain/usecases/login_usecase.dart';

class LoginViewModel {
  final LoginUseCase loginUseCase;
  GenericNotifier<bool> showPassWordText = GenericNotifier(true);
  TextEditingController password = TextEditingController();
  TextEditingController userName = TextEditingController();

  GenericNotifier<String> userNameValidation = GenericNotifier('');
  GenericNotifier<LoginModel> loginResponse = GenericNotifier(LoginModel());
  GenericNotifier<String> passwordValidation = GenericNotifier("");

  LoginViewModel({required this.loginUseCase});
  changePasswordVisibility() {
    showPassWordText.onUpdateData(!showPassWordText.state.data);
  }

  TextEditingController phoneNumber = TextEditingController();

  GenericNotifier<String> phoneValidation = GenericNotifier('');
  Future<void> login({required BuildContext context}) async {
    // --- Validate input fields ---
    final userNameError = Validation.usernameValidation(userName.text);
    final passwordError = Validation.passwordValidation(password.text);

    userNameValidation.onUpdateData(userNameError);
    passwordValidation.onUpdateData(passwordError);

    // Stop if any validation fails
    if (userNameError.isNotEmpty || passwordError.isNotEmpty) return;

    try {
      loginResponse.onLoadingState();

      // Call login use case
      Either<String, LoginModel> response = await loginUseCase.call(
        userName: userName.text,
        password: password.text,
      );

      // Handle response
      response.fold(
        (failureMessage) {
          debugPrint("Login Error: $failureMessage");
          loginResponse.onErrorState(Failure(failureMessage));
        },
        (user) async {
          await SecureStorageHelper.instance.writeData(
            key: CachingKey.token,
            value: user.accessToken,
          );
          await SecureStorageHelper.instance.writeData(
            key: CachingKey.refreshToken,
            value: user.refreshToken,
          );
          loginResponse.onUpdateData(user);
        },
      );
    } on DioException catch (e, s) {
      debugPrint("Login Failure (from Interceptor): ${e.message}");

      Failure failure;
      if (e.error is Failure) {
        failure = e.error as Failure;

        debugPrint("Login Failure (from Interceptor): ${failure.message}");
      } else {
        failure = Failure(
          e.message ?? "Unknown Dio error",
          code: e.response?.statusCode ?? 0,
        );
        debugPrint(
          "Login DioException (no embedded Failure): ${failure.message}----$s",
        );
      }

      if (context.mounted) loginResponse.onErrorState(failure);
    } catch (e, s) {
      // Any unexpected error
      debugPrint("Login Unexpected Error: $e,,, $s");
      if (context.mounted) {
        loginResponse.onErrorState(
          Failure("Unexpected error occurred", code: 0),
        );
      }
    }
  }
}
