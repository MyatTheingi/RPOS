import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MenuItemListView extends StatelessWidget {
  const MenuItemListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> items = List<String>.generate(10000, (i) => '$i');
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return CurryMenuItem( item: items[index],);
      },
    );
  }
}

class CurryMenuItem extends StatelessWidget {
  const CurryMenuItem({
    super.key,
    required this.item,
  });

  final String item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: true,
      leading: Container(
          width: 200,
          height: 200,
          decoration: const BoxDecoration(color: Colors.grey)),
      title: Text('Menu - ${item}'),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('1 Dish'), Text('8,000 MMK')],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: Colors.green,
              )),
          SizedBox(width: 8),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}
