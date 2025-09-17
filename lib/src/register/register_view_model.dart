import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../../core/common/models/failure.dart';
import '../../core/notifier/generic_notifier.dart';
import '../../core/util/validation.dart';
import 'data/models/register_model.dart';
import 'domain/usecases/register_usecase.dart';

class RegisterViewModel {
  final RegisterUseCase registerUseCase;

  GenericNotifier<bool> showPassWordText = GenericNotifier(true);
  GenericNotifier<bool> showConfirmPassWordText = GenericNotifier(true);
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  GenericNotifier<String> firstNameValidation = GenericNotifier('');
  GenericNotifier<String> lastNameValidation = GenericNotifier('');
  GenericNotifier<String> emailValidation = GenericNotifier('');
  GenericNotifier<String> userNameValidation = GenericNotifier('');
  GenericNotifier<String> phoneValidation = GenericNotifier('');
  GenericNotifier<String> passwordValidation = GenericNotifier('');
  GenericNotifier<String> confirmPasswordValidation = GenericNotifier('');

  RegisterViewModel({required this.registerUseCase});
  GenericNotifier<UserModel> registerRes = GenericNotifier(UserModel());

  changePasswordVisibility() {
    showPassWordText.onUpdateData(!showPassWordText.state.data);
  }

  changeConfirmPasswordVisibility() {
    showConfirmPassWordText.onUpdateData(!showConfirmPassWordText.state.data);
  }

  Future<void> registerUserData({
    required BuildContext context,
    bool isFromOrder = false,
  }) async {
    emailValidation.onUpdateData(Validation.userEmailValidation(email.text));
    firstNameValidation.onUpdateData(
      Validation.firstNameValidation(firstName.text),
    );
    lastNameValidation.onUpdateData(
      Validation.lastNameValidation(lastName.text),
    );

    passwordValidation.onUpdateData(
      Validation.passwordValidation(password.text),
    );
    confirmPasswordValidation.onUpdateData(
      Validation.passwordValidation(confirmPassword.text),
    );
    userNameValidation.onUpdateData(
      Validation.fieldRequiredValidation(userName.text),
    );

    if ((phoneValidation.state.data.isEmpty) &&
        (emailValidation.state.data.isEmpty) &&
        (firstNameValidation.state.data.isEmpty) &&
        (lastNameValidation.state.data.isEmpty) &&
        (confirmPasswordValidation.state.data.isEmpty) &&
        (userNameValidation.state.data.isEmpty) &&
        passwordValidation.state.data.isEmpty) {
      try {
        registerRes.onLoadingState();

        Either<String, UserModel> response = await registerUseCase.call(
          email: email.text,
          fname: firstName.text,
          lname: lastName.text,
          userName: userName.text,
          password: password.text,
        );

        response.fold(
          (failure) {
            debugPrint("error:$failure");
            registerRes.onErrorState(Failure(failure));
          },
          (user) async {
            registerRes.onUpdateData(user);
          },
        );
      } on Failure catch (e, s) {
        phoneNumber.clear();
        debugPrint("lllllllllllll: $e ---- $s");
        registerRes.onErrorState(Failure('$e'));
      } on DioException catch (e, s) {
        Failure failure;
        if (context.mounted) {
          if (e.error is Failure) {
            failure = e.error as Failure;
            debugPrint(
              "Register Failure (from Interceptor): ${failure.message} ---- StackTrace: $s",
            );
          } else {
            debugPrint(
              "Register DioException (no embedded Failure or other type): ${e.message} ---- StackTrace: $s",
            );
            failure = Failure(
              "unknown_network_error_occurred", // Use Dio's message
              code: e.response?.statusCode ?? 0,
            );
          }
          registerRes.onErrorState(
            failure,
          ); // Update state with the correct Failure
        }
      } catch (e, s) {
        debugPrint("Register Unexpected Error: $e ---- StackTrace: $s");
        if (context.mounted) {
          registerRes.onErrorState(Failure("unexpected_error", code: 0));
        }
      }
    } else {
      debugPrint("in has Validation");
      return;
    }
  }
}
