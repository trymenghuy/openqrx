import 'package:openqrx/app/provider/setting_provider.dart';
import 'package:openqrx/domain/enum/item_base.dart';

enum WeekFeed implements OptBase {
  week3(3, 'Week 3', 'សប្តាហ៍ទី 3'),
  week4(4, 'Week 4', 'សប្តាហ៍ទី 4'),
  week5(5, 'Week 5', 'សប្តាហ៍ទី 5'),
  week6(6, 'Week 6', 'សប្តាហ៍ទី 6'),
  week7(7, 'Week 7', 'សប្តាហ៍ទី 7'),
  week8(8, 'Week 8', 'សប្តាហ៍ទី 8'),
  week9(9, 'Week 9', 'សប្តាហ៍ទី 9'),
  week10(10, 'Week 10', 'សប្តាហ៍ទី 10'),
  week11(11, 'Week 11', 'សប្តាហ៍ទី 11'),
  week12(12, 'Week 12', 'សប្តាហ៍ទី 12'),
  week13(13, 'Week 13', 'សប្តាហ៍ទី 13'),
  week14(14, 'Week 14', 'សប្តាហ៍ទី 14'),
  week15(15, 'Week 15', 'សប្តាហ៍ទី 15'),
  week16(16, 'Week 16', 'សប្តាហ៍ទី 16'),
  week17(17, 'Week 17', 'សប្តាហ៍ទី 17'),
  week18(18, 'Week 18', 'សប្តាហ៍ទី 18'),
  week19(19, 'Week 19', 'សប្តាហ៍ទី 19'),
  week20(20, 'Week 20', 'សប្តាហ៍ទី 20'),
  week21(21, 'Week 21', 'សប្តាហ៍ទី 21'),
  week22(22, 'Week 22', 'សប្តាហ៍ទី 22'),
  week23(23, 'Week 23', 'សប្តាហ៍ទី 23'),
  week24(24, 'Week 24', 'សប្តាហ៍ទី 24'),
  week25(25, 'Week 25', 'សប្តាហ៍ទី 25'),
  week26(26, 'Week 26', 'សប្តាហ៍ទី 26'),
  week27(27, 'Week 27', 'សប្តាហ៍ទី 27'),
  other(0, 'Other', 'ផ្សេងៗ');

  const WeekFeed(this.value, this.en, this.km);

  @override
  final int value;
  @override
  final String en;
  @override
  final String km;

  @override
  String get title => SettingProvider.instance.isKh ? km : en;

  factory WeekFeed.from(int value) {
    return WeekFeed.values
        .firstWhere((e) => e.value == value, orElse: () => WeekFeed.other);
  }
}
