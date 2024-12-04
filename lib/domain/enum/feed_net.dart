import 'package:openqrx/app/provider/setting_provider.dart';
import 'package:openqrx/domain/enum/item_base.dart';

enum FeedNet implements OptBase {
  kg30(30, '30 kg'),
  kg50(50, '50 kg');

  const FeedNet(this.value, this.km, [this.en]);
  @override
  final int value;
  @override
  final String? en;
  @override
  final String km;
  @override
  String get title => SettingProvider.instance.isKh ? km : (en ?? km);
  factory FeedNet.from(value) {
    return FeedNet.values
        .firstWhere((e) => e.value == value, orElse: () => FeedNet.kg50);
  }
}
