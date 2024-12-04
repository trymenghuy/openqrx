import 'package:openqrx/app/constants/svg.dart';

enum LN {
  km('km', 'ខ្មែរ'),
  en('en', 'English');

  const LN(this.value, this.title);
  final String value;
  final String title;
  factory LN.fromString(String? ln) {
    return LN.values.firstWhere((e) => e.value == ln, orElse: () => LN.en);
  }
  String get getSvg => this == LN.km
      ? SvgIcons.xCircleFlagsKh
      : SvgIcons.xCircleFlagsUsBetsyRoss;
}
