import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_typography.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/primary_button.dart';
import 'package:flutter_ui_kits/shared/widgets/inputs/otp_input.dart';

/// A premium OTP screen pattern providing verification layouts and timers natively.
class OTPScreenKit extends StatefulWidget {
  final String email;
  final VoidCallback onVerify;
  final VoidCallback onResend;

  const OTPScreenKit({
    super.key,
    required this.email,
    required this.onVerify,
    required this.onResend,
  });

  @override
  State<OTPScreenKit> createState() => _OTPScreenKitState();
}

class _OTPScreenKitState extends State<OTPScreenKit> {
  int _timerSeconds = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() => _timerSeconds = 30);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() => _timerSeconds--);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Verify Account',
                style: AppTypography.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'We sent a 6-digit code to ${widget.email}',
                style: AppTypography.textTheme.bodyLarge?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: AppSpacing.xxxl),
              
              OtpInput(length: 6, onCompleted: (otp) {}),
              const SizedBox(height: AppSpacing.xxl),
              
              PrimaryButton(
                label: 'Verify Account',
                onPressed: widget.onVerify,
              ),
              const SizedBox(height: AppSpacing.xl),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Didn't receive the code?"),
                  TextButton(
                    onPressed: _timerSeconds == 0 ? () {
                      _startTimer();
                      widget.onResend();
                    } : null,
                    child: Text(_timerSeconds == 0 ? 'Resend' : 'Resend in ${_timerSeconds}s'),
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
