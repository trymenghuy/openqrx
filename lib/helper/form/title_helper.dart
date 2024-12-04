class TitleHelper {
  static String camelToTitle(String camelCase) {
    final RegExp regExp = RegExp(r'(?<=[a-z])(?=[A-Z])');
    return camelCase
        .split(regExp)
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
