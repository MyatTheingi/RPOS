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
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xff764abc),
            child: Text(items[index]),
          ),
          title: Text('Item ${items[index]}'),
          subtitle: Text('Item description'),
          trailing: Icon(Icons.more_vert),
        );
      },
    );
  }
}
