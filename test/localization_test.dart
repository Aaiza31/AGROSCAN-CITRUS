import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agro_scan/localization/app_strings.dart';
import 'package:agro_scan/models/disease_info.dart';
import 'package:agro_scan/screens/language_selection_screen.dart';
import 'package:agro_scan/services/language_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await LanguageController.instance.setLocale(const Locale('en'));
  });

  group('Localization and LanguageController Tests', () {
    test('Default language is English', () {
      expect(LanguageController.instance.languageCode, equals('en'));
      expect(LanguageController.instance.isUrdu, isFalse);
    });

    test('Language changes to Urdu and notifies listeners', () async {
      await LanguageController.instance.setLocale(const Locale('ur'));
      expect(LanguageController.instance.languageCode, equals('ur'));
      expect(LanguageController.instance.isUrdu, isTrue);
    });

    test('AppStrings return correct English and Urdu texts', () {
      expect(AppStrings.appTitle('en'), equals('AgroScan'));
      expect(AppStrings.appTitle('ur'), equals('ایگرو اسکین'));

      expect(AppStrings.scanPlant('en'), equals('Scan Plant'));
      expect(AppStrings.scanPlant('ur'), equals('کیمرہ سے اسکین کریں'));

      expect(AppStrings.selectLanguage('en'), equals('Select Language'));
      expect(AppStrings.selectLanguage('ur'), equals('زبان منتخب کریں'));
    });

    test('DiseaseDatabase returns localized info for all classes', () {
      final classes = ['Black Spot', 'Canker', 'Greening / HLB', 'Healthy'];

      for (final cls in classes) {
        final enInfo = DiseaseDatabase.getInfo(cls, lang: 'en');
        expect(enInfo, isNotNull);

        final urInfo = DiseaseDatabase.getInfo(cls, lang: 'ur');
        expect(urInfo, isNotNull);
        expect(urInfo!.diseaseName, isNotEmpty);
        expect(urInfo.source, isNotEmpty);
      }

      // Check specific Urdu values for Black Spot
      final bsUr = DiseaseDatabase.getInfo('Black Spot', lang: 'ur')!;
      expect(bsUr.diseaseName, contains('بلیک اسپاٹ'));
      expect(bsUr.stages.first.stageName, equals('ابتدائی مرحلہ'));

      // Check specific Urdu values for Healthy
      final hUr = DiseaseDatabase.getInfo('Healthy', lang: 'ur')!;
      expect(hUr.diseaseName, equals('صحت مند پودا'));
      expect(hUr.routineCare, isNotNull);
      expect(hUr.routineCare!.first.tabName, equals('ہفتہ وار'));
    });

    testWidgets('LanguageSelectionScreen allows selecting language and proceeding',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const LanguageSelectionScreen(isFromSettings: true),
        ),
      );

      // Verify options are visible
      expect(find.text('English'), findsOneWidget);
      expect(find.text('اردو'), findsNWidgets(2));

      // Tap Urdu card
      await tester.tap(find.text('اردو').first);
      await tester.pumpAndSettle();

      // Tap Continue / آگے بڑھیں
      final continueButton = find.byType(ElevatedButton);
      expect(continueButton, findsOneWidget);
      await tester.tap(continueButton);
      await tester.pumpAndSettle();

      // Verify controller updated to Urdu
      expect(LanguageController.instance.languageCode, equals('ur'));
    });
  });
}
