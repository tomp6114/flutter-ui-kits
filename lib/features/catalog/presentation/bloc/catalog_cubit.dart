import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_kits/features/catalog/presentation/bloc/catalog_state.dart';
import 'package:flutter_ui_kits/features/catalog/domain/entities/catalog_component.dart';

class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit() : super(const CatalogState());

  void initialize(List<CatalogCategory> categories) {
    emit(state.copyWith(
      categories: categories,
      allComponents: categories.expand((c) => c.components).toList(),
    ));
  }

  void updateSearch(String query) {
    emit(state.copyWith(searchQuery: query, selectedCategory: null));
  }

  void selectCategory(CatalogCategory? category) {
    emit(state.copyWith(selectedCategory: category, searchQuery: ''));
  }
}
