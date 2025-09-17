import 'package:dartz/dartz.dart';

import '../../data/models/user_login.dart';
import '../repository/login_reposatory.dart';

class LoginUseCase {
  final LoginRepository _loginRepository;

  LoginUseCase(this._loginRepository);

  Future<Either<String, LoginModel>> call({
    required String userName,
    required String password,
  }) async {
    return await _loginRepository.login(userName: userName, password: password);
  }
}
