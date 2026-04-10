import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_ui_kits/features/catalog/presentation/bloc/catalog_cubit.dart';
import 'package:flutter_ui_kits/features/catalog/presentation/bloc/catalog_state.dart';
import 'package:flutter_ui_kits/features/catalog/domain/entities/catalog_component.dart';
import 'package:flutter_ui_kits/features/catalog/data/datasources/catalog_data_registry.dart';
import 'package:flutter_ui_kits/core/theme/bloc/theme_cubit.dart';
import 'package:flutter_ui_kits/core/theme/app_spacing.dart';
import 'package:flutter_ui_kits/core/router/app_router.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatalogCubit()..initialize(CatalogDataRegistry.categories),
      child: const CatalogView(),
    );
  }
}

class CatalogView extends StatelessWidget {
  const CatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Kit Showcase (BLoC)'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Theme.of(context).brightness == Brightness.dark 
                ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
            onPressed: () => context.read<ThemeCubit>().toggleTheme(context),
          ),
          const SizedBox(width: AppSpacing.md),
        ],
      ),
      body: Row(
        children: [
          if (isWide) const _Sidebar(),
          const Expanded(child: _CatalogContent()),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogCubit, CatalogState>(
      builder: (context, state) {
        return Container(
          width: 250,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(right: BorderSide(color: Theme.of(context).dividerColor)),
          ),
          child: ListView(
            children: [
              _buildSidebarItem(context, 'Home', Icons.home_rounded, null),
              const Divider(height: 1),
              ...state.categories.map((cat) => 
                _buildSidebarItem(context, cat.name, cat.icon, cat)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSidebarItem(BuildContext context, String title, IconData icon, CatalogCategory? category) {
    final cubit = context.read<CatalogCubit>();
    final isSelected = cubit.state.selectedCategory == category;
    return ListTile(
      selected: isSelected,
      leading: Icon(icon, size: 20),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      onTap: () => cubit.selectCategory(category),
    );
  }
}

class _CatalogContent extends StatelessWidget {
  const _CatalogContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogCubit, CatalogState>(
      builder: (context, state) {
        if (state.searchQuery.isEmpty && state.selectedCategory == null) {
          return const _HomeGrid();
        }
        return const _ComponentList();
      },
    );
  }
}

class _HomeGrid extends StatelessWidget {
  const _HomeGrid();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CatalogCubit>();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroHeader(context),
          const SizedBox(height: AppSpacing.xxl),
          TextField(
            onChanged: cubit.updateSearch,
            decoration: InputDecoration(
              hintText: 'Search components...',
              prefixIcon: const Icon(Icons.search_rounded),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cubit.state.categories.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              mainAxisExtent: 160,
              mainAxisSpacing: AppSpacing.lg,
              crossAxisSpacing: AppSpacing.lg,
            ),
            itemBuilder: (context, index) {
              final cat = cubit.state.categories[index];
              return _buildCategoryCard(context, cat);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor.withOpacity(0.7)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('UI Kit Refactored', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          Text('Now powered by Clean Architecture and BLoC.', style: TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, CatalogCategory cat) {
    return InkWell(
      onTap: () => context.read<CatalogCubit>().selectCategory(cat),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(cat.icon, size: 30, color: Theme.of(context).primaryColor),
            const SizedBox(height: AppSpacing.md),
            Text(cat.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _ComponentList extends StatelessWidget {
  const _ComponentList();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CatalogCubit>().state;
    final results = state.searchQuery.isNotEmpty
        ? state.allComponents.where((c) => c.name.toLowerCase().contains(state.searchQuery.toLowerCase())).toList()
        : state.selectedCategory?.components ?? [];

    return Column(
      children: [
        AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => context.read<CatalogCubit>().selectCategory(null),
          ),
          title: Text(state.searchQuery.isNotEmpty ? 'Results' : state.selectedCategory?.name ?? ''),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.xl),
            itemCount: results.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final comp = results[index];
              return ListTile(
                tileColor: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                title: Text(comp.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () => context.push(
                  AppRoutes.componentDetail.replaceFirst(':id', comp.name),
                  extra: comp,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
