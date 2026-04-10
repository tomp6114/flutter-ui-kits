import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_colors.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum TextFieldVariant { outlined, filled, underline }

/// A comprehensive text field kit handling primary input forms.
class TextFieldKit extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final TextFieldVariant variant;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool readOnly;
  final bool autofocus;
  final int maxLines;

  const TextFieldKit({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.variant = TextFieldVariant.outlined,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.onSubmitted,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
  });

  @override
  State<TextFieldKit> createState() => _TextFieldKitState();
}

class _TextFieldKitState extends State<TextFieldKit> {
  InputDecoration _buildDecoration(BuildContext context) {
    final theme = context.theme;

    final baseDecoration = InputDecoration(
      labelText: widget.label,
      hintText: widget.hint,
      helperText: widget.helperText,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon,
      labelStyle: const TextStyle(fontWeight: FontWeight.w500),
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
    );

    switch (widget.variant) {
      case TextFieldVariant.outlined:
        return baseDecoration.copyWith(
          border: const OutlineInputBorder(borderRadius: AppRadius.radiusMd),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppRadius.radiusMd,
            borderSide: BorderSide(color: context.colorScheme.outlineVariant ?? AppColors.dividerLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppRadius.radiusMd,
            borderSide: BorderSide(color: context.colorScheme.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: AppRadius.radiusMd,
            borderSide: BorderSide(color: context.colorScheme.error),
          ),
        );
      case TextFieldVariant.filled:
        return baseDecoration.copyWith(
          filled: true,
          fillColor: context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          border: const OutlineInputBorder(borderRadius: AppRadius.radiusMd, borderSide: BorderSide.none),
          enabledBorder: const OutlineInputBorder(borderRadius: AppRadius.radiusMd, borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppRadius.radiusMd,
            borderSide: BorderSide(color: context.colorScheme.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: AppRadius.radiusMd,
            borderSide: BorderSide(color: context.colorScheme.error, width: 2),
          ),
        );
      case TextFieldVariant.underline:
        return baseDecoration.copyWith(
          border: const UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: context.colorScheme.outlineVariant ?? AppColors.dividerLight),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: context.colorScheme.primary, width: 2),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: context.colorScheme.error, width: 2),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      maxLines: widget.maxLines,
      style: context.textTheme.bodyLarge,
      decoration: _buildDecoration(context),
    );
  }
}
