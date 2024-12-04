import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/feature/shared/widgets/title.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.sanitizer_rounded,
              size: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(x10),
              child: SubTitleLg('Page Not Found'),
            ),
            FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go Back'))
          ],
        ),
      ),
    );
  }
}
