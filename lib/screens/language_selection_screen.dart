import 'package:flutter/material.dart';

import '../localization/app_strings.dart';
import '../services/language_controller.dart';
import 'home_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  final bool isFromSettings;

  const LanguageSelectionScreen({
    super.key,
    this.isFromSettings = false,
  });

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  late String _selectedCode;

  @override
  void initState() {
    super.initState();
    _selectedCode = LanguageController.instance.languageCode;
  }

  void _onSelect(String code) {
    setState(() {
      _selectedCode = code;
    });
  }

  Future<void> _proceed() async {
    await LanguageController.instance.setLocale(Locale(_selectedCode));

    if (!mounted) return;

    if (widget.isFromSettings) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUrduSelected = _selectedCode == 'ur';
    final currentCode = _selectedCode;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF2DB),
      appBar: widget.isFromSettings
          ? AppBar(
              backgroundColor: const Color(0xFFFFF2DB),
              elevation: 0,
              iconTheme: const IconThemeData(color: Color(0xFF185C37)),
              title: Text(
                AppStrings.selectLanguage(currentCode),
                style: const TextStyle(
                  color: Color(0xFF185C37),
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Logo / Icon header
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32).withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.language_rounded,
                    size: 50,
                    color: Color(0xFF185C37),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Title
              Text(
                isUrduSelected ? 'زبان منتخب کریں' : 'Select Language',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF185C37),
                ),
              ),

              const SizedBox(height: 10),

              // Subtitle
              Text(
                isUrduSelected
                    ? 'ایپ کے استعمال کے لیے اپنی پسندیدہ زبان منتخب کریں'
                    : 'Choose your preferred language to continue',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF555555),
                ),
              ),

              const SizedBox(height: 35),

              // Option 1: English
              _buildLanguageCard(
                title: 'English',
                subtitle: 'English Language',
                code: 'en',
                badgeText: 'EN',
                isSelected: _selectedCode == 'en',
              ),

              const SizedBox(height: 16),

              // Option 2: Urdu
              _buildLanguageCard(
                title: 'اردو',
                subtitle: 'اردو زبان (قومی زبان)',
                code: 'ur',
                badgeText: 'اردو',
                isSelected: _selectedCode == 'ur',
              ),

              const Spacer(),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _proceed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    isUrduSelected ? 'آگے بڑھیں' : 'Continue',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageCard({
    required String title,
    required String subtitle,
    required String code,
    required String badgeText,
    required bool isSelected,
  }) {
    const primaryColor = Color(0xFF2E7D32);

    return InkWell(
      onTap: () => _onSelect(code),
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade300,
            width: isSelected ? 2.2 : 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          children: [
            // Badge
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? primaryColor.withValues(alpha: 0.12)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                badgeText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isSelected ? primaryColor : Colors.grey.shade700,
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? const Color(0xFF185C37)
                          : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: isSelected
                          ? const Color(0xFF2E7D32)
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            // Radio Indicator
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? primaryColor : Colors.grey.shade400,
                  width: 2,
                ),
                color: isSelected ? primaryColor : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
