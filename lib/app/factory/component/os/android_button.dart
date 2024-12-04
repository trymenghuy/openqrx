import 'package:flutter/material.dart';
import 'package:openqrx/app/factory/component/button.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/feature/shared/widgets/dialog_body.dart';

class AndroidButton implements Button {
  @override
  Widget textButton(
      {required String text, required VoidCallback? onTap, bool? danger}) {
    return TextButton(
        style: TextButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: x15),
            backgroundColor: flagColor(danger).withOpacity(0.2),
            foregroundColor: flagColor(danger)),
        onPressed: onTap,
        child: Text(text));
  }

  @override
  void popDialog(
      {required String title,
      required List<Widget> children,
      List<Widget>? actions}) {
    pop(
      child: AlertDialog(
        title: Text(title),
        content: DialogBody(children: children),
        actions: actions,
      ),
    );
  }

  @override
  Widget actionButton(
      {required String text, required VoidCallback onTap, bool? danger}) {
    return TextButton(
      onPressed: onTap,
      child: Text(text,
          style: xStyle.titleMedium?.copyWith(color: flagColor(danger))),
    );
  }

  @override
  Widget loading({bool light = false}) {
    return SizedBox(
        width: x30,
        height: x30,
        child: CircularProgressIndicator.adaptive(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(
                light ? xColor.surface : xColor.onSurface)));
  }

  @override
  Widget dialog(
      {required String title,
      required List<Widget> children,
      List<Widget>? actions}) {
    return AlertDialog(
      title: Text(title),
      content: DialogBody(children: children),
      actionsPadding: actions == null
          ? null
          : const EdgeInsets.symmetric(vertical: x10, horizontal: x20),
      actions: actions,
    );
  }

  @override
  void pop({required Widget child}) {
    showGeneralDialog(
      context: XNavigator.context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox();
      },
      transitionBuilder: (context, animation1, animation2, _) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.7, end: 1.0).animate(CurvedAnimation(
            parent: animation1,
            curve: Curves.easeOutQuad,
            reverseCurve: Curves.easeInQuad,
          )),
          child: child,
        );
      },
    );
    // showDialog(
    //   context: XNavigator.context,
    //   builder: (context) => child,
    // );
  }

  @override
  void confirm(
      {required String title,
      required String subTitle,
      String? next,
      required VoidCallback onNext}) {
    popDialog(
      title: title,
      children: [
        Text(
          subTitle,
          style: xGreyStyleLarge,
        ),
      ],
      actions: [
        actionButton(
            text: txt.cancel_btn_txt,
            danger: false,
            onTap: () {
              XNavigator.pop();
            }),
        actionButton(
          text: next ?? txt.next,
          danger: true,
          onTap: () {
            XNavigator.pop();
            onNext();
          },
        )
      ],
    );
  }

  @override
  Widget get smallLoad => const Padding(
        padding: EdgeInsets.symmetric(horizontal: x2),
        child: SizedBox(
            width: x8,
            height: x8,
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 1.5,
            )),
      );
}
