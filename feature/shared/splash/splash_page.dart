import 'dart:async';

import 'package:flutter/material.dart';
import 'package:openqrx/app/provider/user_provider.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/route.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    UserProvider.instance.getRole();
    Timer(const Duration(seconds: 2), () {
      final isLogged = UserProvider.instance.isLogged;
      String route = AppRoutes.login;
      if (isLogged) {
        if (UserProvider.instance.user?.displayName == null) {
          route = AppRoutes.profileSetup;
        } else {
          route = AppRoutes.home;
        }
      }
      XNavigator.pushReplacementNamed(route);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: const Icon(
            Icons.post_add_sharp,
            size: 100,
          ),
        ),
      ),
    );
  }
}
