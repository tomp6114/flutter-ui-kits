import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_kits/features/catalog/domain/entities/catalog_component.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';

class ComponentDetailPage extends StatelessWidget {
  final CatalogComponent component;

  const ComponentDetailPage({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(component.name),
        actions: [
          TextButton.icon(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: component.importPath));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Import path copied!')),
              );
            },
            icon: const Icon(Icons.copy_rounded, size: 18),
            label: const Text('Copy Import'),
          ),
          const SizedBox(width: AppSpacing.md),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(title: 'Live Preview', icon: Icons.visibility_outlined),
            const SizedBox(height: AppSpacing.lg),
            _PreviewGrid(component: component),
            const SizedBox(height: AppSpacing.xxl),
            const _SectionHeader(title: 'Usage', icon: Icons.code_rounded),
            const SizedBox(height: AppSpacing.md),
            _CodeSnippet(code: component.importPath),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _PreviewGrid extends StatelessWidget {
  final CatalogComponent component;

  const _PreviewGrid({required this.component});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PreviewCard(label: 'Light Context', brightness: Brightness.light, component: component),
        const SizedBox(height: AppSpacing.lg),
        _PreviewCard(label: 'Dark Context', brightness: Brightness.dark, component: component),
      ],
    );
  }
}

class _PreviewCard extends StatelessWidget {
  final String label;
  final Brightness brightness;
  final CatalogComponent component;

  const _PreviewCard({
    required this.label,
    required this.brightness,
    required this.component,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ),
          const Divider(height: 1),
          Container(
            height: 250,
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.xl),
            color: isDark ? const Color(0xFF121212) : const Color(0xFFF9FAFB),
            child: Theme(
              data: isDark ? ThemeData.dark() : ThemeData.light(),
              child: Center(child: component.preview),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeSnippet extends StatelessWidget {
  final String code;

  const _CodeSnippet({required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        code,
        style: const TextStyle(color: Color(0xFF9CDCFE), fontFamily: 'monospace', fontSize: 13),
      ),
    );
  }
}
