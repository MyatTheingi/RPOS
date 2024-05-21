import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rpos_demo/curry_menu/viewmodel/curry_menu_viewmodel.dart';
import 'package:rpos_demo/widgets/selected_field/selected_field.dart';
import '../../widgets/text_form_field/clearable_text_form_field.dart';
import '../../widgets/text_form_field/currency_text_form_field.dart';
import '../../widgets/text_form_field/text_area_field.dart';
import '../viewmodel/menu_category.dart';

class MenuInputForm extends StatelessWidget {
  const MenuInputForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CurryMenuViewmodel>(
        create: (context) => CurryMenuViewmodel(),
        child: Consumer<CurryMenuViewmodel>(
            builder: (context, vm, unsubscribedChild) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SelectedField<MenuCategory>(
                  items: MenuCategory.values,
                  title: 'Category',
                  required: true,
                  labelParser: (item) => item.getName(context),
                  onSelected: vm.updateCategory,
                  selectedItem: vm.formState.category,
                ),
                SizedBox(height: 8),
                ClearableTextFormField(
                  initialValue: vm.formState.name,
                  required: true,
                  labelText: 'Name',
                  onChanged: vm.updateName,
                ),
                SizedBox(height: 8),
                CurrencyTextFormField(
                  initialValue: vm.formState.unitPrice,
                  labelText: 'Unit Price',
                  required: true,
                  onChanged: vm.updatePrice,
                ),
                SizedBox(height: 8),
                ClearableTextFormField(
                  initialValue: vm.formState.quantity,
                  required: true,
                  labelText: 'Quantity',
                  onChanged: vm.updateQuanntity,
                ),
                SizedBox(height: 8),
                TextAreaField(
                  labelText: 'Description',
                  onChanged: vm.updateRemark,
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                          
                      onPressed: () {},
                      child: Text('Add Menu'),
                    ))
                  ],
                )
              ],
            ),
          );
        }));
  }
}
