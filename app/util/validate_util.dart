class ValiNumUtil {
  bool email(String value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }

  bool username(String value) {
    return RegExp(r"^(?=[a-zA-Z0-9._]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]$")
        .hasMatch(value);
  }

  bool name(String value) {
    return value.length > 4;
  }

  bool password(String value) {
    return value.length > 4;
  }
}
