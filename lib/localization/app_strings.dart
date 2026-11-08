class AppStrings {
  static bool isUrdu(String langCode) => langCode == 'ur';

  // Language Selection Screen
  static String selectLanguage(String lang) =>
      isUrdu(lang) ? 'زبان منتخب کریں' : 'Select Language';

  static String selectLanguageSubtitle(String lang) => isUrdu(lang)
      ? 'ایپ استعمال کرنے کے لیے اپنی پسندیدہ زبان کا انتخاب کریں'
      : 'Choose your preferred language to continue';

  static String english(String lang) => 'English';

  static String urdu(String lang) => 'اردو';

  static String englishSubtitle(String lang) =>
      isUrdu(lang) ? 'انگریزی' : 'English language';

  static String urduSubtitle(String lang) =>
      isUrdu(lang) ? 'اردو زبان' : 'Urdu language';

  static String continueButton(String lang) =>
      isUrdu(lang) ? 'آگے بڑھیں' : 'Continue';

  static String changeLanguage(String lang) =>
      isUrdu(lang) ? 'زبان تبدیل کریں' : 'Change Language';

  // Onboarding Screen
  static String next(String lang) => isUrdu(lang) ? 'اگلا' : 'Next';

  static String startNow(String lang) =>
      isUrdu(lang) ? 'ابھی شروع کریں' : 'Start Now';

  // Home Screen
  static String appTitle(String lang) =>
      isUrdu(lang) ? 'ایگرو اسکین' : 'AgroScan';

  static String homeTitle(String lang) => isUrdu(lang)
      ? 'سٹرس کی بیماری کی تشخیص'
      : 'Detect Citrus Disease';

  static String homeSubtitle(String lang) => isUrdu(lang)
      ? 'سٹرس کے پودے کی تصویر لیں یا گیلری سے اپلوڈ کر کے بیماری کی فوری شناخت کریں۔'
      : 'Capture a citrus plant or upload an image to identify its disease.';

  static String plantPlaceholder(String lang) => isUrdu(lang)
      ? 'آپ کے پودے کی تصویر یہاں ظاہر ہوگی'
      : 'Your plant image will appear here';

  static String removeImage(String lang) =>
      isUrdu(lang) ? 'تصویر ہٹائیں' : 'Remove Image';

  static String scanPlant(String lang) =>
      isUrdu(lang) ? 'کیمرہ سے اسکین کریں' : 'Scan Plant';

  static String uploadFromGallery(String lang) =>
      isUrdu(lang) ? 'گیلری سے تصویر لیں' : 'Upload from Gallery';

  static String scanDisease(String lang) =>
      isUrdu(lang) ? 'بیماری کی تشخیص کریں' : 'Scan Disease';

  static String analyzing(String lang) =>
      isUrdu(lang) ? 'تجزیہ ہو رہا ہے...' : 'Analyzing...';

  static String imageSelectionFailed(String lang, dynamic e) => isUrdu(lang)
      ? 'تصویر منتخب کرنے میں خرابی: $e'
      : 'Image selection failed: $e';

  static String detectionFailed(String lang, dynamic e) =>
      isUrdu(lang) ? 'تشخیص میں خرابی: $e' : 'Detection failed: $e';

  // Dialog & Detection Result
  static String diseaseDetectionResult(String lang) =>
      isUrdu(lang) ? 'بیماری کی تشخیص کا نتیجہ' : 'Disease Detection Result';

  static String predictionConfidence(String lang) =>
      isUrdu(lang) ? 'درستگی کا تناسب' : 'Prediction Confidence';

  static String aiDisclaimer(String lang) => isUrdu(lang)
      ? 'مصنوعی ذہانت (AI) کی تشخیص ایک ابتدائی جائزہ ہے۔ ادویات یا علاج سے پہلے تسلی ضرور کریں۔'
      : 'AI prediction is an initial assessment. Confirm the diagnosis before applying treatment.';

  static String close(String lang) => isUrdu(lang) ? 'بند کریں' : 'Close';

  static String viewDetails(String lang) =>
      isUrdu(lang) ? 'تفصیلات دیکھیں' : 'View Details';

  static String detectionResultCardTitle(String lang) =>
      isUrdu(lang) ? 'تشخیص کا نتیجہ' : 'Detection Result';

  static String confidenceLabel(String lang) =>
      isUrdu(lang) ? 'درستگی: ' : 'Confidence: ';

  static String footerText(String lang) => isUrdu(lang)
      ? 'ایگرو اسکین - سٹرس | سمارٹ سٹرس نگہداشت'
      : 'AgroScan-Citrus | Smart Citrus Care';

  // Disease Detail Screen
  static String overviewTab(String lang) => isUrdu(lang) ? 'جائزہ' : 'Overview';

  static String spreadTab(String lang) => isUrdu(lang) ? 'پھیلاؤ' : 'Spread';

  static String preventionTab(String lang) =>
      isUrdu(lang) ? 'بچاؤ کی تدابیر' : 'Prevention';

  static String treatmentTab(String lang) =>
      isUrdu(lang) ? 'طریقہ علاج' : 'Treatment';

  static String weeklyTab(String lang) =>
      isUrdu(lang) ? 'ہفتہ وار' : 'Weekly';

  static String monthlyTab(String lang) =>
      isUrdu(lang) ? 'ماہانہ' : 'Monthly';

  static String seasonalTab(String lang) =>
      isUrdu(lang) ? 'موسمی' : 'Seasonal';

  static String healthyTitle(String lang) => isUrdu(lang)
      ? 'آپ کا سٹرس کا درخت بالکل صحت مند ہے! 🎉'
      : 'Your citrus tree looks HEALTHY! 🎉';

  static String healthyDesc(String lang) => isUrdu(lang)
      ? 'کوئی بیماری نہیں پائی گئی۔ اپنے درخت کو سارا سال محفوظ رکھنے کے لیے اوپر دیئے گئے نگہداشت کے مراحل پر عمل کریں۔'
      : 'No disease detected. Follow the routine care tabs above to keep your tree protected year-round.';

  static String overviewSectionTitle(String lang) =>
      isUrdu(lang) ? 'عمومی تفصیلات' : 'Overview';

  static String typeLabel(String lang) =>
      isUrdu(lang) ? 'بیماری کی قسم' : 'Type';

  static String affectsLabel(String lang) =>
      isUrdu(lang) ? 'متاثرہ حصے' : 'Affects';

  static String riskLabel(String lang) =>
      isUrdu(lang) ? 'خطرات' : 'Risk';

  static String severityLabel(String lang) =>
      isUrdu(lang) ? 'شدت' : 'Severity';

  static String foundInPkLabel(String lang) =>
      isUrdu(lang) ? 'پاکستان میں علاقہ' : 'Found in PK';

  static String dataSourceLabel(String lang) =>
      isUrdu(lang) ? 'معلومات کا ماخذ' : 'Data Source';

  static String hlbWarning(String lang) => isUrdu(lang)
      ? 'اس بیماری کا کوئی مکمل علاج موجود نہیں ہے۔ ادویات کا مقصد درخت کو بچانا اور دوسرے درختوں میں پھیلاؤ روکنا ہے۔'
      : 'No complete cure exists. Treatment focuses on suppressing the disease and stopping it from spreading to other trees.';

  static String tabsNavHintTitle(String lang) =>
      isUrdu(lang) ? 'اوپر دیئے گئے ٹیبز دیکھیں' : 'Navigate the tabs above';

  static String tabsNavHintDesc(String lang) => isUrdu(lang)
      ? 'پھیلاؤ → بیماری کیسے پھیلتی ہے\nبچاؤ → بچاؤ کے حفاظتی اقدامات\nعلاج → مرحلہ وار اسپرے اور ادویات'
      : 'Spread → How disease reaches your tree\nPrevention → Steps to stop it\nTreatment → Stage-by-stage spray guide';

  static String howItSpreadsTitle(String lang) =>
      isUrdu(lang) ? 'بیماری کا پھیلاؤ' : 'How It Spreads';

  static String spreadSubtitle(String lang) => isUrdu(lang)
      ? 'پھیلاؤ کو سمجھ کر اس کا سدباب کرنا آسان ہوتا ہے'
      : 'Understanding spread helps you stop it';

  static String spreadDetailsTitle(String lang) =>
      isUrdu(lang) ? 'پھیلاؤ کی تفاصیل' : 'Spread Details';

  static String preventionTitle(String lang) =>
      isUrdu(lang) ? 'حفاظتی تدابیر' : 'Prevention';

  static String preventionSubtitle(String lang) => isUrdu(lang)
      ? 'پاکستان کے لیے مخصوص اقدامات — محکمہ زراعت پنجاب / سی آر آئی سرگودھا'
      : 'Pakistan-specific steps — AgriPunjab / CRI Sargodha';

  static String treatmentTitle(String lang) =>
      isUrdu(lang) ? 'مرحلہ وار طریقہ علاج' : 'Stage-Based Treatment';

  static String treatmentSubtitle(String lang) => isUrdu(lang)
      ? 'پاکستانی ادویات و مقدار — محکمہ زراعت پنجاب / ایوب ریسرچ فیصل آباد / سی آر آئی سرگودھا'
      : 'Pakistan doses — AgriPunjab / AARI Faisalabad / CRI Sargodha';

  static String signsTitle(String lang) =>
      isUrdu(lang) ? '🔍 علامات و نشانات' : '🔍 Signs / Symptoms';

  static String sprayTitle(String lang) =>
      isUrdu(lang) ? '💊 اسپرے اور ادویات' : '💊 Spray / Treatment';

  static String actionsTitle(String lang) =>
      isUrdu(lang) ? '⚠️ ضروری اقدامات' : '⚠️ Actions Required';

  static String doseLabel(String lang) =>
      isUrdu(lang) ? 'مقدار' : 'Dose';

  static String timingLabel(String lang) =>
      isUrdu(lang) ? 'وقت' : 'Timing';

  static String sourceLabel(String lang) =>
      isUrdu(lang) ? 'ماخذ' : 'Source';

  static String routineCareSubtitle(String lang) => isUrdu(lang)
      ? 'محکمہ زراعت پنجاب کا سالانہ نگہداشت کیلنڈر'
      : 'AgriPunjab Annual Citrus Calendar';

  static String careTitle(String tabName, String lang) =>
      isUrdu(lang) ? '$tabName نگہداشت' : '$tabName Care';

  static String severityValue(String severity, String lang) {
    if (!isUrdu(lang)) return severity;
    switch (severity.toLowerCase()) {
      case 'critical':
        return 'انتہائی شدید (کریٹیکل)';
      case 'high':
        return 'شدید';
      case 'medium':
        return 'درمیانہ';
      case 'none':
        return 'کوئی نہیں';
      default:
        return severity;
    }
  }

  static String localizedDiseaseName(String originalName, String lang) {
    if (!isUrdu(lang)) return originalName;
    switch (originalName) {
      case 'Black Spot':
        return 'بلیک اسپاٹ (کالے دھبے)';
      case 'Canker':
        return 'کینکر (سٹرس کینکر)';
      case 'Greening / HLB':
        return 'سٹرس گریننگ / ایچ ایل بی';
      case 'Healthy':
        return 'صحت مند پودا';
      default:
        return originalName;
    }
  }
}
