import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/shared/widgets/inputs/text_field_kit.dart';

/// Simplified Phone field incorporating country dial code picker (mocked flags) + number input.
class PhoneField extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const PhoneField({
    super.key,
    this.label = 'Phone Number',
    this.controller,
    this.validator,
  });

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  String _selectedCode = '+1';

  final List<Map<String, String>> _countryCodes = [
    {'flag': '🇺🇸', 'code': '+1'},
    {'flag': '🇬🇧', 'code': '+44'},
    {'flag': '🇮🇳', 'code': '+91'},
    {'flag': '🇦🇺', 'code': '+61'},
    {'flag': '🇨🇦', 'code': '+1'},
  ];

  @override
  Widget build(BuildContext context) {
    return TextFieldKit(
      label: widget.label,
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: TextInputType.phone,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: AppSpacing.sm, right: AppSpacing.xs),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedCode,
            items: _countryCodes.map((country) {
              return DropdownMenuItem<String>(
                value: country['code'],
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(country['flag']!),
                    const SizedBox(width: 4),
                    Text(country['code']!),
                  ],
                ),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() {
                  _selectedCode = val;
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
