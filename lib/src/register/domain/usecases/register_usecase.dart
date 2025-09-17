import 'package:dartz/dartz.dart';

import '../../data/models/register_model.dart';
import '../repository/register_reposatory.dart';

class RegisterUseCase {
  final RegisterRepository _registerRepository;

  RegisterUseCase(this._registerRepository);

  Future<Either<String, UserModel>> call({
    required String fname,
    required String lname,
    required String email,
    required String userName,
    required String password,
  }) async {
    return await _registerRepository.registerUserData(
      fname: fname,
      lname: lname,
      userName: userName,
      email: email,
      password: password,
    );
  }
}
