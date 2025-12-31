import 'package:easy_localization/easy_localization.dart';

// A utility class for validating various input fields.
class MyValidators {
  // Validates a display name.
  static String? displayNameValidator(String? displayName) {
    if (displayName == null || displayName.isEmpty) {
      // Return an error message if the display name is empty.
      return 'userNameValidator'.tr();
    }
    if (displayName.length < 3 || displayName.length > 20) {
      // Return an error message if the display name length is invalid.
      return 'checkUserName'.tr();
    }

    return null; // Return null if display name is valid
  }

  // Validates an email address.
  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      // Return an error message if the email is empty.
      return 'emailValidation'.tr();
    }
    if (!RegExp(
      r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
    ).hasMatch(value)) {
      return 'emailConfirm'.tr();
    }
    return null;
  }

  // Validates a phone number.
  static String? phoneValidator(String? value) {
    if (value!.isEmpty) {
      // Return an error message if the phone number is empty.
      return 'Please enter an phone';
    }
    if (value.length < 11) {
      // Return an error message if the phone number length is invalid.
      return 'phone must be at least 11 characters long';
    }

    return null;
  }

  // Validates a password.
  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      // Return an error message if the password is empty.
      return 'passwordValidator'.tr();
    }
    if (value.length < 8) {
      // Return an error message if the password length is invalid.
      return 'checkPassword'.tr();
    }
    return null;
  }

  // Validates a national ID.
  static String? nationalIdValidator(String? value) {
    if (value!.isEmpty) {
      // Return an error message if the national ID is empty.
      return 'Please enter a  nationalId';
    }
    if (value.length < 14) {
      // Return an error message if the national ID length is invalid.
      return 'nationalId must be at least 14 characters long';
    }
    return null;
  }

  // Validates that a repeated password matches the original password.
  static String? repeatPasswordValidator({String? value, String? password}) {
    if (value != password) {
      // Return an error message if the passwords do not match.
      return 'passwordValidation'.tr();
    }
    return null;
  }

  // Validates a gender selection.
  static String? genderValidator(String? value) {
    if (value == null || value.isEmpty) {
      // Return an error message if the gender is not selected.
      return 'please enter gender';
    }
    return null;
  }

  // Validates an image selection.
  static String? imageValidator(String? image) {
    if (image == null || image.isEmpty) {
      // Return an error message if no image is selected.
      return 'Image cannot be empty';
    }
    return null;
  }

  // Validates a token.
  static String? tokenValidator(String? val) {
    if (val == null || val.isEmpty) {
      return 'token cannot be empty';
    }
    return null;
  }
}
