import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../common/models/error_model.dart';
import '../../common/models/failure.dart';

class ApiInterceptor extends Interceptor {
  // --- onRequest ---
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint(
      "┌----- Request -----------------------------------------------------------------",
    );
    debugPrint("| Method: ${options.method}");
    debugPrint("| URL: ${options.uri}");

    // Mask Authorization header
    options.headers.forEach((key, value) {
      final displayValue = (key.toLowerCase() == 'authorization')
          ? '*****'
          : value;
      debugPrint("| Header: $key: $displayValue");
    });

    // Request body
    String bodyDebug = "(No Request Body)";
    if (options.data != null) {
      if (options.data is Map || options.data is List) {
        try {
          bodyDebug = const JsonEncoder.withIndent('  ').convert(options.data);
        } catch (_) {
          bodyDebug = options.data.toString();
        }
      } else {
        bodyDebug = options.data.toString();
      }
    }
    debugPrint("| Body: $bodyDebug");
    debugPrint(
      "└------------------------------------------------------------------------------",
    );
    super.onRequest(options, handler);
  }

  // --- onResponse ---
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      "┌----- Response ----------------------------------------------------------------",
    );
    debugPrint("| Status code: ${response.statusCode}");
    debugPrint(
      "| Response: ${const JsonEncoder.withIndent('  ').convert(response.data)}",
    );
    debugPrint(
      "└------------------------------------------------------------------------------",
    );
    handler.next(response);
  }

  // --- onError ---
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = "An unknown error occurred. Please try again.";

    if (err.response != null && err.response?.data != null) {
      final data = err.response!.data;

      if (data is Map<String, dynamic>) {
        if (data['message'] is String) {
          errorMessage = data['message'];
        } else if (data['message'] is Map) {
          try {
            final parsed = ErrorModel.fromJson(data);
            errorMessage = parsed.toString(); // Join all messages
          } catch (_) {
            errorMessage = "Failed to parse server error.";
          }
        } else if (data['error'] is String) {
          errorMessage = data['error'];
        }
      } else if (data is String) {
        errorMessage = data;
      }
    } else {
      // Handle network errors
      if (err.type == DioExceptionType.connectionTimeout ||
          err.type == DioExceptionType.sendTimeout ||
          err.type == DioExceptionType.receiveTimeout) {
        errorMessage = "Connection timed out. Check your internet.";
      } else if (err.type == DioExceptionType.cancel) {
        errorMessage = "Request cancelled.";
      } else if (err.type == DioExceptionType.connectionError ||
          err.type == DioExceptionType.unknown) {
        errorMessage = "Network connection error.";
      } else {
        errorMessage = err.message ?? errorMessage;
      }
    }

    debugPrint("┌!!!!!!!!!!!!!!!! ERROR !!!!!!!!!!!!!!!!!");
    debugPrint("| $errorMessage");
    debugPrint("└!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

    final failure = Failure(errorMessage, code: err.response?.statusCode ?? 0);

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: failure,
      ),
    );
  }
}
