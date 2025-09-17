import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/util/api_routes.dart';
import '../../../../core/util/enum_initialization.dart';
import '../../../../core/util/network_service.dart';
import '../../../../core/util/secure_storage.dart';
import '../models/user_info_model.dart';

abstract class UserInfoRemoteDataSource {
  Future<Either<String, UserInfoModel>> getUserInfo();
}

class UserInfoRemoteDataSourceImpl implements UserInfoRemoteDataSource {
  final NetworkService networkService;

  UserInfoRemoteDataSourceImpl(this.networkService);
  @override
  Future<Either<String, UserInfoModel>> getUserInfo() async {
    try {
      final response = await networkService.get(
        ApiRoutes.me,
        headers: {
          "Authorization":
              "Bearer ${await SecureStorageHelper.instance.read(key: CachingKey.token)}",
        },
      );

      UserInfoModel user = UserInfoModel.fromJson(response.data);
      return Right(user);
    } on DioException catch (e) {
      String errorMessage = "Unknown error occurred";
      if (e.response != null && e.response?.data != null) {
        final responseData = e.response!.data;
        if (responseData is Map<String, dynamic>) {
          errorMessage = responseData['message']?.toString() ?? errorMessage;
        } else if (responseData is String) {
          errorMessage = responseData;
        }
      } else {
        errorMessage = e.message ?? errorMessage;
      }

      if (kDebugMode) {
        print("Register Error: $errorMessage");
      }

      return Left(errorMessage);
    } catch (e, t) {
      if (kDebugMode) {
        print("Unexpected Register Error: $e, trace: $t");
      }
      return Left("Unexpected error occurred");
    }
  }
}
