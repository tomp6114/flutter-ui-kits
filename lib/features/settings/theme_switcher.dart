import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_kits/core/theme/bloc/theme_cubit.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/features/settings/settings_section.dart';

/// A premium theme switcher pattern providing light/dark/system mode toggles natively.
class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    
    return SettingsSection(
      title: 'Appearance',
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(
                value: ThemeMode.light,
                icon: Icon(Icons.light_mode_outlined),
                label: Text('Light'),
              ),
              ButtonSegment(
                value: ThemeMode.system,
                icon: Icon(Icons.settings_brightness_outlined),
                label: Text('System'),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                icon: Icon(Icons.dark_mode_outlined),
                label: Text('Dark'),
              ),
            ],
            selected: {context.watch<ThemeCubit>().state},
            onSelectionChanged: (selection) {
              themeCubit.setThemeMode(selection.first);
            },
            showSelectedIcon: false,
          ),
        ),
      ],
    );
  }
}
