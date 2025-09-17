import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/util/api_routes.dart';
import '../../../../core/util/network_service.dart';
import '../models/user_login.dart';

abstract class LoginRemoteDataSource {
  Future<Either<String, LoginModel>> login({
    required String userName,
    required String password,
  });
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final NetworkService networkService;

  LoginRemoteDataSourceImpl(this.networkService);
  @override
  Future<Either<String, LoginModel>> login({
    required String userName,
    required String password,
  }) async {
    try {
      Map<String, dynamic> data = {"username": userName, "password": password};
      final response = await networkService.post(ApiRoutes.login, data);

      // Parse the login response
      LoginModel login = LoginModel.fromJson(response.data);
      return Right(login);
    } on DioException catch (e) {
      // Extract the error message from server
      String errorMessage = "Unknown error";
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
        print("Login Error: $errorMessage");
      }

      return Left(errorMessage);
    } catch (e, t) {
      if (kDebugMode) {
        print("Unexpected Login Error: $e, trace: $t");
      }
      return Left("Unexpected error occurred");
    }
  }
}
