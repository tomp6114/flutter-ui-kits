import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

/// Autocomplete suggestions dropdown bounding cleanly mapping highlighting text safely.
class AutocompleteFieldKit extends StatelessWidget {
  final List<String> options;
  final String hint;
  final ValueChanged<String>? onSelected;

  const AutocompleteFieldKit({
    super.key,
    required this.options,
    this.hint = 'Search...',
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return options.where((option) {
          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: onSelected,
      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onSubmitted: (value) {
            onFieldSubmitted();
          },
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(borderRadius: AppRadius.radiusMd),
            contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            borderRadius: AppRadius.radiusMd,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 200.0,
                maxWidth: context.screenWidth - (AppSpacing.md * 2),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final String option = options.elementAt(index);
                  return InkWell(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Text(option, style: context.textTheme.bodyMedium),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
