import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:openqrx/app/util/txt.dart';

class SvgIcon extends StatelessWidget {
  final double size;
  final String svg;
  final Color? color;
  final bool noFilter;
  const SvgIcon(this.svg,
      {super.key, this.size = 26, this.color, this.noFilter = false});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/svg/$svg',
        width: size,
        height: size,
        colorFilter: noFilter
            ? null
            : ColorFilter.mode(color ?? xColor.primary, BlendMode.srcIn));
  }
}
