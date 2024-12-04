import 'package:openqrx/app/provider/setting_provider.dart';
import 'package:openqrx/domain/enum/item_base.dart';

enum LendReason implements OptBase {
  family('family', 'Family Support', 'ផ្គត់ផ្គង់គ្រួសារ'),
  education('education', 'Education', 'ការអប់រំ'),
  medical('medical', 'Medical Expenses', 'ការចំណាយផ្នែកសុខាភិបាល'),
  business('business', 'Business', 'អាជីវកម្ម'),
  emergency('emergency', 'Emergency', 'ការបន្ទាន់'),
  personal('personal', 'Personal Use', 'ការប្រើប្រាស់ផ្ទាល់ខ្លួន'),
  other('other', 'Other', 'ផ្សេងៗ');

  const LendReason(this.value, this.en, this.km);

  @override
  final String value;
  @override
  final String en;
  @override
  final String km;

  @override
  String get title => SettingProvider.instance.isKh ? km : en;

  factory LendReason.from(String value) {
    return LendReason.values
        .firstWhere((e) => e.value == value, orElse: () => LendReason.other);
  }
}
