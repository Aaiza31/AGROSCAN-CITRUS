import 'package:flutter_test/flutter_test.dart';
import 'package:agro_scan/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('AgroScan app starts successfully', (WidgetTester tester) async {
    // Start the AgroScan application.
    await tester.pumpWidget(const AgroScanApp());

    // Verify that the application starts.
    expect(find.byType(AgroScanApp), findsOneWidget);

    // Advance time past the splash screen timer
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });
}
