import 'package:dartz/dartz.dart';

import '../../data/models/user_login.dart';

abstract class LoginRepository {
  Future<Either<String, LoginModel>> login({
    required String userName,
    required String password,
  });
}
