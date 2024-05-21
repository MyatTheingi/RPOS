part of 'selected_field.dart';

typedef OnItemSelectedCallback<T> = FutureOr<void> Function(T item);

typedef WidgetItemBuilder<T> = Widget Function(BuildContext context, T item);

typedef ItemLabelParser<T> = String Function(T item);

typedef OnFilterTextChanged<T> = bool Function(T item, String filterText);
