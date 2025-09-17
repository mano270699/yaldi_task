import 'package:dartz/dartz.dart';

import '../../data/models/register_model.dart';

abstract class RegisterRepository {
  Future<Either<String, UserModel>> registerUserData({
    required String fname,
    required String lname,
    required String email,
    required String userName,
    required String password,
  });
}
