import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_kits/main.dart';
import 'package:flutter_ui_kits/core/di/injection.dart';

void main() {
  testWidgets('Catalog App smoke test', (tester) async {
    // Initialize DI for the test environment
    configureDependencies();
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the catalog title is present
    expect(find.textContaining('UI Kit Showcase'), findsOneWidget);
  });
}
