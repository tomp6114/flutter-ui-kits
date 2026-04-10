import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_radius.dart';
import 'package:flutter_ui_kits/core/utils/extensions.dart';

enum LoadingButtonState { idle, loading, success }

/// Morphs into a spinner then checkmark on success.
class LoadingButton extends StatefulWidget {
  final String label;
  final Future<void> Function() onPressed;
  final bool isDisabled;

  const LoadingButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isDisabled = false,
  });

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> with SingleTickerProviderStateMixin {
  LoadingButtonState _state = LoadingButtonState.idle;

  void _handlePress() async {
    if (_state != LoadingButtonState.idle || widget.isDisabled) return;

    setState(() {
      _state = LoadingButtonState.loading;
    });

    try {
      await widget.onPressed();
      if (!mounted) return;
      setState(() {
        _state = LoadingButtonState.success;
      });
      
      // Reset back to idle after a delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _state = LoadingButtonState.idle;
          });
        }
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _state = LoadingButtonState.idle; // Could be error state in real scenario
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isIdle = _state == LoadingButtonState.idle;
    final bool isSuccess = _state == LoadingButtonState.success;
    
    // Width morphing logic
    final double targetWidth = isIdle ? 200.0 : 48.0;

    return IgnorePointer(
      ignoring: !isIdle || widget.isDisabled,
      child: Opacity(
        opacity: widget.isDisabled && isIdle ? 0.5 : 1.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: targetWidth,
          height: 48.0,
          decoration: BoxDecoration(
            color: isSuccess ? context.colorScheme.primary : context.colorScheme.primary,
            borderRadius: BorderRadius.circular(isIdle ? AppRadius.md : 24.0),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _handlePress,
              borderRadius: BorderRadius.circular(isIdle ? AppRadius.md : 24.0),
              child: Center(
                child: _buildContent(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (_state == LoadingButtonState.idle) {
      return Text(
        widget.label,
        key: const ValueKey('idle'),
        style: context.textTheme.labelLarge?.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: context.colorScheme.onPrimary,
        ),
      );
    } else if (_state == LoadingButtonState.loading) {
      return const SizedBox(
        key: ValueKey('loading'),
        width: 24.0,
        height: 24.0,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          color: Colors.white,
        ),
      );
    } else {
      return const Icon(
        Icons.check,
        key: ValueKey('success'),
        color: Colors.white,
      );
    }
  }
}
