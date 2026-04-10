import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_ui_kits/features/catalog/presentation/pages/catalog_page.dart';
import 'package:flutter_ui_kits/features/catalog/presentation/pages/component_detail_page.dart';
import 'package:flutter_ui_kits/features/catalog/domain/entities/catalog_component.dart';


class AppRoutes {
  static const String root = '/';
  static const String catalog = '/catalog';
  static const String componentDetail = '/component/:id';
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.root,
  routes: [
    GoRoute(
      path: AppRoutes.root,
      builder: (context, state) => const CatalogPage(),
    ),
    GoRoute(
      path: AppRoutes.componentDetail,
      builder: (context, state) {
        final component = state.extra as CatalogComponent;
        return ComponentDetailPage(component: component);
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(child: Text('Route not found: ${state.uri}')),
  ),
);
