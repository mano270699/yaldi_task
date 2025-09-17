import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/common/models/failure.dart';
import '../../../core/notifier/generic_notifier.dart';
import '../data/models/user_info_model.dart';
import '../domain/usecases/user_info_usecase.dart';

class UserInfoViewModel {
  final UserInfoUseCase infoUseCase;

  GenericNotifier<UserInfoModel> userInfoRes = GenericNotifier(UserInfoModel());

  UserInfoViewModel({required this.infoUseCase});

  Future<void> getUserInfo() async {
    try {
      userInfoRes.onLoadingState();
      Either<String, UserInfoModel> response = await infoUseCase.call();

      response.fold(
        (failure) {
          userInfoRes.onErrorState(Failure(failure));
        },
        (res) async {
          userInfoRes.onUpdateData(res);
        },
      );
    } on Failure catch (e, s) {
      debugPrint("lllllllllllll:$s");
      userInfoRes.onErrorState(Failure('$e'));
    }
  }
}
