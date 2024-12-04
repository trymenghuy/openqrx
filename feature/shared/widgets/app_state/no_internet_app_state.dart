import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:openqrx/app/util/assets_manager.dart';
import 'package:openqrx/app/util/txt.dart';

class NoInternetAppState extends StatelessWidget {
  final VoidCallback? onTap;
  const NoInternetAppState({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: AspectRatio(
                aspectRatio: 1.2,
                child: SvgPicture.asset(ImageAssets.noConnection),
              ),
            ),
            Text(
              'No Internet Connection',
              textAlign: TextAlign.center,
              style: xStyle.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Check your connection the refresh the page',
                textAlign: TextAlign.center,
                style: xGreyStyleLarge,
              ),
            ),
            Center(
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: borderSide, shape: const StadiumBorder()),
                  onPressed: onTap,
                  child: const Text('Refresh')),
            ),
            space20
          ],
        ),
      ),
    );
  }
}
