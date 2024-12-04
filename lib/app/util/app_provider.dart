import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppProvider<T extends ChangeNotifier> extends StatefulWidget {
  const AppProvider(
      {Key? key, required this.provider, required this.child, this.onReady})
      : super(key: key);
  final T provider;
  final Function(T)? onReady;
  final Widget child;

  @override
  State<AppProvider<T>> createState() => _AppProviderState<T>();
}

class _AppProviderState<T extends ChangeNotifier>
    extends State<AppProvider<T>> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    widget.onReady?.call(widget.provider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => widget.provider,
      builder: (context, child) {
        return widget.child;
      },
      // child: widget.child,
    );
  }
}
