// ============================================================
// DISEASE INFO DATA MODEL
// All disease data sourced from AgriPunjab.gov.pk,
// CRI Sargodha, AARI Faisalabad, PlantWise Pakistan.
// ============================================================

class TreatmentStage {
  final String stageName;
  final String stageColor; // 'early', 'moderate', 'severe'
  final List<String> signs;
  final List<TreatmentItem> treatments;
  final List<String> actions;
  final String followUp;
  final String source;

  const TreatmentStage({
    required this.stageName,
    required this.stageColor,
    required this.signs,
    required this.treatments,
    required this.actions,
    required this.followUp,
    required this.source,
  });
}

class TreatmentItem {
  final String name;
  final String dose;
  final String? timing;
  final String? note;

  const TreatmentItem({
    required this.name,
    required this.dose,
    this.timing,
    this.note,
  });
}

class DiseaseInfo {
  final String diseaseName;
  final String pathogen;
  final String source;
  final String emoji;
  final String colorTag; // 'yellow', 'orange', 'red', 'green'

  // Overview card
  final String diseaseType;
  final String affects;
  final String risk;
  final String severity;
  final String foundInPk;

  // Spread card
  final List<String> spreadInfo;

  // Prevention card
  final List<String> preventionSteps;

  // Treatment stages
  final List<TreatmentStage> stages;

  // Routine care (only for healthy)
  final List<RoutineCareTab>? routineCare;

  const DiseaseInfo({
    required this.diseaseName,
    required this.pathogen,
    required this.source,
    required this.emoji,
    required this.colorTag,
    required this.diseaseType,
    required this.affects,
    required this.risk,
    required this.severity,
    required this.foundInPk,
    required this.spreadInfo,
    required this.preventionSteps,
    required this.stages,
    this.routineCare,
  });
}

class RoutineCareTab {
  final String tabName;
  final List<String> items;

  const RoutineCareTab({
    required this.tabName,
    required this.items,
  });
}

// ============================================================
// DISEASE DATABASE (Bilingual: English & Urdu)
// ============================================================

class DiseaseDatabase {
  static const Map<String, DiseaseInfo> diseasesEnglish = {
    'Black Spot': _blackSpotEn,
    'Canker': _cankerEn,
    'Greening / HLB': _greeningEn,
    'Healthy': _healthyEn,
  };

  static const Map<String, DiseaseInfo> diseasesUrdu = {
    'Black Spot': _blackSpotUr,
    'Canker': _cankerUr,
    'Greening / HLB': _greeningUr,
    'Healthy': _healthyUr,
  };

  // Backwards compatibility map
  static const Map<String, DiseaseInfo> diseases = diseasesEnglish;

  static DiseaseInfo? getInfo(String diseaseName, {String lang = 'en'}) {
    String key = diseaseName;
    if (diseaseName.contains('Black Spot') || diseaseName.contains('بلیک اسپاٹ')) {
      key = 'Black Spot';
    } else if (diseaseName.contains('Canker') || diseaseName.contains('کینکر')) {
      key = 'Canker';
    } else if (diseaseName.contains('Greening') ||
        diseaseName.contains('HLB') ||
        diseaseName.contains('گریننگ')) {
      key = 'Greening / HLB';
    } else if (diseaseName.contains('Healthy') || diseaseName.contains('صحت مند')) {
      key = 'Healthy';
    }

    if (lang == 'ur') {
      return diseasesUrdu[key] ?? diseasesEnglish[key];
    }
    return diseasesEnglish[key];
  }

  // ----------------------------------------------------------
  // ENGLISH DATA
  // ----------------------------------------------------------

  // DISEASE 1: BLACK SPOT (EN)
  static const DiseaseInfo _blackSpotEn = DiseaseInfo(
    diseaseName: 'Black Spot',
    pathogen: 'Phyllosticta citricarpa (Fungus)',
    source: 'AgriPunjab.gov.pk · CRI Sargodha · AARI Faisalabad',
    emoji: '🔴',
    colorTag: 'red',
    diseaseType: 'Fungal Disease',
    affects: 'Fruit skin only — taste is NOT affected',
    risk: 'Fruit becomes unsellable, falls early',
    severity: 'Medium',
    foundInPk: 'Sargodha, Faisalabad, Jhang citrus belt',
    spreadInfo: [
      'Main Cause  : Fungal spores from fallen old leaves on ground',
      'Spreads By  : Rain water picks up spores from ground and splashes them onto young growing fruit',
      'Worst Time  : April to August (rain + humidity season)',
      'Enters Via  : Fruit skin surface during early growth stage (petal fall to 4–5 months after)',
      'Important   : Disease hides inside fruit for months — no visible signs until fruit starts to ripen. By then it is already too late to spray.',
    ],
    preventionSteps: [
      'After every harvest — rake and remove ALL fallen leaves from ground. Burn or bury them deep.\n(Leaves are where fungal spores live and multiply)',
      'Before April — spray Bordeaux Mixture on tree as a shield before rains begin.',
      'Use drip or ground irrigation only — do NOT use overhead sprinklers. Sprinklers act like rain and spread spores.',
      'Prune lower branches — keep them 50cm above ground to prevent rain splash reaching low fruit.',
      'Keep orchard floor clean — mow grass and weeds regularly so ground dries quickly after rain.',
    ],
    stages: [
      TreatmentStage(
        stageName: 'Early Stage',
        stageColor: 'early',
        signs: [
          'Tiny reddish-brown raised bumps on green fruit',
          'Less than 3mm — scattered spots',
        ],
        treatments: [
          TreatmentItem(
            name: 'Amistar Top (Azoxystrobin + Difenoconazole)',
            dose: '200ml per 200 liters of water',
            timing: 'April–May, right after flower fall',
          ),
          TreatmentItem(
            name: 'Nativo (Trifloxystrobin + Tebuconazole)',
            dose: '65g per 200 liters of water',
            timing: 'Rotate with Amistar Top',
            note: 'Do NOT use same spray twice in a row',
          ),
        ],
        actions: [
          'Remove ALL fallen leaves from ground',
          'Do NOT use same fungicide family twice',
        ],
        followUp: 'Check after 21 days',
        source: 'AARI Faisalabad / CRI Sargodha',
      ),
      TreatmentStage(
        stageName: 'Moderate Stage',
        stageColor: 'moderate',
        signs: [
          'Dark brown/black spots 3–10mm on fruit',
          'Yellow ring around spots visible',
          'Some fruit falling early from tree',
        ],
        treatments: [
          TreatmentItem(
            name: 'Mancozeb 80% WP',
            dose: '250–300g per 100 liters of water',
            timing: 'Every 14–21 days',
            note: 'After heavy rain: Reapply within 48 hours',
          ),
        ],
        actions: [
          'Remove and burn all spotted fruit on ground',
          'Do not spray right before heavy rain',
          'If rain comes, reapply copper spray after',
        ],
        followUp: 'Check after 14 days',
        source: 'AgriPunjab.gov.pk',
      ),
      TreatmentStage(
        stageName: 'Severe Stage',
        stageColor: 'severe',
        signs: [
          'Most fruit has large black sunken spots',
          'Heavy fruit falling before harvest',
          'Fruit surface cracking — dark crusty patches',
        ],
        treatments: [
          TreatmentItem(
            name: 'Copper Oxychloride',
            dose: '250–350g per 100 liters of water',
            timing: 'Apply immediately — repeat every 10 days',
          ),
        ],
        actions: [
          'Remove ALL infected fruit from tree and ground',
          'Do not sell or move infected fruit',
          'Prune crowded branches for sunlight + airflow',
          'After harvest: One final copper spray for protection into next season',
        ],
        followUp: 'Check after 10 days',
        source: 'AgriPunjab.gov.pk · PlantWise Pakistan',
      ),
    ],
  );

  // DISEASE 2: CANKER (EN)
  static const DiseaseInfo _cankerEn = DiseaseInfo(
    diseaseName: 'Canker',
    pathogen: 'Xanthomonas citri subsp. citri (Bacteria)',
    source: 'AgriPunjab.gov.pk · CRI Sargodha · PlantWise Knowledge Bank',
    emoji: '🟠',
    colorTag: 'orange',
    diseaseType: 'Bacterial Disease',
    affects: 'Leaves, branches, fruit — whole tree',
    risk: 'Tree weakens, fruit unsellable, can spread to entire orchard through rain and insects',
    severity: 'High',
    foundInPk: 'All citrus areas — worst in monsoon months',
    spreadInfo: [
      'Main Cause  : Bacteria (Xanthomonas citri)',
      'Spreads By  : Wind-driven rain carries bacteria from sick leaves to healthy ones through tiny pores',
      'Key Vector  : Citrus Leafminer insect (Narmi Keera) — this tiny insect digs tunnels in soft new leaves — bacteria enter through these tunnels. WITHOUT leafminer control, copper spray alone will NOT work',
      'Also Spreads: Dirty pruning tools touching infected then healthy trees. Human hands. Clothing.',
      'Worst Time  : July–September (monsoon / high humidity)',
      'Entry Point : Young leaves and young fruit (first 90 days)',
    ],
    preventionSteps: [
      'MOST IMPORTANT: Control Citrus Leafminer (Narmi Keera)\nCheck new soft leaf tips every week during growth flush. Leaves with silvery tunnels or curled edges = Leafminer.',
      'Plant windbreak trees around your orchard boundary (Eucalyptus, Poplar, or local barrier trees work well). Wind is the main way canker bacteria travel.',
      'Sterilize pruning tools before EVERY use:\nMix 1 cup bleach in 9 cups water — dip tool each time.',
      'Do not enter orchard when leaves are wet after rain. Bacteria travel on water drops on your hands/clothes.',
      'Buy nursery plants only from certified sources.\n(Punjab Govt certified screenhouse nurseries — available through AgriPunjab extension office)',
    ],
    stages: [
      TreatmentStage(
        stageName: 'Early Stage',
        stageColor: 'early',
        signs: [
          'Small water-soaked spots on young leaves',
          'Spots turn yellow then brown — yellow ring around',
          'Only new soft growth affected — few leaves',
        ],
        treatments: [
          TreatmentItem(
            name: 'Copper Oxychloride',
            dose: '250–350g per 100 liters of water',
            timing: 'Spray immediately on whole tree',
          ),
          TreatmentItem(
            name: 'Streptomycin Sulphate (Bactericide)',
            dose: '1g per liter of water',
            note: 'Use when canker is on young fruit also. Available: consult local AgriPunjab office',
          ),
          TreatmentItem(
            name: 'Abamectin (for Leafminer)',
            dose: 'Per product label — ask local dealer',
            note: 'Without this, copper spray will not work',
          ),
        ],
        actions: [
          'Remove and burn infected leaves',
          'Sterilize tools between every cut',
        ],
        followUp: 'Check after 14 days',
        source: 'AgriPunjab.gov.pk · CRI Sargodha',
      ),
      TreatmentStage(
        stageName: 'Moderate Stage',
        stageColor: 'moderate',
        signs: [
          'Raised, rough, crusty brown sores on leaves, branches, and fruit — hard volcano-like edges',
          'Yellow halo clearly visible',
          'Branch tips dying and turning dark',
        ],
        treatments: [
          TreatmentItem(
            name: 'Copper Hydroxide OR Bordeaux Mixture',
            dose: '300g per 100 liters water (Copper) OR standard 1:1:100 Bordeaux Mixture',
            timing: 'Spray whole tree right after pruning. Repeat every 10–14 days during monsoon',
          ),
          TreatmentItem(
            name: 'Abamectin (for Leafminer)',
            dose: 'Every 10–14 days during active flush growth',
          ),
        ],
        actions: [
          'Cut infected branches 15–20cm BELOW last sore',
          'Sterilize tool between EVERY single cut',
          'Bag and burn all cut material immediately',
          'If rain storm is forecast — spray copper BEFORE the storm arrives',
        ],
        followUp: 'Check after 10 days',
        source: 'AARI Faisalabad · PlantWise Knowledge Bank',
      ),
      TreatmentStage(
        stageName: 'Severe Stage',
        stageColor: 'severe',
        signs: [
          'Canker sores covering most of tree',
          'Branches dying — heavy leaf fall',
          'New growth gets infected before it opens',
          'Tree very weak with little healthy area left',
        ],
        treatments: [
          TreatmentItem(
            name: 'Copper Oxychloride (on cut surfaces)',
            dose: 'Apply on all pruning cut surfaces',
            timing: 'Continue spraying every 7 days if keeping tree',
          ),
        ],
        actions: [
          'If more than 30% of tree is infected — REMOVE THE WHOLE TREE to protect others',
          'If keeping: Heavy pruning — remove all infected wood',
          'If removing: Chip or burn the whole tree completely. Do NOT leave on ground or compost',
          'Spray neighboring trees with copper spray immediately after removal',
          'Wait 3 months minimum before replanting',
          'Use only certified disease-free nursery plants from Punjab Agriculture Department',
          'Contact local Agriculture Extension Officer — severe canker is a notifiable disease in Pakistan',
        ],
        followUp: 'Check after 7 days',
        source: 'AgriPunjab.gov.pk · PlantWise Pakistan',
      ),
    ],
  );

  // DISEASE 3: GREENING / HLB (EN)
  static const DiseaseInfo _greeningEn = DiseaseInfo(
    diseaseName: 'Greening / HLB',
    pathogen: 'Candidatus Liberibacter asiaticus (Bacteria — phloem limited)\nVector: Asian Citrus Psyllid (Diaphorina citri)',
    source: 'CRI Sargodha · Pest Warning Punjab · AARI Faisalabad · PlantWise',
    emoji: '🟡',
    colorTag: 'red',
    diseaseType: 'Bacterial (spread by insect only)',
    affects: 'Food tubes inside the tree — tree slowly starves. Fruit becomes bitter and misshapen.',
    risk: 'CRITICAL — can destroy entire orchard. No complete cure once tree is fully infected.',
    severity: 'Critical',
    foundInPk: 'Increasing in Sargodha, Sahiwal, Multan belt',
    spreadInfo: [
      'Main Vector : Asian Citrus Psyllid (Citrus Psylla) — a tiny jumping insect, only 3–4mm in size. Looks like a small gnat/mosquito.',
      'How It Works: Psylla bites infected tree → picks up bacteria → flies to healthy tree → bites it → injects bacteria directly into the tree\'s food tubes. Once inside — bacteria slowly destroy the tree.',
      'Target Area : Psylla ONLY attacks new soft leaf growth (new flush tips in spring and after monsoon)',
      'Danger      : ONE infected tree can spread HLB to your WHOLE orchard through these insects. Psylla can fly to neighboring orchards too.',
      'NOT Spread By: Water, soil, pruning tools, or air alone. Only through the psylla insect or infected nursery plants.',
    ],
    preventionSteps: [
      'MOST IMPORTANT: Kill the Psylla insect BEFORE it spreads.\nCheck new leaf flush EVERY WEEK — look for tiny orange waxy bumps at leaf tips (psylla eggs) or tiny jumping green-yellow insects.',
      'Put yellow sticky traps across your orchard.\n(Available at agriculture stores — hang at tree height)\nCheck traps every 2 weeks to monitor psylla levels.',
      'Spray insecticide during EVERY new flush growth:\nImidacloprid 20% SL — 40ml per 100 liters water\nOR Acetamiprid 20% SP — 125g per 100 liters water\n(Rotate between these — do not use same one twice)',
      'Talk to your neighboring farmers — everyone must spray together at the same time. Psylla from unsprayed neighbors\' orchards will come to yours.',
      'Buy ONLY certified plants from government-approved screenhouse nurseries (Punjab Citrus Revival Program). Never buy uncertified plants from roadside sellers.',
      'Release natural enemy: Tamarixia radiata wasp\n(Available from some Punjab government bio-control programs — kills psylla young ones naturally)',
    ],
    stages: [
      TreatmentStage(
        stageName: 'Early Stage',
        stageColor: 'early',
        signs: [
          'Some leaves blotchy — yellow patches on one side, green on other (uneven, not uniform yellow)',
          'New leaves smaller and paler than normal',
          'Some fruit stays green when it should ripen',
          'MUST confirm with PCR lab test first — HLB looks exactly like zinc deficiency',
        ],
        treatments: [
          TreatmentItem(
            name: 'Imidacloprid 20% SL (Psylla control)',
            dose: '40ml per 100 liters water',
            timing: 'Every 3 weeks during flush season',
            note: 'Target: All new flush leaf tips specifically',
          ),
          TreatmentItem(
            name: 'Acetamiprid 20% SP (Rotate with Imidacloprid)',
            dose: '125g per 100 liters water',
            note: 'Rotating prevents psylla becoming resistant',
          ),
          TreatmentItem(
            name: 'Foliar Nutrition Spray',
            dose: 'Zinc Sulphate + Manganese + Boron + NPK',
            timing: 'Every 2–3 weeks',
            note: 'Supports tree health and reduces fruit drop — does NOT cure HLB',
          ),
        ],
        actions: [
          'Contact AARI Faisalabad Lab / CRI Sargodha for PCR lab confirmation before starting treatment',
          'Do NOT start treatment without lab confirmation',
        ],
        followUp: 'Check after 14 days',
        source: 'CRI Sargodha · Pest Warning Punjab',
      ),
      TreatmentStage(
        stageName: 'Moderate Stage',
        stageColor: 'moderate',
        signs: [
          'Many branches with blotchy yellow-green leaves',
          'Fruit small, lopsided, very bitter',
          'Branch tips dying — leaves dropping from tip inward',
          'Tree producing much less fruit than before',
        ],
        treatments: [
          TreatmentItem(
            name: 'Imidacloprid + Acetamiprid (Rotation)',
            dose: 'Continue rotating every 3 weeks — do not stop',
          ),
          TreatmentItem(
            name: 'Increased Foliar Nutrition',
            dose: 'NPK + Zinc + Manganese + Boron + Iron',
            timing: 'Every 2 weeks',
          ),
        ],
        actions: [
          'Remove severely infected branches (removes bacteria AND psylla breeding ground)',
          'Inform neighboring farmers immediately so they can spray their orchards against psylla',
          'Remove ALL infected fallen fruit from ground — do not compost, bag and bury or burn',
        ],
        followUp: 'Check after 10 days',
        source: 'AARI Faisalabad · CRI Sargodha',
      ),
      TreatmentStage(
        stageName: 'Severe Stage',
        stageColor: 'severe',
        signs: [
          'Most of tree has yellow, blotchy, tiny leaves',
          'Very heavy fruit drop — most fruit useless',
          'Fruit green, bitter — zero market value',
          'Many branches dead and dry — almost no growth',
        ],
        treatments: [
          TreatmentItem(
            name: 'Imidacloprid (spray ALL trees within 50m)',
            dose: '40ml per 100 liters water',
            timing: 'Immediately after removal of infected tree',
            note: 'Kills any psylla that may carry bacteria',
          ),
        ],
        actions: [
          'REMOVE THE TREE COMPLETELY — this is the only way to protect your other trees',
          'Cut at ground level — chip or burn ALL wood, branches, leaves',
          'Do NOT leave stump — psylla breeds on new shoots',
          'Spray ALL trees within 50 meters with Imidacloprid immediately after removal',
          'Contact Agriculture Extension Officer and local Pest Warning office (Punjab)',
          'Wait minimum 3–6 months before replanting — confirm psylla levels are low first',
          'Buy ONLY certified HLB-free nursery trees from Punjab government-approved nurseries',
        ],
        followUp: 'Check neighboring trees after 7 days',
        source: 'AgriPunjab.gov.pk · CRI Sargodha',
      ),
    ],
  );

  // DISEASE 4: HEALTHY (EN)
  static const DiseaseInfo _healthyEn = DiseaseInfo(
    diseaseName: 'Healthy',
    pathogen: 'No disease detected',
    source: 'AgriPunjab.gov.pk · CRI Sargodha Maintenance Guide',
    emoji: '🟢',
    colorTag: 'green',
    diseaseType: 'No Disease',
    affects: 'Tree is healthy',
    risk: 'None — maintain routine care to stay disease-free',
    severity: 'None',
    foundInPk: 'N/A',
    spreadInfo: [],
    preventionSteps: [],
    stages: [],
    routineCare: [
      RoutineCareTab(
        tabName: 'Weekly',
        items: [
          'Check new soft leaf tips for tiny orange bumps or tiny jumping insects (Psylla / Psyllid)',
          'Check both sides of leaves for any small spots, bumps, curling, or unusual color changes',
          'Remove fallen leaves and fruit from ground every week (stops fungal spores)',
          'Look for leaves with silvery tunnels or curled edges = Citrus Leafminer (Narmi Keera) — act early',
        ],
      ),
      RoutineCareTab(
        tabName: 'Monthly',
        items: [
          'Apply balanced NPK fertilizer\nAdd: Zinc Sulphate + Manganese + Boron\n(Soil application or foliar spray)',
          'Check soil drainage — tree should NEVER sit in waterlogged soil',
          'Remove dead or crossing branches — keep airflow good inside tree canopy',
          'Spot-spray any visible pest colonies (scale insects, aphids, red spider mites)',
          'Apply fresh mulch around tree base — keeps moisture in and fungal spores out',
        ],
      ),
      RoutineCareTab(
        tabName: 'Seasonal',
        items: [
          'December–January (Dormant Season):\n• Prune deadwood and weak branches\n• Apply Bordeaux paste on tree trunk (foot rot)\n• Clean orchard floor — remove all leaf litter',
          'February–March (New Flush / Pre-Bloom):\n• Start psylla monitoring — check every week\n• Spray Imidacloprid when new flush starts\n• Apply foliar zinc + micronutrients',
          'April–May (Petal Fall / Fruit Set):\n• CRITICAL SPRAY: Amistar Top or Nativo fungicide (protects young fruit from Black Spot and Scab)\n• Continue leafminer monitoring and spray',
          'June–August (Monsoon / High Risk):\n• Spray Copper Oxychloride before monsoon rains\n• Reapply Mancozeb every 3–4 weeks\n• Inspect for canker after every rain storm',
          'September–November (Post-Monsoon / Pre-Harvest):\n• Final protective copper spray\n• Spray Acetamiprid for psylla (second flush)\n• Begin cleaning orchard floor for winter',
        ],
      ),
    ],
  );

  // ----------------------------------------------------------
  // URDU DATA (اردو میں مکمل معلومات)
  // ----------------------------------------------------------

  // DISEASE 1: BLACK SPOT (UR)
  static const DiseaseInfo _blackSpotUr = DiseaseInfo(
    diseaseName: 'بلیک اسپاٹ (کالے دھبے)',
    pathogen: 'فائیلوسٹکٹا سیٹریکارپا (پھپھوندی)',
    source: 'محکمہ زراعت پنجاب · سی آر آئی سرگودھا · ایوب ریسرچ فیصل آباد',
    emoji: '🔴',
    colorTag: 'red',
    diseaseType: 'پھپھوندی کی بیماری (فنگل)',
    affects: 'صرف پھل کا چھلکا — ذائقہ متاثر نہیں ہوتا',
    risk: 'پھل بدصورت ہو کر بکنے کے قابل نہیں رہتا، وقت سے پہلے گر جاتا ہے',
    severity: 'Medium',
    foundInPk: 'سرگودھا، فیصل آباد، جھنگ سٹرس بیلٹ',
    spreadInfo: [
      'اہم سبب : زمین پر گرے پرانے پتوں سے پھپھوندی کے ذرات (Spores)',
      'پھیلاؤ : بارش کا پانی زمین سے ذرات اڑا کر نئے بڑھتے پھل پر ڈالتا ہے',
      'بدترین وقت : اپریل تا اگست (بارش اور نمی کا موسم)',
      'داخلے کا مقام : ابتدائی بڑھوتری کے دوران پھل کی سطح (پھول گرنے سے لے کر اگلے 4 سے 5 ماہ تک)',
      'اہم بات : بیماری کئی ماہ تک پھل کے اندر چھپی رہتی ہے، جب پھل پکنے لگتا ہے تب ہی نظر آتی ہے۔ اس وقت اسپرے کا کوئی فائدہ نہیں ہوتا۔',
    ],
    preventionSteps: [
      'ہر چنائی کے بعد — زمین پر گرے تمام پتوں کو اکٹھا کر کے جلا دیں یا زمین میں گہرا دبا دیں۔\n(پتے ہی پھپھوندی کے زندہ رہنے اور پھیلنے کا مرکز ہیں)',
      'اپریل سے پہلے — بارشیں شروع ہونے سے قبل حفاظتی ڈھال کے طور پر درخت پر بوردو مکسچر کا اسپرے کریں۔',
      'صرف ڈرپ یا زمین پر آبپاشی کریں — فوارہ آبپاشی (اوورہیڈ اسپرنکلر) ہرگز نہ کریں۔ فوارہ بارش کی طرح ذرات پھیلاتا ہے۔',
      'نچلی شاخوں کی کٹائی کریں — زمین سے کم از کم 50 سینٹی میٹر اونچی رکھیں تاکہ بارش کے چھینٹے نچلے پھل تک نہ پہنچیں۔',
      'باغ کے فرش کو صاف رکھیں — گھاس اور جڑی بوٹیاں باقاعدگی سے کاٹیں تاکہ بارش کے بعد زمین جلدی خشک ہو جائے۔',
    ],
    stages: [
      TreatmentStage(
        stageName: 'ابتدائی مرحلہ',
        stageColor: 'early',
        signs: [
          'سبز پھل پر چھوٹے سرخ بھورے ابھرے ہوئے دانے',
          '3 ملی میٹر سے چھوٹے بکھرے ہوئے دھبے',
        ],
        treatments: [
          TreatmentItem(
            name: 'ایمیسٹار ٹاپ (Azoxystrobin + Difenoconazole)',
            dose: '200 ملی لیٹر فی 200 لیٹر پانی',
            timing: 'اپریل تا مئی، پھول گرنے کے فوراً بعد',
          ),
          TreatmentItem(
            name: 'نیٹیوو (Trifloxystrobin + Tebuconazole)',
            dose: '65 گرام فی 200 لیٹر پانی',
            timing: 'ایمیسٹار ٹاپ کے ساتھ بدل کر اسپرے کریں',
            note: 'ایک ہی اسپرے مسلسل دو بار نہ کریں',
          ),
        ],
        actions: [
          'زمین پر گرے تمام پتے اکٹھے کر کے تلف کریں',
          'ایک ہی گروپ کی پھپھوندی کش دوا مسلسل نہ دہرائیں',
        ],
        followUp: '21 دن بعد دوبارہ معائنہ کریں',
        source: 'ایوب زرعی تحقیقاتی ادارہ فیصل آباد / سی آر آئی سرگودھا',
      ),
      TreatmentStage(
        stageName: 'درمیانہ مرحلہ',
        stageColor: 'moderate',
        signs: [
          'پھل پر 3 تا 10 ملی میٹر گہرے بھورے یا کالے دھبے',
          'دھبوں کے گرد زرد رنگ کا دائرہ',
          'پھل کا وقت سے پہلے درخت سے گرنا',
        ],
        treatments: [
          TreatmentItem(
            name: 'مینکوزیب 80% ڈبلیو پی (Mancozeb)',
            dose: '250 سے 300 گرام فی 100 لیٹر پانی',
            timing: 'ہر 14 سے 21 دن بعد',
            note: 'تیز بارش کے بعد: 48 گھنٹے کے اندر دوبارہ اسپرے کریں',
          ),
        ],
        actions: [
          'زمین پر گرے تمام داغدار پھل اکٹھے کر کے جلا دیں',
          'تیز بارش کے فوراً پہلے اسپرے نہ کریں',
          'اگر بارش ہو جائے تو بعد میں کاپر اسپرے دہرائیں',
        ],
        followUp: '14 دن بعد دوبارہ معائنہ کریں',
        source: 'محکمہ زراعت پنجاب (AgriPunjab.gov.pk)',
      ),
      TreatmentStage(
        stageName: 'شدید مرحلہ',
        stageColor: 'severe',
        signs: [
          'زیادہ تر پھلوں پر بڑے گہرے دھنسے ہوئے کالے دھبے',
          'چنائی سے پہلے پھل کا بڑے پیمانے پر گرنا',
          'پھل کی جلد کا پھٹنا اور کھردری سطح بن جانا',
        ],
        treatments: [
          TreatmentItem(
            name: 'کاپر آکسی کلورائڈ (Copper Oxychloride)',
            dose: '250 سے 350 گرام فی 100 لیٹر پانی',
            timing: 'فوری اسپرے کریں — ہر 10 دن بعد دہرائیں',
          ),
        ],
        actions: [
          'درخت اور زمین سے تمام متاثرہ پھل ہٹا کر تلف کریں',
          'متاثرہ پھل کو مارکیٹ یا دوسرے باغات میں منتقل نہ کریں',
          'گھنی شاخوں کی کٹائی کریں تاکہ دھوپ اور ہوا کا گزر ہو سکے',
          'چنائی کے بعد: اگلے سیزن کی حفاظت کے لیے آخری کاپر اسپرے کریں',
        ],
        followUp: '10 دن بعد معائنہ کریں',
        source: 'محکمہ زراعت پنجاب · پلانٹ وائز پاکستان',
      ),
    ],
  );

  // DISEASE 2: CANKER (UR)
  static const DiseaseInfo _cankerUr = DiseaseInfo(
    diseaseName: 'کینکر (سٹرس کینکر)',
    pathogen: 'زینتھوموناس سیٹری (بیکٹیریا)',
    source: 'محکمہ زراعت پنجاب · سی آر آئی سرگودھا · پلانٹ وائز نالج بینک',
    emoji: '🟠',
    colorTag: 'orange',
    diseaseType: 'بیکٹیریل بیماری (جراثیمی)',
    affects: 'پتے، شاخیں اور پھل — پورا درخت',
    risk: 'درخت کمزور ہو جاتا ہے، پھل ناقابل فروخت ہو جاتا ہے، بارش اور کیڑوں سے پورے باغ میں پھیل سکتا ہے',
    severity: 'High',
    foundInPk: 'تمام سٹرس کے علاقے — مون سون کے مہینوں میں سب سے زیادہ',
    spreadInfo: [
      'اہم سبب : بیکٹیریا (Xanthomonas citri)',
      'پھیلاؤ : تیز ہوا اور بارش کے قطرے بیمار پتوں سے تندرست پتوں تک جراثیم پہنچاتے ہیں',
      'اہم کیڑا : نرمی کیڑا (Citrus Leafminer) — یہ باریک کیڑا نئے نرم پتوں میں سرنگیں بناتا ہے جن سے جراثیم داخل ہوتے ہیں۔ نرمی کیڑے پر قابو پائے بغیر صرف کاپر اسپرے کام نہیں کرے گا',
      'مزید اسباب : کٹائی کے آلودہ اوزار، انسانی ہاتھ اور کپڑے',
      'بدترین وقت : جولائی تا ستمبر (مون سون / شدید نمی)',
      'نشانہ : نرم نئے پتے اور چھوٹے پھل (پہلے 90 دن)',
    ],
    preventionSteps: [
      'سب سے اہم: نرمی کیڑے (Citrus Leafminer) کا فوری تدارک کریں۔ نئی نرم کونپلوں پر ہر ہفتے چیک کریں۔ چاندی جیسی سرنگیں یا مڑے ہوئے پتے = نرمی کیڑا۔',
      'باغ کے گرد ہوا روک باڑ (سفیدہ، پاپلر وغیرہ) لگائیں کیونکہ تیز ہوا سے کینکر کے جراثیم اڑتے ہیں۔',
      'کٹائی کے اوزار ہر درخت کے بعد جراثیم سے پاک کریں (1 کپ بلیچ 9 کپ پانی میں ملا کر دھوئیں)۔',
      'بارش کے بعد گیلے باغ میں داخل نہ ہوں، جراثیم پانی کے قطروں کے ذریعے پھیلتے ہیں۔',
      'صرف تصدیق شدہ نرسریوں سے پودے خریدیں (محکمہ زراعت پنجاب کی منظور شدہ نرسریاں)۔',
    ],
    stages: [
      TreatmentStage(
        stageName: 'ابتدائی مرحلہ',
        stageColor: 'early',
        signs: [
          'نئے پتوں پر پانی سے بھیگے ہوئے چھوٹے دھبے',
          'دھبے زرد اور پھر بھورے ہو جاتے ہیں — گرد پیلا ہالہ',
          'صرف نئی نرم پھوٹ اور چند پتے متاثر',
        ],
        treatments: [
          TreatmentItem(
            name: 'کاپر آکسی کلورائڈ (Copper Oxychloride)',
            dose: '250 سے 350 گرام فی 100 لیٹر پانی',
            timing: 'پورے درخت پر فوری اسپرے کریں',
          ),
          TreatmentItem(
            name: 'اسٹریپٹو مائسن سلفیٹ (Streptomycin Sulphate)',
            dose: '1 گرام فی لیٹر پانی',
            note: 'چھوٹے پھلوں پر کینکر ہونے کی صورت میں استعمال کریں۔',
          ),
          TreatmentItem(
            name: 'ابامیکٹن (Abamectin) — نرمی کیڑے کے لیے',
            dose: 'لیبل پر دی گئی ہدایت کے مطابق',
            note: 'اس کے بغیر کاپر کا اسپرے پوری طرح موثر نہیں ہوگا',
          ),
        ],
        actions: [
          'متاثرہ پتے توڑ کر جلا دیں',
          'ہر کٹائی کے بعد اوزار کو ڈیٹول یا بلیچ سے صاف کریں',
        ],
        followUp: '14 دن بعد دوبارہ معائنہ کریں',
        source: 'محکمہ زراعت پنجاب · سی آر آئی سرگودھا',
      ),
      TreatmentStage(
        stageName: 'درمیانہ مرحلہ',
        stageColor: 'moderate',
        signs: [
          'پتوں، شاخوں اور پھل پر ابھرے ہوئے کھردرے چھالے نما بھورے زخم جن کے کنارے جوالامکھی کی طرح اٹھے ہوئے ہوتے ہیں',
          'زرد رنگ کا ہالہ واضح نظر آتا ہے',
          'شاخوں کے سرے سوکھنا اور کالے ہونا شروع ہو جاتے ہیں',
        ],
        treatments: [
          TreatmentItem(
            name: 'کاپر ہائیڈرو آکسائیڈ یا بوردو مکسچر',
            dose: '300 گرام فی 100 لیٹر پانی یا روایتی 1:1:100 بوردو مکسچر',
            timing: 'کٹائی کے فوراً بعد پورے درخت پر اسپرے کریں۔ مون سون میں ہر 10 سے 14 دن بعد دہرائیں',
          ),
          TreatmentItem(
            name: 'ابامیکٹن (نرمی کیڑے کے لیے)',
            dose: 'نئی پھوٹ کے دوران ہر 10 سے 14 دن بعد',
          ),
        ],
        actions: [
          'متاثرہ شاخوں کو آخری زخم سے 15 تا 20 سینٹی میٹر نیچے سے کاٹیں',
          'ہر کٹ کے بعد قینچی یا آرے کو جراثیم کش محلول میں ڈبوئیں',
          'کٹی ہوئی تمام شاخیں تھیلے میں بند کر کے فوری جلا دیں',
          'اگر آندھی یا طوفانی بارش متوقع ہو تو اس سے پہلے کاپر اسپرے کریں',
        ],
        followUp: '10 دن بعد دوبارہ معائنہ کریں',
        source: 'ایوب زرعی تحقیقاتی ادارہ فیصل آباد · پلانٹ وائز نالج بینک',
      ),
      TreatmentStage(
        stageName: 'شدید مرحلہ',
        stageColor: 'severe',
        signs: [
          'کینکر کے چھالے درخت کے زیادہ تر حصے پر پھیل چکے ہیں',
          'شاخیں سوکھ رہی ہیں اور پتے کثرت سے گر رہے ہیں',
          'نئی پھوٹ کھلنے سے پہلے ہی بیمار ہو جاتی ہے',
          'درخت انتہائی کمزور ہو چکا ہے اور تندرست حصہ نہ ہونے کے برابر ہے',
        ],
        treatments: [
          TreatmentItem(
            name: 'کاپر آکسی کلورائڈ (کٹائی کے زخموں پر)',
            dose: 'کٹائی کے تمام کھلے حصوں پر لیپ کریں',
            timing: 'اگر درخت رکھنا ہو تو ہر 7 دن بعد اسپرے جاری رکھیں',
          ),
        ],
        actions: [
          'اگر درخت 30% سے زیادہ متاثر ہو تو دوسرے درختوں کو بچانے کے لیے پورے درخت کو اکھاڑ دیں',
          'اگر درخت رکھنا ہو: گہری چھٹائی کریں اور متاثرہ لکڑی کاٹ دیں',
          'اگر درخت اکھاڑیں: مکمل درخت کو جلا دیں۔ زمین پر یا کھاد کے ڈھیر میں ہرگز نہ پھینکیں',
          'درخت اکھاڑنے کے فوراً بعد قریبی درختوں پر کاپر کا اسپرے کریں',
          'نیا پودا لگانے سے پہلے کم از کم 3 ماہ انتظار کریں',
          'صرف محکمہ زراعت سے تصدیق شدہ بیماری سے پاک نرسری کے پودے لگائیں',
          'مقامی زرعی توسیعی افسر سے رابطہ کریں — شدید کینکر پاکستان میں اطلاع طلب بیماری ہے',
        ],
        followUp: '7 دن بعد معائنہ کریں',
        source: 'محکمہ زراعت پنجاب · پلانٹ وائز پاکستان',
      ),
    ],
  );

  // DISEASE 3: GREENING / HLB (UR)
  static const DiseaseInfo _greeningUr = DiseaseInfo(
    diseaseName: 'سٹرس گریننگ / ایچ ایل بی',
    pathogen: 'کینڈیڈیٹس لبریبیکٹر ایشیاٹیکس (بیکٹیریا — غذائی رگوں میں محدود)\nکیڑا: ایشیائی سٹرس سائلا (Diaphorina citri)',
    source: 'سی آر آئی سرگودھا · پیسٹ وارننگ پنجاب · ایوب ریسرچ فیصل آباد · پلانٹ وائز',
    emoji: '🟡',
    colorTag: 'red',
    diseaseType: 'بیکٹیریل بیماری (صرف کیڑے کے ذریعے پھیلتی ہے)',
    affects: 'درخت کے اندر خوراک پہنچانے والی نالیاں — درخت آہستہ آہستہ بھوکا مر جاتا ہے۔ پھل کڑوا اور ٹیڑھا رہ جاتا ہے۔',
    risk: 'انتہائی سنگین — پورا باغ تباہ ہو سکتا ہے۔ درخت مکمل متاثر ہونے کے بعد کوئی علاج ممکن نہیں۔',
    severity: 'Critical',
    foundInPk: 'سرگودھا، ساہیوال، ملتان کی پٹی میں تیزی سے بڑھ رہی ہے',
    spreadInfo: [
      'اہم کیڑا : ایشیائی سٹرس سائلا (Citrus Psylla) — 3 سے 4 ملی میٹر کا اڑنے اور کودنے والا باریک کیڑا۔',
      'طریقہ واردات: سائلا بیمار درخت کا رس پیتا ہے → بیکٹیریا اس کے اندر چلے جاتے ہیں → تندرست درخت پر بیٹھ کر کاٹتا ہے → بیکٹیریا درخت کی خوراک والی رگوں میں داخل ہو جاتے ہیں۔ اندر جا کر بیکٹیریا درخت کو تباہ کر دیتے ہیں۔',
      'حملے کا ہدف : سائلا صرف نئے نرم پتوں پر حملہ کرتا ہے (بہار اور مون سون کے بعد نئی پھوٹ پر)',
      'خطرہ : ایک بیمار درخت ان کیڑوں کے ذریعے آپ کے پورے باغ میں بیماری پھیلا سکتا ہے۔ سائلا ہمسایہ باغات تک بھی اڑ سکتا ہے۔',
      'پانی، مٹی، کٹائی کے اوزاروں یا صرف ہوا سے نہیں پھیلتی۔ صرف سائلا کیڑے یا متاثرہ نرسری پودوں سے پھیلتی ہے۔',
    ],
    preventionSteps: [
      'سب سے اہم: سائلا کیڑے کو پھیلنے سے پہلے ماریں۔ نئی پھوٹ پر ہر ہفتے چیک کریں — زرد ویکس نما انڈے یا اڑنے والے باریک کیڑے۔',
      'پورے باغ میں پیلے چپکنے والے کارڈز (Yellow Sticky Traps) درختوں کی اونچائی پر لگائیں۔ سائلا کی سطح جانچنے کے لیے ہر 2 ہفتے بعد دیکھیں۔',
      'ہر نئی پھوٹ پر کیڑے مار اسپرے کریں:\nامیڈاکلوپرڈ 20% ایس ایل — 40 ملی لیٹر فی 100 لیٹر پانی\nیا ایسیٹامیپرڈ 20% ایس پی — 125 گرام فی 100 لیٹر پانی\n(ان دونوں کو بدل بدل کر استعمال کریں، ایک دوا بار بار نہ کریں)',
      'اپنے ہمسایہ کاشتکاروں سے بات کریں — سب ایک ساتھ ایک ہی وقت پر اسپرے کریں ورنہ غیر اسپرے شدہ باغ سے سائلا آپ کے باغ آ جائے گا۔',
      'صرف سرکاری منظور شدہ اسکرین ہاؤس نرسریوں (پنجاب سٹرس ریوائیول پروگرام) سے تصدیق شدہ پودے لیں۔ سڑک کنارے بغیر تصدیق شدہ پودے کبھی نہ خریدیں۔',
      'قدرتی دوست کیڑا (ٹماریکسیا ریڈی ایٹا - Tamarixia radiata wasp) استعمال کریں جو سائلا کے بچوں کو قدرتی طور پر ختم کر دیتا ہے۔',
    ],
    stages: [
      TreatmentStage(
        stageName: 'ابتدائی مرحلہ',
        stageColor: 'early',
        signs: [
          'کچھ پتوں پر داغ دھبے — ایک طرف زرد، دوسری طرف سبز (بے قاعدہ پیلا پن)',
          'نئے پتے عام پتوں کی نسبت چھوٹے اور ہلکے رنگ کے',
          'کچھ پھل پکنے کے وقت بھی ہرے رہ جاتے ہیں',
          'علاج سے پہلے لیبارٹری کے پی سی آر ٹیسٹ سے تصدیق لازمی ہے کیونکہ یہ بالکل زنک کی کمی جیسی دکھائی دیتی ہے',
        ],
        treatments: [
          TreatmentItem(
            name: 'امیڈاکلوپرڈ 20% ایس ایل (سائلا کے خاتمے کے لیے)',
            dose: '40 ملی لیٹر فی 100 لیٹر پانی',
            timing: 'نئی پھوٹ کے سیزن میں ہر 3 ہفتے بعد',
            note: 'ہدف: خاص طور پر تمام نئے نرم پتوں کے سرے',
          ),
          TreatmentItem(
            name: 'ایسیٹامیپرڈ 20% ایس پی (امیڈاکلوپرڈ کے ساتھ بدل کر)',
            dose: '125 گرام فی 100 لیٹر پانی',
            note: 'ادویات بدلنے سے سائلا میں مدافعت پیدا نہیں ہوتی',
          ),
          TreatmentItem(
            name: 'غذائی مائیکرو نیوٹرینٹس کا اسپرے',
            dose: 'زنک سلفیٹ + مینگنیز + بوران + این پی کے',
            timing: 'ہر 2 سے 3 ہفتے بعد',
            note: 'یہ درخت کی طاقت بحال رکھتا ہے اور پھل گرنا کم کرتا ہے — بیماری کا خاتمہ نہیں کرتا',
          ),
        ],
        actions: [
          'علاج شروع کرنے سے پہلے ایوب ریسرچ لیب فیصل آباد یا سی آر آئی سرگودھا سے پی سی آر ٹیسٹ کی تصدیق حاصل کریں',
          'لیب تصدیق کے بغیر علاج شروع نہ کریں',
        ],
        followUp: '14 دن بعد دوبارہ معائنہ کریں',
        source: 'سی آر آئی سرگودھا · پیسٹ وارننگ پنجاب',
      ),
      TreatmentStage(
        stageName: 'درمیانہ مرحلہ',
        stageColor: 'moderate',
        signs: [
          'بہت سی شاخوں پر دھبے دار زرد اور سبز پتے',
          'پھل چھوٹا، ٹیڑھا اور انتہائی کڑوا',
          'شاخوں کے سرے سوکھ رہے ہیں — پتے سرے سے اندر کی طرف جھڑ رہے ہیں',
          'درخت پر پھل کی پیداوار پہلے سے بہت کم',
        ],
        treatments: [
          TreatmentItem(
            name: 'امیڈاکلوپرڈ + ایسیٹامیپرڈ (ردوبدل کے ساتھ)',
            dose: 'ہر 3 ہفتے بعد بدل بدل کر اسپرے جاری رکھیں — ناغہ نہ کریں',
          ),
          TreatmentItem(
            name: 'پتوں پر اضافی غذائی اسپرے',
            dose: 'این پی کے + زنک + مینگنیز + بوران + آئرن',
            timing: 'ہر 2 ہفتے بعد',
          ),
        ],
        actions: [
          'شدید متاثرہ شاخیں کاٹ دیں (بیکٹیریا اور سائلا کی افزائش کا خاتمہ ہوتا ہے)',
          'ہمسایہ کسانوں کو فوری مطلع کریں تاکہ وہ اپنے باغات پر سائلا کا اسپرے کر سکیں',
          'زمین پر گرے تمام بیمار پھل تلف کریں — تھیلے میں بند کر کے دفن کریں یا جلائیں',
        ],
        followUp: '10 دن بعد دوبارہ معائنہ کریں',
        source: 'ایوب زرعی تحقیقاتی ادارہ فیصل آباد · سی آر آئی سرگودھا',
      ),
      TreatmentStage(
        stageName: 'شدید مرحلہ',
        stageColor: 'severe',
        signs: [
          'زیادہ تر درخت پر زرد، داغدار اور انتہائی چھوٹے پتے',
          'پھل کا بہت زیادہ گرنا — زیادہ تر پھل بیکار',
          'پھل بالکل ہرا اور کڑوا — مارکیٹ میں کوئی قدر نہیں',
          'بہت سی شاخیں سوکھی اور مردہ — نئی بڑھوتری بالکل بند',
        ],
        treatments: [
          TreatmentItem(
            name: 'امیڈاکلوپرڈ (50 میٹر کے اندر تمام درختوں پر اسپرے کریں)',
            dose: '40 ملی لیٹر فی 100 لیٹر پانی',
            timing: 'متاثرہ درخت کاٹنے کے فوراً بعد',
            note: 'بیکٹیریا منتقل کرنے والے باقی ماندہ سائلا کا مکمل خاتمہ کرتا ہے',
          ),
        ],
        actions: [
          'درخت کو جڑ سے اکھاڑ دیں — یہ دوسرے درختوں کو بچانے کا واحد راستہ ہے',
          'زمین کی سطح سے کاٹ کر تمام لکڑی، شاخیں اور پتے جلا دیں',
          'تنے کا ٹنڈ ہرگز نہ چھوڑیں — نئی پھوٹ پر سائلا انڈے دیتا ہے',
          'درخت کاٹنے کے فوراً بعد 50 میٹر کے اندر موجود تمام درختوں پر امیڈاکلوپرڈ اسپرے کریں',
          'مقامی زرعی توسیعی افسر اور پیسٹ وارننگ پنجاب کے دفتر کو اطلاع دیں',
          'نیا پودا لگانے سے پہلے کم از کم 3 سے 6 ماہ انتظار کریں اور سائلا کے خاتمے کی تسلی کریں',
          'صرف پنجاب حکومت سے منظور شدہ نرسریوں سے گریننگ سے پاک تصدیق شدہ پودے لگائیں',
        ],
        followUp: '7 دن بعد قریبی درختوں کا معائنہ کریں',
        source: 'محکمہ زراعت پنجاب · سی آر آئی سرگودھا',
      ),
    ],
  );

  // DISEASE 4: HEALTHY (UR)
  static const DiseaseInfo _healthyUr = DiseaseInfo(
    diseaseName: 'صحت مند پودا',
    pathogen: 'کوئی بیماری نہیں پائی گئی',
    source: 'محکمہ زراعت پنجاب · سی آر آئی سرگودھا نگہداشت گائیڈ',
    emoji: '🟢',
    colorTag: 'green',
    diseaseType: 'کوئی بیماری نہیں',
    affects: 'درخت مکمل طور پر تندرست ہے',
    risk: 'کوئی خطرہ نہیں — تندرست رکھنے کے لیے معمول کی نگہداشت جاری رکھیں',
    severity: 'None',
    foundInPk: 'تمام علاقے',
    spreadInfo: [],
    preventionSteps: [],
    stages: [],
    routineCare: [
      RoutineCareTab(
        tabName: 'ہفتہ وار',
        items: [
          'نئے نرم پتوں کے سروں پر باریک نارنجی ابھار یا اڑنے کودنے والے کیڑے (سٹرس سائلا) چیک کریں',
          'پتوں کی دونوں اطراف داغ، دھبے، مڑاؤ یا غیر معمولی رنگت کے لیے معائنہ کریں',
          'زمین پر گرے پتے اور پھل ہر ہفتے اٹھا کر تلف کریں (پھپھوندی کے ذرات کو روکتا ہے)',
          'چاندی جیسی سرنگوں یا مڑے پتوں والے نرمی کیڑے (Citrus Leafminer) کا فوری سدباب کریں',
        ],
      ),
      RoutineCareTab(
        tabName: 'ماہانہ',
        items: [
          'متوازن این پی کے (NPK) کھاد ڈالیں\nاضافہ: زنک سلفیٹ + مینگنیز + بوران\n(زمین میں ڈالیں یا پتوں پر اسپرے کریں)',
          'زمین میں پانی کا نکاس چیک کریں — جڑوں میں پانی کھڑا نہیں رہنا چاہیے',
          'خشک، بیمار یا الجھی شاخیں کاٹیں تاکہ درخت کے اندر ہوا اور دھوپ کا گزر رہے',
          'نظر آنے والے کیڑوں کے جھنڈ (اسکیل انسیکٹ، چیپا/ایفڈ، لال مکڑی) پر بروقت اسپرے کریں',
          'تنے کے ارد گرد ملچنگ کریں — نمی برقرار رہتی ہے اور مٹی کی پھپھوندی اوپر نہیں آتی',
        ],
      ),
      RoutineCareTab(
        tabName: 'موسمی',
        items: [
          'دسمبر تا جنوری (سکوت کا موسم):\n• سوکھی لکڑی اور کمزور شاخوں کی کٹائی\n• تنے پر بوردو پیسٹ کا لیپ (جڑ اور تنے کی سڑاند سے بچاؤ)\n• باغ کے فرش سے تمام گرے پتوں کی صفائی',
          'فروری تا مارچ (نئی پھوٹ اور پھول آنے سے قبل):\n• سٹرس سائلا کی باقاعدہ نگرانی شروع کریں\n• نئی پھوٹ پر امیڈاکلوپرڈ کا اسپرے\n• زنک اور مائیکرو نیوٹرینٹس کا اسپرے',
          'اپریل تا مئی (پھول گرنے اور پھل بننے کا وقت):\n• اہم حفاظتی اسپرے: ایمیسٹار ٹاپ یا نیٹیوو پھپھوندی کش (پھل کو بلیک اسپاٹ اور خارش سے بچاتا ہے)\n• نرمی کیڑے کی نگرانی اور اسپرے جاری رکھیں',
          'جون تا اگست (مون سون کا موسم):\n• مون سون کی بارشوں سے قبل کاپر آکسی کلورائڈ کا اسپرے کریں\n• ہر 3 سے 4 ہفتے بعد مینکوزیب کا اسپرے دہرائیں\n• ہر بارش کے بعد کینکر کی علامت کا جائزہ لیں',
          'ستمبر تا نومبر (مون سون کے بعد اور چنائی سے قبل):\n• آخری حفاظتی کاپر اسپرے کریں\n• دوسری پھوٹ پر سائلا کے خاتمے کے لیے ایسیٹامیپرڈ کا اسپرے کریں\n• موسم سرما کے لیے باغ کے فرش کی صفائی شروع کریں',
        ],
      ),
    ],
  );
}
