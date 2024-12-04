// Enum for food categories
import 'package:openqrx/domain/enum/item_base.dart';

enum ECategory implements OptBase {
  rice,
  soup,
  hot,
  cold,
  beer,
  coffee,
  juice,
  cola,
  beef,
  pork,
  chicken,
  crap,
  octopus,
  shrimp,
  none;

  @override
  String get value => name;
  @override
  final String? en;
  @override
  final String? km;
  const ECategory([this.en, this.km]);
  @override
  String get title => name;
  factory ECategory.fromValue(String? ln) => ECategory.values
      .firstWhere((e) => e.name == ln, orElse: () => ECategory.none);
}

// enum FoodCategory {
//   appetizer,
//   mainCourse,
//   dessert,
//   salad,
//   soup,
//   sandwich,
//   burger,
//   pizza,
//   pasta,
//   seafood,
//   steak,
//   chicken,
//   vegetarian,
//   vegan,
//   glutenFree,
//   kidsMeal,
//   none;

//   factory FoodCategory.fromValue(String? ln) => FoodCategory.values
//       .firstWhere((e) => e.name == ln, orElse: () => FoodCategory.none);
// }

// // Enum for drink categories
// enum DrinkCategory {
//   nonAlcoholicBeverages,
//   alcoholicBeverages,
//   softDrink,
//   juice,
//   water,
//   coffee,
//   tea,
//   beer,
//   wine,
//   cocktail,
//   none;

//   factory DrinkCategory.fromValue(String? ln) => DrinkCategory.values
//       .firstWhere((e) => e.name == ln, orElse: () => DrinkCategory.none);
// }

// // Enum for other categories
// enum OtherCategory {
//   sides,
//   special,
//   combo,
//   none;

//   factory OtherCategory.fromValue(String? ln) => OtherCategory.values
//       .firstWhere((e) => e.name == ln, orElse: () => OtherCategory.none);
// }
