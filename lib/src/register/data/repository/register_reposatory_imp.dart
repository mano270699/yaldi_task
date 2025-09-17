import 'package:dartz/dartz.dart';

import '../../domain/repository/register_reposatory.dart';
import '../datasources/register_remote_data_source.dart';
import '../models/register_model.dart';

class RegisterRepositoryImp implements RegisterRepository {
  final RegisterRemoteDataSource dataSource;

  RegisterRepositoryImp({required this.dataSource});

  @override
  Future<Either<String, UserModel>> registerUserData({
    required String fname,
    required String lname,
    required String email,
    required String userName,
    required String password,
  }) async {
    return await dataSource.registerUserData(
      email: email,
      fname: fname,
      lname: lname,
      password: password,
      userName: userName,
    );
  }
}
