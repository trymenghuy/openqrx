// import 'package:flutter/material.dart';
// import 'package:openqrx/app/util/txt.dart';

// class XText extends RichText {
//   Text(
//     String data, {
//     super.key,
//     TextStyle? style,
//     super.textAlign,
//     super.textDirection,
//     super.softWrap,
//     super.overflow,
//     super.textScaleFactor,
//     super.maxLines,
//     super.locale,
//     super.strutStyle,
//     super.textWidthBasis,
//     super.textHeightBehavior,
//     super.selectionColor,
//   }) : super(
//           text: _buildTextSpans(data, style),
//         );

//   static bool _isKhmerCharacter(String char) {
//     return char.codeUnitAt(0) >= 0x1780 && char.codeUnitAt(0) <= 0x17FF;
//   }

//   static TextSpan _buildTextSpans(String data, TextStyle? style) {
//     TextStyle baseStyle =
//         xStyle.bodyLarge?.merge(style) ?? style ?? const TextStyle();
//     List<TextSpan> textSpans = [];
//     String currentSegment = '';
//     bool isCurrentSegmentKhmer =
//         data.isNotEmpty ? _isKhmerCharacter(data[0]) : false;

//     for (int i = 0; i < data.length; i++) {
//       if (_isKhmerCharacter(data[i]) == isCurrentSegmentKhmer) {
//         currentSegment += data[i];
//       } else {
//         textSpans.add(TextSpan(
//           text: currentSegment,
//           style: baseStyle.copyWith(
//             fontFamily: isCurrentSegmentKhmer ? 'Koh Santepheap' : null,
//           ),
//         ));
//         currentSegment = data[i];
//         isCurrentSegmentKhmer = !isCurrentSegmentKhmer;
//       }
//     }

//     textSpans.add(TextSpan(
//       text: currentSegment,
//       style: baseStyle.copyWith(
//         fontFamily: isCurrentSegmentKhmer ? 'Koh Santepheap' : null,
//       ),
//     ));

//     return TextSpan(
//       children: textSpans,
//       style: baseStyle,
//     );
//   }
// }
