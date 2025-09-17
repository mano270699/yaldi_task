import 'package:dartz/dartz.dart';

import '../../data/models/user_info_model.dart';

abstract class UserInfoRepository {
  Future<Either<String, UserInfoModel>> getUserInfo();
}
