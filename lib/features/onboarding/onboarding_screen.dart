import 'package:flutter/material.dart';
import 'package:flutter_ui_kits/core/theme/app_colors.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/theme/app_typography.dart';
import 'package:flutter_ui_kits/shared/widgets/buttons/primary_button.dart';

class OnboardingPage {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

/// A premium onboarding screen providing PageView navigation natively.
class OnboardingScreen extends StatefulWidget {
  final List<OnboardingPage> pages;
  final VoidCallback onFinish;
  final VoidCallback onSkip;

  const OnboardingScreen({
    super.key,
    required this.pages,
    required this.onFinish,
    required this.onSkip,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < widget.pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      widget.onFinish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: widget.pages.length,
            itemBuilder: (context, index) {
              final page = widget.pages[index];
              return Container(
                padding: const EdgeInsets.all(AppSpacing.xl),
                color: page.color.withValues(alpha: 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(page.icon, size: 120, color: page.color),
                    const SizedBox(height: AppSpacing.xxl),
                    Text(
                      page.title,
                      style: AppTypography.textTheme.headlineLarge?.copyWith(
                        color: AppColors.onSurfaceLight,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      page.description,
                      style: AppTypography.textTheme.bodyLarge?.copyWith(
                        color: AppColors.onSurfaceVariantLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + AppSpacing.md,
            right: AppSpacing.md,
            child: TextButton(
              onPressed: widget.onSkip,
              child: const Text('Skip'),
            ),
          ),
          Positioned(
            bottom: AppSpacing.xxl,
            left: AppSpacing.xl,
            right: AppSpacing.xl,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.pages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? AppColors.primary : AppColors.outlineVariantLight,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                PrimaryButton(
                  label: _currentPage == widget.pages.length - 1 ? 'Get Started' : 'Next',
                  onPressed: _nextPage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
