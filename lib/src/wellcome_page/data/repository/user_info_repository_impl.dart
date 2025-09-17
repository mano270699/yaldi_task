import 'package:dartz/dartz.dart';

import '../../domain/repository/user_info_repository.dart';
import '../datasources/user_info_data_sources.dart';
import '../models/user_info_model.dart';

class UserInfoRepositoryImp implements UserInfoRepository {
  final UserInfoRemoteDataSource dataSource;

  UserInfoRepositoryImp({required this.dataSource});

  @override
  Future<Either<String, UserInfoModel>> getUserInfo() async {
    return await dataSource.getUserInfo();
  }
}
