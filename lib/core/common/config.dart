import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../util/environment/environment.dart';

class Config {
  static String baseUrl = baseUrlSetter(Environment.mode);
  static final headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };
}

String baseUrlSetter(String mode) {
  switch (mode) {
    case "DEV":
      return dotenv.env['API_BASE_URL'] ?? "";
    case "SIT":
      return dotenv.env['API_BASE_URL'] ?? "";
    case "PREPRD":
      return dotenv.env['API_BASE_URL'] ?? "";
    default:
      return dotenv.env['API_BASE_URL'] ?? "";
  }
}
