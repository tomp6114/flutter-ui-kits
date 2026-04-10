import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_typography.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/primary_button.dart';
import 'package:flutter_ui_kits/shared/widgets/inputs/text_field_kit.dart';

/// A premium forgot password screen pattern providing email recovery and success state natively.
class ForgotPasswordKit extends StatefulWidget {
  final Function(String) onSendLink;
  final VoidCallback onBackToLogin;

  const ForgotPasswordKit({
    super.key,
    required this.onSendLink,
    required this.onBackToLogin,
  });

  @override
  State<ForgotPasswordKit> createState() => _ForgotPasswordKitState();
}

class _ForgotPasswordKitState extends State<ForgotPasswordKit> {
  bool _isSuccess = false;
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (_emailController.text.isNotEmpty) {
      widget.onSendLink(_emailController.text);
      setState(() => _isSuccess = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isSuccess) return _buildSuccessState();

    return Scaffold(
      appBar: AppBar(leading: BackButton(onPressed: widget.onBackToLogin)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Forgot Password?',
                style: AppTypography.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                "Enter your email address and we'll send you a link to reset your password.",
                style: AppTypography.textTheme.bodyLarge?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: AppSpacing.xxxl),
              
              TextFieldKit(
                controller: _emailController,
                label: 'Email Address',
                hint: 'name@example.com',
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: AppSpacing.xxl),
              
              PrimaryButton(
                label: 'Send Reset Link',
                onPressed: _handleSend,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessState() {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Text(
                'Check Your Email',
                style: AppTypography.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                "We've sent a password reset link to ${_emailController.text}",
                textAlign: TextAlign.center,
                style: AppTypography.textTheme.bodyLarge?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: AppSpacing.xxxl),
              PrimaryButton(
                label: 'Back to Login',
                onPressed: widget.onBackToLogin,
              ),
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: () => setState(() => _isSuccess = false),
                child: const Text('Try another email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
