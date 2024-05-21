
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rpos_demo/curry_menu/menu_input_form.dart';
import 'package:rpos_demo/curry_menu/menu_item_list_view.dart';

import '../widgets/selected_field/selected_field.dart';

class MenuViewWidget extends StatelessWidget {
  const MenuViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
   return  Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(12) ,  
          child: MenuInputForm(),
          ),
        ),
        Expanded(
          flex: 3,
         child: Container(
          padding: EdgeInsets.all(12),
           decoration: BoxDecoration(color: Colors.yellow),
          child: MenuItemListView(),
          ),
        ),
       
      ],
    );
  }
}
