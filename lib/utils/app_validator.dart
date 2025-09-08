class AppValidator {
  String? validateEmail(value) {
    if (value!.isEmpty) {
      return 'Please Enter Your Email';
    }
    RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePhoneNumber(value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Your Phone number";
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return "Phone number must contain only digits";
    }
    if (!value.startsWith('7')) {
      return "phone number must start with 7";
    }
    if (value.length != 9) {
      return "Invalid Phone number";
    }
    return null;
  }

  String? validateUserName(value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Your User Name';
    }
    return null;
  }

  String? validatePassword(value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Your Password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }
}
