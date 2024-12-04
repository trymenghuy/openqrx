import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/feature/shared/widgets/buttons/left_button.dart';
import 'package:openqrx/feature/shared/widgets/buttons/right_button.dart';

class AnimatedBottomNavBar extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onClear;
  final VoidCallback onOrder;

  const AnimatedBottomNavBar({
    super.key,
    required this.isVisible,
    required this.onClear,
    required this.onOrder,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      bottom: isVisible ? 0 : -kToolbarHeight,
      left: 0,
      right: 0,
      child: Container(
        height: kToolbarHeight,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border(top: borderSide),
        ),
        child: Row(
          children: [
            LeftButton(
              icon: Icons.delete,
              onTap: onClear,
              text: 'Clear',
            ),
            space10,
            Expanded(
              child: RightButton(
                icon: Icons.add_shopping_cart_rounded,
                onTap: onOrder,
                text: 'Order',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
