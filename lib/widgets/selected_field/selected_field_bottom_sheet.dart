part of 'selected_field.dart';

Future<void> showSelectedBottomSheet<T>(
  BuildContext context,
  SelectedFieldDelegate<T> delegate, {
  OnItemSelectedCallback<T>? onSelected,
}) async {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight:MediaQuery.of(context).size.height * .8,
    ),
    builder: (_) => SelectedBottomSheet(
      delegate: delegate,
      onSelected: onSelected,
    ),
  );
}

class SelectedBottomSheet<T> extends StatefulWidget {
  const SelectedBottomSheet({
    super.key,
    required this.delegate,
    this.onSelected,
  });

  final SelectedFieldDelegate<T> delegate;
  final OnItemSelectedCallback<T>? onSelected;

  @override
  State<SelectedBottomSheet<T>> createState() => _SelectedBottomSheetState<T>();
}

class _SelectedBottomSheetState<T> extends State<SelectedBottomSheet<T>> {
  String _filterText = '';

  @override
  Widget build(BuildContext context) {
    final currentItems = widget.delegate.filterData(_filterText);
    final colorScheme =Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Card(
        color: colorScheme.surface,
        margin:EdgeInsets.all(16) +
            EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  Expanded(
                    child: Text(
                      'Select ${widget.delegate.title}',
                      style: textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: widget.delegate.onFilterTextChanged != null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search_rounded),
                      labelText: 'Filter',
                    ),
                    onChanged: (text) => setState(() => _filterText = text),
                  ),
                ),
              ),
              Flexible(
                child: Scrollbar(
                  thumbVisibility: true,
                  radius:  Radius.circular(28),
                  thickness: 2,
                  child: widget.delegate.separator != null
                      ? ListView.separated(
                          physics: const ClampingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: currentItems.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final item = currentItems[index];
                            return _buildItem(item, colorScheme);
                          },
                          separatorBuilder: (context, _) =>
                              widget.delegate.separator!,
                        )
                      : ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: currentItems.length,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final item = currentItems[index];
                            return _buildItem(item, colorScheme);
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(T item, ColorScheme colorScheme) {
    final isSelected = item == widget.delegate.selectedItem;
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        widget.onSelected?.call(item);
      },
      borderRadius: BorderRadius.all(Radius.circular(28)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(28)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: IconTheme(
            data: IconThemeData(
              color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
            ),
            child: DefaultTextStyle(
              style: TextStyle(
                color:
                    isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
              ),
              child: widget.delegate.itemBuilder(context, item),
            ),
          ),
        ),
      ),
    );
  }
}
