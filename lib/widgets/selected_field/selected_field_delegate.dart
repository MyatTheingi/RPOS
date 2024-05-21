part of 'selected_field.dart';

abstract class SelectedFieldDelegate<T> {
  final String title;
  final List<T> items;
  final WidgetItemBuilder<T> itemBuilder;
  final ItemLabelParser<T> labelParser;
  final OnFilterTextChanged<T>? onFilterTextChanged;
  final T? selectedItem;
  final Widget? separator;

  SelectedFieldDelegate({
    required this.title,
    required this.items,
    required this.itemBuilder,
    required this.labelParser,
    this.selectedItem,
    this.onFilterTextChanged,
    this.separator,
  });

  List<T> filterData(String query) {
    return query.isEmpty
        ? items
        : items
            .where((e) => onFilterTextChanged?.call(e, query) ?? false)
            .toList();
  }
}

class SelectedFieldBuilderDelegate<T> extends SelectedFieldDelegate<T> {
  SelectedFieldBuilderDelegate({
    required super.title,
    required super.items,
    required super.itemBuilder,
    required super.labelParser,
    super.selectedItem,
    super.onFilterTextChanged,
    super.separator,
  });
}

class SelectedFieldSimpleDelegate<T> extends SelectedFieldDelegate<T> {
  SelectedFieldSimpleDelegate({
    required super.title,
    required super.items,
    required super.labelParser,
    ItemLabelParser<T>? subtitleParser,
    Widget? leading,
    Widget? trailing,
    super.selectedItem,
    super.onFilterTextChanged,
    super.separator,
  }) : super(
          itemBuilder: (BuildContext context, T item) {
            Widget content;
            if (subtitleParser == null) {
              content = Text(labelParser(item));
            } else {
              content = Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(labelParser(item)),
                  Text(
                    subtitleParser(item),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              );
            }
            return Row(children: [
              if (leading != null) ...[
                leading,
                const SizedBox(width: 16),
              ],
              Expanded(child: content),
              if (trailing != null) ...[
                const SizedBox(width: 16),
                trailing,
              ],
            ]);
          },
        );
}
