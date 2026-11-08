import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends ChangeNotifier {
  static final LanguageController instance = LanguageController._internal();

  LanguageController._internal();

  static const String _prefKey = 'selected_language';

  Locale _locale = const Locale('en');

  Locale get locale => _locale;
  bool get isUrdu => _locale.languageCode == 'ur';
  String get languageCode => _locale.languageCode;

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLang = prefs.getString(_prefKey);
      if (savedLang != null && (savedLang == 'ur' || savedLang == 'en')) {
        _locale = Locale(savedLang);
        notifyListeners();
      }
    } catch (_) {
      // Fallback to default English
    }
  }

  Future<void> setLocale(Locale newLocale) async {
    if (_locale == newLocale) return;
    _locale = newLocale;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefKey, newLocale.languageCode);
    } catch (_) {}
  }

  Future<void> toggleLanguage() async {
    if (isUrdu) {
      await setLocale(const Locale('en'));
    } else {
      await setLocale(const Locale('ur'));
    }
  }
}
