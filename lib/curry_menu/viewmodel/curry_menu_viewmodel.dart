import 'package:flutter/foundation.dart';
import 'package:rpos_demo/curry_menu/viewmodel/curry_menu_form_state.dart';
import 'package:rpos_demo/curry_menu/viewmodel/menu_category.dart';

class CurryMenuViewmodel extends ChangeNotifier {
  CurryMenuFormState formState = const CurryMenuFormState();

  setFormState(CurryMenuFormState value) {
    formState = value;
    notifyListeners();
  }

  updateCategory(MenuCategory category) {
    setFormState(formState.copyWith(category: category));
  }

  updateName(String name) {
    setFormState(formState.copyWith(name: name));
  }

    updatePrice(String price) {
    setFormState(formState.copyWith(unitPrice: price));
  }
    updateQuanntity(String quantity) {
    setFormState(formState.copyWith(quantity: quantity));
  }

    updateRemark(String remark) {
    setFormState(formState.copyWith(remark: remark));
  }

}
