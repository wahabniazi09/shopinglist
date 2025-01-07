String? emailValidation(String? value) {
  if (value!.isEmpty) {
    return "Value is required";
  }

  Pattern pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regExp = RegExp(pattern.toString());

  if (!regExp.hasMatch(value)) {
    return "Enter Valid Email";
  }

  return null;
}

String? passwordValidation(String? value) {
  if (value!.isEmpty) {
    return "Value is required";
  }

  Pattern pattern =
      r'^\d{8}$';
  RegExp regExp = RegExp(pattern.toString());

  if (!regExp.hasMatch(value)) {
    return "Enter Valid Password";
  }
  return null;
}
