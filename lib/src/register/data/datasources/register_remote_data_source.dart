import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/util/api_routes.dart';
import '../../../../core/util/network_service.dart';
import '../models/register_model.dart';

abstract class RegisterRemoteDataSource {
  Future<Either<String, UserModel>> registerUserData({
    required String fname,
    required String lname,
    required String email,
    required String userName,
    required String password,
  });
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final NetworkService networkService;

  RegisterRemoteDataSourceImpl(this.networkService);
  @override
  Future<Either<String, UserModel>> registerUserData({
    required String fname,
    required String lname,
    required String email,
    required String userName,
    required String password,
  }) async {
    try {
      Map<String, dynamic> data = {
        "firstName": fname,
        "lastName": lname,
        "email": email,
        "username": userName,
        "password": password,
      };

      final response = await networkService.post(ApiRoutes.register, data);

      UserModel user = UserModel.fromJson(response.data);
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
