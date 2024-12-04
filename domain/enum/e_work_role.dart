import 'package:openqrx/app/provider/setting_provider.dart';
import 'package:openqrx/domain/enum/item_base.dart';

enum EWorkRole implements OptBase {
  manager('manager', 'General Manager', 'អ្នកគ្រប់គ្រង'),
  senior8('senior8', 'Manager 8', 'មេការ8ទ្រុង'),
  senior4('senior4', 'Manager 4', 'មេការ4ទ្រុង'),
  technical('technical', 'Technical', 'ជាងជួសជុល'),
  worker('worker', 'Normal worker', 'អ្នកមើលក្នុងទ្រុង'),
  other('other', 'Other', 'ផ្សេងទៀត');

  const EWorkRole(this.value, this.en, this.km);
  @override
  final String value;
  @override
  final String en;
  @override
  final String km;
  @override
  String get title => SettingProvider.instance.isKh ? km : en;
  factory EWorkRole.from(value) {
    return EWorkRole.values
        .firstWhere((e) => e.value == value, orElse: () => EWorkRole.other);
  }
}
