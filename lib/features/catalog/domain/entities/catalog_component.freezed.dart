// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_component.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CatalogComponent {

 String get name; String get category; String get importPath; Widget get preview; Widget? get controls;
/// Create a copy of CatalogComponent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogComponentCopyWith<CatalogComponent> get copyWith => _$CatalogComponentCopyWithImpl<CatalogComponent>(this as CatalogComponent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogComponent&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.importPath, importPath) || other.importPath == importPath)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.controls, controls) || other.controls == controls));
}


@override
int get hashCode => Object.hash(runtimeType,name,category,importPath,preview,controls);

@override
String toString() {
  return 'CatalogComponent(name: $name, category: $category, importPath: $importPath, preview: $preview, controls: $controls)';
}


}

/// @nodoc
abstract mixin class $CatalogComponentCopyWith<$Res>  {
  factory $CatalogComponentCopyWith(CatalogComponent value, $Res Function(CatalogComponent) _then) = _$CatalogComponentCopyWithImpl;
@useResult
$Res call({
 String name, String category, String importPath, Widget preview, Widget? controls
});




}
/// @nodoc
class _$CatalogComponentCopyWithImpl<$Res>
    implements $CatalogComponentCopyWith<$Res> {
  _$CatalogComponentCopyWithImpl(this._self, this._then);

  final CatalogComponent _self;
  final $Res Function(CatalogComponent) _then;

/// Create a copy of CatalogComponent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? category = null,Object? importPath = null,Object? preview = null,Object? controls = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,importPath: null == importPath ? _self.importPath : importPath // ignore: cast_nullable_to_non_nullable
as String,preview: null == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as Widget,controls: freezed == controls ? _self.controls : controls // ignore: cast_nullable_to_non_nullable
as Widget?,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogComponent].
extension CatalogComponentPatterns on CatalogComponent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogComponent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogComponent() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogComponent value)  $default,){
final _that = this;
switch (_that) {
case _CatalogComponent():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogComponent value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogComponent() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String category,  String importPath,  Widget preview,  Widget? controls)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogComponent() when $default != null:
return $default(_that.name,_that.category,_that.importPath,_that.preview,_that.controls);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String category,  String importPath,  Widget preview,  Widget? controls)  $default,) {final _that = this;
switch (_that) {
case _CatalogComponent():
return $default(_that.name,_that.category,_that.importPath,_that.preview,_that.controls);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String category,  String importPath,  Widget preview,  Widget? controls)?  $default,) {final _that = this;
switch (_that) {
case _CatalogComponent() when $default != null:
return $default(_that.name,_that.category,_that.importPath,_that.preview,_that.controls);case _:
  return null;

}
}

}

/// @nodoc


class _CatalogComponent implements CatalogComponent {
  const _CatalogComponent({required this.name, required this.category, required this.importPath, required this.preview, this.controls});
  

@override final  String name;
@override final  String category;
@override final  String importPath;
@override final  Widget preview;
@override final  Widget? controls;

/// Create a copy of CatalogComponent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogComponentCopyWith<_CatalogComponent> get copyWith => __$CatalogComponentCopyWithImpl<_CatalogComponent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogComponent&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.importPath, importPath) || other.importPath == importPath)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.controls, controls) || other.controls == controls));
}


@override
int get hashCode => Object.hash(runtimeType,name,category,importPath,preview,controls);

@override
String toString() {
  return 'CatalogComponent(name: $name, category: $category, importPath: $importPath, preview: $preview, controls: $controls)';
}


}

/// @nodoc
abstract mixin class _$CatalogComponentCopyWith<$Res> implements $CatalogComponentCopyWith<$Res> {
  factory _$CatalogComponentCopyWith(_CatalogComponent value, $Res Function(_CatalogComponent) _then) = __$CatalogComponentCopyWithImpl;
@override @useResult
$Res call({
 String name, String category, String importPath, Widget preview, Widget? controls
});




}
/// @nodoc
class __$CatalogComponentCopyWithImpl<$Res>
    implements _$CatalogComponentCopyWith<$Res> {
  __$CatalogComponentCopyWithImpl(this._self, this._then);

  final _CatalogComponent _self;
  final $Res Function(_CatalogComponent) _then;

/// Create a copy of CatalogComponent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? category = null,Object? importPath = null,Object? preview = null,Object? controls = freezed,}) {
  return _then(_CatalogComponent(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,importPath: null == importPath ? _self.importPath : importPath // ignore: cast_nullable_to_non_nullable
as String,preview: null == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as Widget,controls: freezed == controls ? _self.controls : controls // ignore: cast_nullable_to_non_nullable
as Widget?,
  ));
}


}

/// @nodoc
mixin _$CatalogCategory {

 String get name; IconData get icon; List<CatalogComponent> get components;
/// Create a copy of CatalogCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogCategoryCopyWith<CatalogCategory> get copyWith => _$CatalogCategoryCopyWithImpl<CatalogCategory>(this as CatalogCategory, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogCategory&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&const DeepCollectionEquality().equals(other.components, components));
}


@override
int get hashCode => Object.hash(runtimeType,name,icon,const DeepCollectionEquality().hash(components));

@override
String toString() {
  return 'CatalogCategory(name: $name, icon: $icon, components: $components)';
}


}

/// @nodoc
abstract mixin class $CatalogCategoryCopyWith<$Res>  {
  factory $CatalogCategoryCopyWith(CatalogCategory value, $Res Function(CatalogCategory) _then) = _$CatalogCategoryCopyWithImpl;
@useResult
$Res call({
 String name, IconData icon, List<CatalogComponent> components
});




}
/// @nodoc
class _$CatalogCategoryCopyWithImpl<$Res>
    implements $CatalogCategoryCopyWith<$Res> {
  _$CatalogCategoryCopyWithImpl(this._self, this._then);

  final CatalogCategory _self;
  final $Res Function(CatalogCategory) _then;

/// Create a copy of CatalogCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? icon = null,Object? components = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData,components: null == components ? _self.components : components // ignore: cast_nullable_to_non_nullable
as List<CatalogComponent>,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogCategory].
extension CatalogCategoryPatterns on CatalogCategory {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogCategory() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogCategory value)  $default,){
final _that = this;
switch (_that) {
case _CatalogCategory():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogCategory value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogCategory() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  IconData icon,  List<CatalogComponent> components)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogCategory() when $default != null:
return $default(_that.name,_that.icon,_that.components);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  IconData icon,  List<CatalogComponent> components)  $default,) {final _that = this;
switch (_that) {
case _CatalogCategory():
return $default(_that.name,_that.icon,_that.components);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  IconData icon,  List<CatalogComponent> components)?  $default,) {final _that = this;
switch (_that) {
case _CatalogCategory() when $default != null:
return $default(_that.name,_that.icon,_that.components);case _:
  return null;

}
}

}

/// @nodoc


class _CatalogCategory implements CatalogCategory {
  const _CatalogCategory({required this.name, required this.icon, required final  List<CatalogComponent> components}): _components = components;
  

@override final  String name;
@override final  IconData icon;
 final  List<CatalogComponent> _components;
@override List<CatalogComponent> get components {
  if (_components is EqualUnmodifiableListView) return _components;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_components);
}


/// Create a copy of CatalogCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogCategoryCopyWith<_CatalogCategory> get copyWith => __$CatalogCategoryCopyWithImpl<_CatalogCategory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogCategory&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&const DeepCollectionEquality().equals(other._components, _components));
}


@override
int get hashCode => Object.hash(runtimeType,name,icon,const DeepCollectionEquality().hash(_components));

@override
String toString() {
  return 'CatalogCategory(name: $name, icon: $icon, components: $components)';
}


}

/// @nodoc
abstract mixin class _$CatalogCategoryCopyWith<$Res> implements $CatalogCategoryCopyWith<$Res> {
  factory _$CatalogCategoryCopyWith(_CatalogCategory value, $Res Function(_CatalogCategory) _then) = __$CatalogCategoryCopyWithImpl;
@override @useResult
$Res call({
 String name, IconData icon, List<CatalogComponent> components
});




}
/// @nodoc
class __$CatalogCategoryCopyWithImpl<$Res>
    implements _$CatalogCategoryCopyWith<$Res> {
  __$CatalogCategoryCopyWithImpl(this._self, this._then);

  final _CatalogCategory _self;
  final $Res Function(_CatalogCategory) _then;

/// Create a copy of CatalogCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? icon = null,Object? components = null,}) {
  return _then(_CatalogCategory(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData,components: null == components ? _self._components : components // ignore: cast_nullable_to_non_nullable
as List<CatalogComponent>,
  ));
}


}

// dart format on
