import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_component.freezed.dart';

@freezed
abstract class CatalogComponent with _$CatalogComponent {
  const factory CatalogComponent({
    required String name,
    required String category,
    required String importPath,
    required Widget preview,
    Widget? controls,
  }) = _CatalogComponent;
}

@freezed
abstract class CatalogCategory with _$CatalogCategory {
  const factory CatalogCategory({
    required String name,
    required IconData icon,
    required List<CatalogComponent> components,
  }) = _CatalogCategory;
}
