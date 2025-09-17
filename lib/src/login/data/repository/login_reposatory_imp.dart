import 'package:dartz/dartz.dart';

import '../../domain/repository/login_reposatory.dart';
import '../datasources/login_remote_data_source.dart';
import '../models/user_login.dart';

class LoginRepositoryImp implements LoginRepository {
  final LoginRemoteDataSource dataSource;

  LoginRepositoryImp({required this.dataSource});

  @override
  Future<Either<String, LoginModel>> login({
    required String userName,
    required String password,
  }) async {
    return await dataSource.login(userName: userName, password: password);
  }
}
