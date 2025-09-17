// class DefaultErrorModel {
//   final String message;
//   final bool status;

//   DefaultErrorModel({
//     required this.message,
//     required this.status,
//   });

//   factory DefaultErrorModel.fromJson(Map<String, dynamic> map) {
//     return DefaultErrorModel(
//       message: map['message'] ?? '',
//       status: map['status'] ?? '',
//     );
//   }
//   @override
//   String toString() {
//     return 'ErrorModel(message: $message, status: $status)';
//   }
// }

// class ErrorModel {
//   final bool status;
//   final Map<String, List<String>> message;

//   ErrorModel({
//     required this.status,
//     required this.message,
//   });

//   factory ErrorModel.fromJson(Map<String, dynamic> json) {
//     return ErrorModel(
//       status: json['status'] ?? false,
//       message: Map<String, List<String>>.from(
//         (json['message'] as Map).map(
//           (key, value) => MapEntry(key.toString(), List<String>.from(value)),
//         ),
//       ),
//     );
//   }

//   String get firstErrorMessage {
//     if (message.isEmpty) return "An unknown error occurred";
//     final firstList = message.values.first;
//     return firstList.isNotEmpty ? firstList.first : "An unknown error occurred";
//   }

//   @override
//   String toString() {
//     return firstErrorMessage;
//   }
// }

import 'package:flutter/foundation.dart';

class DefaultModel {
  final String? message;
  final bool?
  status; // Note: status parsing assumes boolean, API might return string 'false'

  DefaultModel({this.message, this.status});

  factory DefaultModel.fromJson(Map<String, dynamic> map) {
    return DefaultModel(
      message:
          map['message'] as String? ??
          'Unknown error message', // Handle null message
      // Handle status potentially being a string 'false' or actual boolean false
      status: map['status'] == false || map['status'] == 'false',
    );
  }

  @override
  String toString() {
    return message ?? ""; // Primarily return the message for easy use
  }
}

// // models/error_model.dart (adjust path)
// class ErrorModel {
//   final bool status;
//   final Map<String, List<String>> message;

//   ErrorModel({
//     required this.status,
//     required this.message,
//   });

//   factory ErrorModel.fromJson(Map<String, dynamic> json) {
//     Map<String, List<String>> parsedMessages = {};
//     if (json['message'] is Map) {
//       try {
//         parsedMessages = Map<String, List<String>>.from(
//           (json['message'] as Map).map((key, value) {
//             if (value is List) {
//               // Ensure all elements in the list are converted to strings
//               return MapEntry(key.toString(),
//                   List<String>.from(value.map((e) => e.toString())));
//             }
//             // If value is not a list, treat it as an empty list for this key
//             return MapEntry(key.toString(), <String>[]);
//           }),
//         );
//       } catch (e) {
//         print("Error parsing detailed message map: $e");
//         // Handle parsing error, maybe add a generic error entry
//         parsedMessages['_parsingError'] = ["Could not parse error details."];
//       }
//     } else {
//       print(
//           "Warning: Expected 'message' to be a Map in ErrorModel, but got ${json['message']?.runtimeType}");
//       // Provide a default structure if message is not a map
//       parsedMessages['_formatError'] = [
//         "Invalid error message format received."
//       ];
//     }

//     return ErrorModel(
//       status: json['status'] == false ||
//           json['status'] == 'false', // Handle string 'false' too
//       message: parsedMessages,
//     );
//   }

//   // Gets the first error message from the first non-empty list in the map
//   String get firstErrorMessage {
//     if (message.isEmpty) return "An unknown error occurred (no details).";

//     final firstErrorList = message.values.firstWhere(
//       (list) => list.isNotEmpty,
//       // Return null if no list has content
//     );

//     return firstErrorList.first;
//   }

//   @override
//   String toString() {
//     return firstErrorMessage; // Represent the model by its primary error message
//   }
// }

// models/error_model.dart (adjust path)

class ErrorModel {
  final bool status;
  final Map<String, List<String>> message; // The core map of errors

  ErrorModel({required this.status, required this.message});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<String>> parsedMessages = {};
    if (json['message'] is Map) {
      try {
        // Safely parse the map, ensuring keys are strings and values are lists of strings
        parsedMessages = Map<String, List<String>>.fromEntries(
          (json['message'] as Map).entries.map((entry) {
            final key = entry.key.toString();
            final value = entry.value;
            if (value is List) {
              // Convert each item in the list to a string
              final stringList = value.map((item) => item.toString()).toList();
              return MapEntry(key, stringList);
            } else {
              // If value is not a list, return an empty list for this key
              if (kDebugMode) {
                // Log only in debug mode
                print(
                  "Warning: Expected List for key '$key' in error message map, but got ${value?.runtimeType}",
                );
              }
              return MapEntry(key, <String>[]);
            }
          }),
        );
      } catch (e) {
        if (kDebugMode) {
          print("Error parsing detailed message map structure: $e");
        }
        // Provide a generic error entry if parsing fails
        parsedMessages['_parsingError'] = ["Could not parse error details."];
      }
    } else {
      if (kDebugMode) {
        print(
          "Warning: Expected 'message' to be a Map in ErrorModel, but got ${json['message']?.runtimeType}",
        );
      }
      // Provide a default structure if message is not a map
      parsedMessages['_formatError'] = [
        "Invalid error message format received.",
      ];
    }

    return ErrorModel(
      // Handle status potentially being string 'false' or boolean false
      status:
          !(json['status'] == false ||
              json['status'] ==
                  'false'), // Status is true unless explicitly false
      message: parsedMessages,
    );
  }

  /// Returns the first error message found in the map.
  /// Useful for displaying a single primary error.
  String get firstErrorMessage {
    if (message.isEmpty) return "An unknown error occurred (no details).";

    // Find the first list within the map values that is not empty
    final firstErrorList = message.values.firstWhere(
      (list) => list.isNotEmpty,
      // Return null if all lists are empty
    );

    // Return the first message from that list, or a default message
    return firstErrorList.first;
  }

  /// Returns a single string containing all error messages, separated by newlines.
  /// Useful for displaying a summary of all validation errors.
  String get allMessagesAsString {
    if (message.isEmpty) return "An unknown error occurred (no details).";

    // Flatten all message lists into a single list of strings
    final allMessageStrings = message.values.expand((list) => list).toList();

    if (allMessageStrings.isEmpty) {
      return "An unknown error occurred (empty details).";
    }

    // Join them with a newline character
    return allMessageStrings.join('\n');
  }

  /// Provides a string representation showing all error messages.
  @override
  String toString() {
    // Default string representation shows all messages separated by newline
    return allMessagesAsString;
  }

  /// Helper to get error messages specifically for a given field key (e.g., 'email', 'password').
  /// Returns null if the field has no errors.
  List<String>? getErrorsForField(String fieldKey) {
    final errors = message[fieldKey];
    return (errors != null && errors.isNotEmpty) ? errors : null;
  }

  /// Helper to get the first error message for a specific field.
  /// Returns null if the field has no errors.
  String? getFirstErrorForField(String fieldKey) {
    final errors = getErrorsForField(fieldKey);
    return errors?.first;
  }
}
