import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'clearable_text_form_field.dart';

class TextAreaField extends StatelessWidget {
  const TextAreaField({
    super.key,
    this.controller,
    this.decoration,
    this.labelText,
    this.errorText,
    this.initialValue,
    this.prefixIcon,
    this.onChanged,
    this.onSaved,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.inputFormatters,
    this.validator,
    this.minLines,
    this.maxLines,
    this.required = false,
    this.readOnly = false,
    this.onTap,
  });

  final TextEditingController? controller;
  final InputDecoration? decoration;
  final String? labelText;
  final String? errorText;
  final String? initialValue;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final int? minLines;
  final int? maxLines;
  final bool required;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ClearableTextFormField(
      controller: controller,
      initialValue: initialValue,
      decoration: decoration,
      textCapitalization: textCapitalization,
      keyboardType: TextInputType.multiline,
      minLines: minLines ?? 3,
      maxLines: maxLines ?? 5,
      textAlign: textAlign,
      errorText: errorText,
      required: required,
      maxLength: maxLength,
      labelText: labelText,
      prefixIcon: prefixIcon,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      onTap: onTap,
    );
  }
}
