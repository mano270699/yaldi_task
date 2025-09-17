class Validation {
  static String firstNameValidation(String? input) {
    if (input == null || input.isEmpty) {
      return "This field cannot be empty";
    }
    if (input.length < 2) {
      return "First name must be at least 2 characters";
    }
    return "";
  }

  static String lastNameValidation(String? input) {
    if (input == null || input.isEmpty) {
      return "This field cannot be empty";
    }
    if (input.length < 2) {
      return "Last name must be at least 2 characters";
    }
    return "";
  }

  static String userEmailValidation(String? input) {
    if (input == null || input.isEmpty) {
      return "This field cannot be empty";
    }
    if (!input.contains('@') || !input.contains('.')) {
      return "Email must be valid and contain @ and .";
    }
    final regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$",
    );
    if (!regex.hasMatch(input)) {
      return 'Email is invalid';
    }
    return "";
  }

  static String usernameValidation(String? input) {
    if (input == null || input.isEmpty) {
      return "This field cannot be empty";
    }
    return "";
  }

  static String passwordValidation(String? input) {
    if (input == null || input.isEmpty) {
      return "Invalid password. Try again*";
    }
    if (input.length < 6) {
      return "Password must be at least 6 characters";
    }
    return "";
  }

  static String passwordConfirmationValidation(
    String? input, {
    required String passWord,
  }) {
    if (input == null || input.isEmpty) {
      return "This field cannot be empty";
    }
    if (input != passWord) {
      return "Confirmation password must match the original";
    }
    return "";
  }

  static String fieldRequiredValidation(String? input) {
    if (input == null || input.isEmpty) {
      return "This field cannot be empty";
    }
    return "";
  }
}
