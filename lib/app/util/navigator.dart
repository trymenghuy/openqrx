import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/navigate_extension.dart';

class XNavigator {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext get context => navigatorKey.currentContext!;
  static NavigatorState get state => navigatorKey.currentState!;
  static String? get currentRoute {
    String? currentPath;
    state.popUntil((route) {
      currentPath = route.settings.name;
      return true;
    });
    return currentPath;
  }

  static void pushName(String route, {dynamic arguments}) =>
      state.pushNamedIfNotCurrent(route, arguments: arguments);
  static void pushReplacementNamed(String route, {dynamic arguments}) =>
      state.pushReplacementNamed(route, arguments: arguments);
  static void push(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static void pushReplace(Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static void popUntilFirst() => state.popUntil((route) => route.isFirst);
  static void pop() => state.pop();
  static void pushTransparent(Widget page, {bool replace = false}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

class NavigatorHelper {
  final BuildContext context;

  NavigatorHelper(this.context);

  Future<T?> push<T>(Widget page) async {
    return await Navigator.push<T>(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) async {
    return await Navigator.pushNamed<T>(
      context,
      routeName,
      arguments: arguments,
    );
  }
}
