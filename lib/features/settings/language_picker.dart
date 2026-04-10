import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_typography.dart';
import 'package:flutter_ui_kits/features/settings/settings_section.dart';

class AppLanguage {
  final String name;
  final String nativeName;
  final String flag;
  final String code;

  AppLanguage({
    required this.name,
    required this.nativeName,
    required this.flag,
    required this.code,
  });
}

/// A premium language picker pattern providing flag + name selection natively.
class LanguagePicker extends StatefulWidget {
  final List<AppLanguage> languages;
  final String selectedCode;
  final Function(AppLanguage) onLanguageSelected;

  const LanguagePicker({
    super.key,
    required this.languages,
    required this.selectedCode,
    required this.onLanguageSelected,
  });

  @override
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Language',
      children: widget.languages.map((lang) {
        final isSelected = lang.code == widget.selectedCode;
        return ListTile(
          onTap: () => widget.onLanguageSelected(lang),
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          leading: Text(lang.flag, style: const TextStyle(fontSize: 24)),
          title: Text(
            lang.name,
            style: AppTypography.textTheme.bodyLarge?.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          subtitle: Text(lang.nativeName, style: AppTypography.textTheme.bodySmall),
          trailing: isSelected
              ? Icon(Icons.check_circle, color: Theme.of(context).primaryColor)
              : null,
        );
      }).toList(),
    );
  }
}
