import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

part 'selected_field_bottom_sheet.dart';
part 'selected_field_delegate.dart';
part 'selected_field_typedefs.dart';

class SelectedField<T> extends StatefulWidget {
  const SelectedField._({
    super.key,
    required SelectedFieldDelegate<T> delegate,
    T? selectedItem,
    OnItemSelectedCallback<T>? onSelected,
    Widget? prefixIcon,
    Widget? separator,
    FormFieldValidator<String>? validator,
    bool required = false,
  })  : _delegate = delegate,
        _prefixIcon = prefixIcon,
        _onSelected = onSelected,
        _validator = validator,
        _required = required;

  final SelectedFieldDelegate<T> _delegate;
  final OnItemSelectedCallback<T>? _onSelected;
  final Widget? _prefixIcon;
  final FormFieldValidator<String>? _validator;
  final bool _required;

  /// You can replace with [SelectedField.simple].
  /// Didn't required [labelParser], using [toString] method instead
  factory SelectedField({
    required String title,
    required List<T> items,
    required ItemLabelParser<T> labelParser,
    ItemLabelParser<T>? subtitleParser,
    Widget? prefixIcon,
    Widget? leading,
    Widget? trailing,
    Widget? separator,
    required T? selectedItem,
    OnItemSelectedCallback<T>? onSelected,
    OnFilterTextChanged<T>? onFilterTextChanged,
    FormFieldValidator<String>? validator,
    bool required = false,
  }) {
    return SelectedField._(
      delegate: SelectedFieldSimpleDelegate<T>(
        title: title,
        items: items,
        labelParser: labelParser,
        subtitleParser: subtitleParser,
        leading: leading,
        trailing: trailing,
        selectedItem: selectedItem,
        onFilterTextChanged: onFilterTextChanged,
        separator: separator,
      ),
      onSelected: onSelected,
      prefixIcon: prefixIcon,
      validator: validator,
      required: required,
    );
  }

  factory SelectedField.simple({
    required String title,
    required List<T> items,
    Widget? prefixIcon,
    Widget? leading,
    Widget? trailing,
    Widget? separator,
    required T? selectedItem,
    OnItemSelectedCallback<T>? onSelected,
    OnFilterTextChanged<T>? onFilterTextChanged,
    FormFieldValidator<String>? validator,
    bool required = false,
  }) {
    return SelectedField._(
      delegate: SelectedFieldSimpleDelegate<T>(
        title: title,
        items: items,
        labelParser: (item) => item.toString(),
        leading: leading,
        trailing: trailing,
        selectedItem: selectedItem,
        onFilterTextChanged: onFilterTextChanged,
        separator: separator,
      ),
      onSelected: onSelected,
      prefixIcon: prefixIcon,
      validator: validator,
      required: required,
    );
  }

  factory SelectedField.custom({
    required String title,
    required List<T> items,
    required WidgetItemBuilder<T> itemBuilder,
    required ItemLabelParser<T> labelParser,
    required T? selectedItem,
    Widget? prefixIcon,
    Widget? separator,
    OnItemSelectedCallback<T>? onSelected,
    OnFilterTextChanged<T>? onFilterTextChanged,
    FormFieldValidator<String>? validator,
    bool required = false,
  }) {
    return SelectedField._(
      delegate: SelectedFieldBuilderDelegate<T>(
        title: title,
        items: items,
        itemBuilder: itemBuilder,
        labelParser: labelParser,
        selectedItem: selectedItem,
        onFilterTextChanged: onFilterTextChanged,
        separator: separator,
      ),
      onSelected: onSelected,
      prefixIcon: prefixIcon,
      validator: validator,
      required: required,
    );
  }

  @override
  State<SelectedField<T>> createState() => _SelectedFieldState<T>();
}

class _SelectedFieldState<T> extends State<SelectedField<T>> {
  late final _tecSelectedItem = TextEditingController();

  @override
  void initState() {
    _tecSelectedItem.text = _selectedItemValue;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SelectedField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget._delegate.selectedItem != widget._delegate.selectedItem) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _tecSelectedItem.text = _selectedItemValue;
      });
    }
  }

  @override
  void dispose() {
    _tecSelectedItem.dispose();
    super.dispose();
  }

  String get _selectedItemValue {
    return widget._delegate.selectedItem != null
        ? widget._delegate.labelParser(widget._delegate.selectedItem as T)
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: _tecSelectedItem,
      minLines: 1,
      maxLines: 2,
      enabled: widget._delegate.items.isNotEmpty,
      validator: (text) {
        if (widget._required && (text == null || text.isEmpty)) {
          return '${widget._delegate.title} is required!';
        }
        return widget._validator?.call(text);
      },
      decoration: InputDecoration(
        label: Text.rich(
          TextSpan(text: widget._delegate.title, children: [
            if (widget._required)
              const TextSpan(
                style: TextStyle(color: Colors.red),
                text: ' *',
              ),
          ]),
        ),
        suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
        prefixIcon: widget._prefixIcon,
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (widget._delegate.items.isNotEmpty) {
          showSelectedBottomSheet<T>(
            context,
            widget._delegate,
            onSelected: widget._onSelected,
          );
        }
      },
    );
  }
}
