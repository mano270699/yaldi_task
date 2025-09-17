import 'package:dartz/dartz.dart';
import 'package:yaldi/src/wellcome_page/domain/repository/user_info_repository.dart';
import '../../data/models/user_info_model.dart';

class UserInfoUseCase {
  final UserInfoRepository _userInfoRepository;

  UserInfoUseCase(this._userInfoRepository);

  Future<Either<String, UserInfoModel>> call() async {
    return await _userInfoRepository.getUserInfo();
  }
}
