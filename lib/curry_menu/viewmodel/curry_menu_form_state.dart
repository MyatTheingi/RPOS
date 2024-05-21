import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rpos_demo/curry_menu/viewmodel/menu_category.dart';

part 'curry_menu_form_state.freezed.dart';

@freezed
class CurryMenuFormState with _$CurryMenuFormState {
  const CurryMenuFormState._();

  const factory CurryMenuFormState({
    MenuCategory? category,
    @Default('') String name,
    @Default('') String unitPrice,
    @Default('') String quantity,
        @Default('') String remark,

     @Default(true) bool isActive,
  }) = _CurryMenuFormState;
}

