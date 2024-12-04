// import 'package:openqrx/app/provider/setting_provider.dart';
// import 'package:openqrx/domain/enum/item_base.dart';

// enum PigSty implements OptBase {
//   a1('A1'),
//   a2('A2'),
//   a3('A3'),
//   a4('A4'),
//   a5('A5'),
//   a6('A6'),
//   a7('A7'),
//   a8('A8'),
//   m1('M1'),
//   m2('M2'),
//   m3('M3'),
//   m4('M4'),
//   i1('I1'),
//   i2('I2'),
//   i3('I3'),
//   i4('I4'),
//   none('none'),
//   ;

//   const PigSty(this.value, [this.km, this.en]);
//   @override
//   final String value;
//   @override
//   final String? en;
//   @override
//   final String? km;
//   @override
//   String get title =>
//       SettingProvider.instance.isKh ? (km ?? value) : (en ?? value);
//   factory PigSty.from(value) {
//     return PigSty.values
//         .firstWhere((e) => e.value == value, orElse: () => PigSty.none);
//   }
// }
