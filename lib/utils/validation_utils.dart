abstract class ValidationUtils {
  static String? phoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required. Please enter a valid 10-digit number.";
    } else if (value.trim().length < 10) {
      return "Please enter a valid 10-digit number.";
    } else {
      return null;
    }
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required. Please enter your full name.";
    } else if (value.trim().length < 3) {
      return "Name should be atleast 5 character long";
    } else {
      return null;
    }
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required. Please enter your email address.";
    } else if (!value.trim().contains("@")) {
      return "Please enter a valid email address.";
    } else {
      return null;
    }
  }

  static String? stateDropdown(String? value) {
    if (value == null || value.isEmpty) {
      return "State is required. Please select state";
    } else {
      return null;
    }
  }

  static String? cityDropdown(String? value) {
    if (value == null || value.isEmpty) {
      return "City is required. Please select city";
    } else {
      return null;
    }
  }

  static String? otp(String? value) {
    if (value == null || value.isEmpty) {
      return "Otp is required. Please enter valid otp";
    } else if (value.trim().length < 6) {
      return "Enter valid otp";
    } else {
      return null;
    }
  }
}
