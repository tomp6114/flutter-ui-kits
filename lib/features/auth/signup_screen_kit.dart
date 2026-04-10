import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_typography.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/primary_button.dart';
import 'package:flutter_ui_kits/shared/widgets/inputs/text_field_kit.dart';

/// A premium signup screen pattern providing standard registration layouts natively.
class SignupScreenKit extends StatefulWidget {
  final VoidCallback onSignup;
  final VoidCallback onLogin;

  const SignupScreenKit({
    super.key,
    required this.onSignup,
    required this.onLogin,
  });

  @override
  State<SignupScreenKit> createState() => _SignupScreenKitState();
}

class _SignupScreenKitState extends State<SignupScreenKit> {
  bool _obscurePassword = true;
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Create Account',
                style: AppTypography.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Join us and start your journey today',
                style: AppTypography.textTheme.bodyLarge?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: AppSpacing.xxl),
              
              const TextFieldKit(
                label: 'Full Name',
                hint: 'John Doe',
                prefixIcon: Icon(Icons.person_outline),
              ),
              const SizedBox(height: AppSpacing.lg),
              
              const TextFieldKit(
                label: 'Email Address',
                hint: 'name@example.com',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              const SizedBox(height: AppSpacing.lg),
              
              TextFieldKit(
                label: 'Password',
                hint: 'Create a password',
                prefixIcon: const Icon(Icons.lock_outline),
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (val) => setState(() => _agreeToTerms = val ?? false),
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'I agree to the ',
                        children: [
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      style: AppTypography.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              
              PrimaryButton(
                label: 'Sign Up',
                onPressed: _agreeToTerms ? widget.onSignup : null,
              ),
              const SizedBox(height: AppSpacing.xl),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: widget.onLogin,
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
