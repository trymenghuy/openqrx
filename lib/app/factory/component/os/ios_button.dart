import 'package:flutter/cupertino.dart';
import 'package:openqrx/app/factory/component/button.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/feature/shared/widgets/dialog_body.dart';

class IOSButton implements Button {
  @override
  Widget textButton(
      {required String text, required VoidCallback? onTap, bool? danger}) {
    return CupertinoButton(
        onPressed: onTap,
        child: Text(
          text,
          style: xStyle.titleMedium?.copyWith(color: flagColor(danger)),
        ));
  }

  @override
  void popDialog(
      {required String title,
      required List<Widget> children,
      List<Widget>? actions}) {
    pop(
      child: CupertinoAlertDialog(
        title: Text(title),
        content: DialogBody(children: children),
        actions: actions ?? [],
      ),
    );
  }

  @override
  Widget actionButton(
      {required String text, required VoidCallback onTap, bool? danger}) {
    return CupertinoActionSheetAction(
      onPressed: onTap,
      isDestructiveAction: danger == true,
      child: Text(
        text,
        style: TextStyle(fontSize: xStyle.bodyLarge?.fontSize),
      ),
    );
  }

  @override
  Widget loading({bool light = false}) {
    return CupertinoActivityIndicator(
      radius: 15,
      color: light ? xColor.background : xColor.onBackground,
    );
  }

  @override
  Widget dialog(
      {required String title,
      required List<Widget> children,
      List<Widget>? actions}) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Padding(
        padding: const EdgeInsets.only(top: x5),
        child: DialogBody(children: children),
      ),
      actions: actions ?? [],
    );
  }

  @override
  void pop({required Widget child}) {
    showCupertinoDialog(
      context: XNavigator.context,
      builder: (context) => child,
    );
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
  Widget get smallLoad => const CupertinoActivityIndicator(radius: x10 / 2);
}
