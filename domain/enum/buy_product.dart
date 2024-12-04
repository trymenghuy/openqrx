import 'package:openqrx/app/provider/setting_provider.dart';
import 'package:openqrx/domain/enum/item_base.dart';

enum BuyProduct implements OptBase {
  mobileTopUp1('mobileTopUp1', 'Mobile Top Up 1\$', 'កាតទូរស័ព្ទ 1\$'),
  mobileTopUp2('mobileTopUp2', 'Mobile Top Up 2\$', 'កាតទូរស័ព្ទ 2\$'),
  mobileTopUp3('mobileTopUp3', 'Mobile Top Up 3\$', 'កាតទូរស័ព្ទ 3\$'),
  beer1('beer1', 'Beer 1', 'ស្រាបៀរ 1'),
  beer6('beer6', 'Beer 6', 'ស្រាបៀរ 6'),
  beer12('beer12', 'Beer 12', 'ស្រាបៀរ 12'),
  beer24('beer24', 'Beer 24', 'ស្រាបៀរ 24'),
  drink2000('drink2000', 'Drink 2000', 'ភេសជ្ជៈ 2000'),
  drink2500('drink2500', 'Drink 2500', 'ភេសជ្ជៈ 2500'),
  drink3000('drink3000', 'Drink 3000', 'ភេសជ្ជៈ 3000'),
  changeDrink1000('changeDrink1000', 'Change Drink 1000', 'ប្តូរភេសជ្ជៈ 1000'),
  changeDrink2000('changeDrink2000', 'Change Drink 2000', 'ប្តូរភេសជ្ជៈ 2000'),
  cigarette1('cigarette1', 'Cigarette 1', 'បារី 1'),
  cigarette2('cigarette2', 'Cigarette 2', 'បារី 2'),
  cigarette3('cigarette3', 'Cigarette 3', 'បារី 3'),
  cigarette4('cigarette4', 'Cigarette 4', 'បារី 4'),
  none('none', 'None', 'គ្មាន'),
  ;

  const BuyProduct(this.value, [this.km, this.en]);
  @override
  final String value;
  @override
  final String? en;
  @override
  final String? km;
  @override
  String get title =>
      SettingProvider.instance.isKh ? (km ?? value) : (en ?? value);
  factory BuyProduct.from(value) {
    return BuyProduct.values
        .firstWhere((e) => e.value == value, orElse: () => BuyProduct.none);
  }
}
