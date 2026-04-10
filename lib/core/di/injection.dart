import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_ui_kits/core/di/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  preferRelativeImports: true, // default
)
void configureDependencies() => getIt.init();
