import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class CurrencyTextFormField extends StatefulWidget {
  const CurrencyTextFormField({
    super.key,
    required this.labelText,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.required = false,
    this.validator,
    this.onSaved,
    this.onFocusChanged,
  });

  final String labelText;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final bool required;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFocusChanged;

  @override
  State<CurrencyTextFormField> createState() => _CurrencyTextFormFieldState();
}

class _CurrencyTextFormFieldState extends State<CurrencyTextFormField> {
  late final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _hasFocus = false;
  Timer? _debounce;

  _setCurrencyText(String? currency) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _controller.text = currency ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue ?? '';
    _controller.addListener(() {
      widget.onChanged?.call(_controller.text);
    });
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _hasFocus = true;
        });
      }
      if (!_focusNode.hasFocus && _hasFocus) {
        widget.onFocusChanged?.call(_controller.text);
      }
    });
  }

  @override
  void didUpdateWidget(covariant CurrencyTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue &&
        widget.initialValue != _controller.text) {
      _setCurrencyText(widget.initialValue);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: _controller,
      keyboardType: TextInputType.number,
      enabled: widget.enabled,
      validator: (text) {
        if (widget.required && (text == null || text.isEmpty)) {
          return '${widget.labelText} is required!';
        }
        return widget.validator?.call(text);
      },
      onSaved: widget.onSaved,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FilteringTextInputFormatter.singleLineFormatter,
        CurrencyTextInputFormatter(),
      ],
      decoration: InputDecoration(
        label: Text.rich(
          TextSpan(
            text: widget.labelText,
            children: [
              if (widget.required)
                const TextSpan(
                  style: TextStyle(color: Colors.red),
                  text: ' *',
                ),
            ],
          ),
        ),
        // prefixIcon: const Icon(Icons.attach_money_rounded),
        suffixText: 'MMK',
      ),
    );
  }
}





class CurrencyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text.replaceAll(',', ''));
    final formatter = NumberFormat.simpleCurrency(name: '', decimalDigits: 0);
    String newText = formatter.format(value);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
