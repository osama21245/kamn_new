import 'package:get/get.dart';

validinput(String val, int min, int max, String type) {
  if (type != "social") {
    if (val.isEmpty) {
      return "Value Can't Be Empty";
    }
  }

  if (type == "") {
    if (val.isEmpty) {
      return "Value Can't Be Empty";
    }
  }

  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "is not a username";
    }
  }

  if (type == "double") {
    if (!GetUtils.isNum(val)) {
      if (!isDouble(val)) {
        return "not a number Example:20";
      }
    }
  }

  if (type == "int") {
    if (!GetUtils.isNum(val)) {
      if (!isInteger(val)) {
        return "not a number Example:20";
      }
    }
  }

  // if (type == "email") {
  //   if (!GetUtils.isEmail(val)) {
  //     return "is not a email";
  //   }
  // }

  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "is not a phone";
    }
  }

  if (val.length < min) {
    return "Value Can't Be Less Than $min";
  }

  if (val.length > max) {
    return "Value Can't Be More Than $max";
  }
}

bool isInteger(String str) {
  try {
    int.parse(str);
    return true;
  } catch (e) {
    return false;
  }
}

bool isDouble(String str) {
  try {
    double.parse(str);
    return true;
  } catch (e) {
    return false;
  }
}
