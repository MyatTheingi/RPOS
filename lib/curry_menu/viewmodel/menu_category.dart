import 'package:flutter/widgets.dart';

enum MenuCategory {
  MAIN_DISH,
  CHINESE_CURRY,
  SOUP,
  COLD_DRINK,
  SNACK,
}

extension IncomePeriodicityX on MenuCategory {
  String getName(BuildContext context) {
    switch (this) {
      case MenuCategory.MAIN_DISH:
        return 'Main Dish';
      case MenuCategory.CHINESE_CURRY:
        return 'Chinese Curry';
      case MenuCategory.SOUP:
        return 'Soup';
      case MenuCategory.SNACK:
        return 'Snack';
      case MenuCategory.COLD_DRINK:
        return 'Cold Drink';
    }
  }
}