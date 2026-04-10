import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_colors.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';
import 'package:flutter_ui_kits/shared/widgets/inputs/text_field_kit.dart';

/// Password field with show/hide toggle and a strength indicator bar natively integrated.
class PasswordField extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const PasswordField({
    super.key,
    this.label = 'Password',
    this.controller,
    this.validator,
    this.onChanged,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  double _strength = 0; // 0.0 to 1.0

  void _calculateStrength(String value) {
    double strength = 0;
    if (value.length > 5) strength += 0.25;
    if (value.length > 8) strength += 0.25;
    if (RegExp(r'[A-Z]').hasMatch(value)) strength += 0.25;
    if (RegExp(r'[0-9!@#\$&*~]').hasMatch(value)) strength += 0.25;
    
    setState(() {
      _strength = strength.clamp(0.0, 1.0);
    });
  }

  Color get _strengthColor {
    if (_strength <= 0.25) return AppColors.errorLight;
    if (_strength <= 0.50) return AppColors.warning;
    if (_strength <= 0.75) return AppColors.info;
    return AppColors.success;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFieldKit(
          label: widget.label,
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: TextInputType.visiblePassword,
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: context.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          onChanged: (val) {
            _calculateStrength(val);
            widget.onChanged?.call(val);
          },
          validator: widget.validator,
        ),
        const SizedBox(height: 8.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: LinearProgressIndicator(
            value: _strength,
            backgroundColor: context.theme.dividerColor,
            color: _strengthColor,
            minHeight: 4.0,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          _strength == 0.0 ? 'Enter a strong password' 
          : _strength <= 0.25 ? 'Weak' 
          : _strength <= 0.75 ? 'Good' 
          : 'Strong',
          style: context.textTheme.labelSmall?.copyWith(color: _strengthColor),
        ),
      ],
    );
  }
}
