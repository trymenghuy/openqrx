import 'package:flutter/material.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/app/util/txt.dart';

class BottomSliverAppBar extends StatefulWidget {
  final double maxChildSize;
  final double initialChildSize;
  final String title;
  final VoidCallback? onInitSelected;
  final DraggableScrollableController controller;

  const BottomSliverAppBar(
      {super.key,
      required this.controller,
      required this.maxChildSize,
      required this.title,
      this.onInitSelected,
      required this.initialChildSize});

  @override
  State<BottomSliverAppBar> createState() => _BottomSliverAppBarState();
}

class _BottomSliverAppBarState extends State<BottomSliverAppBar> {
  bool _showBackButton = false;

  @override
  void initState() {
    super.initState();
    if (widget.maxChildSize > 0.9) {
      _showBackButton = widget.initialChildSize == widget.maxChildSize;
      widget.controller.addListener(_onScroll);
    }
    if (widget.onInitSelected != null) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => widget.onInitSelected?.call());
    }
  }

  void _onScroll() {
    xPrint(widget.controller.size);
    if (widget.controller.size < widget.maxChildSize && _showBackButton) {
      setState(() => _showBackButton = false);
    } else if (widget.controller.size == widget.maxChildSize &&
        !_showBackButton) {
      setState(() => _showBackButton = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      automaticallyImplyLeading: _showBackButton,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      expandedHeight: kToolbarHeight + 20,
      toolbarHeight: kToolbarHeight + 5,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.title,
          style: xStyle.headlineSmall,
        ),
        centerTitle: true,
        expandedTitleScale: 1,
        background: Container(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: _showBackButton
                    ? Colors.transparent
                    : xColor.outline.withOpacity(0.5),
                borderRadius: radiusMedium),
            width: 40,
            height: 4,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }
}
