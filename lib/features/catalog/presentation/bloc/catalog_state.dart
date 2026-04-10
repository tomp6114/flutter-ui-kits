import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_ui_kits/features/catalog/domain/entities/catalog_component.dart';

part 'catalog_state.freezed.dart';

@freezed
abstract class CatalogState with _$CatalogState {
  const factory CatalogState({
    @Default([]) List<CatalogCategory> categories,
    @Default([]) List<CatalogComponent> allComponents,
    @Default('') String searchQuery,
    CatalogCategory? selectedCategory,
    @Default(false) bool isLoading,
  }) = _CatalogState;
}
