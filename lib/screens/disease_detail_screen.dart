import 'package:flutter/material.dart';

import '../localization/app_strings.dart';
import '../models/disease_info.dart';
import '../services/language_controller.dart';

// ============================================================
// DISEASE DETAIL SCREEN
// Shows full disease info: Overview, Spread, Prevention,
// and Stage-Based Treatment tabs.
//
// THEME: only Dark Green, Light Green, Orange, Yellow
// ============================================================

// ----------------------------------------------------------
// APP PALETTE (only these 4 color families)
// ----------------------------------------------------------
class _Palette {
  // Dark green
  static const darkGreen = Color(0xFF1B5E20);
  static const darkGreenLight = Color(0xFFE8F5E9);

  // Light green
  static const lightGreen = Color(0xFF689F38);
  static const lightGreenLight = Color(0xFFF1F8E9);

  // Orange
  static const orange = Color(0xFFEF6C00);
  static const orangeLight = Color(0xFFFFF3E0);
  static const deepOrange = Color(0xFFE65100);

  // Yellow
  static const yellow = Color(0xFFF9A825);
  static const yellowLight = Color(0xFFFFFDE7);
  static const yellowDark = Color(0xFFF57F17); // readable yellow for text
}

class DiseaseDetailScreen extends StatefulWidget {
  final DiseaseInfo info;

  const DiseaseDetailScreen({super.key, required this.info});

  @override
  State<DiseaseDetailScreen> createState() => _DiseaseDetailScreenState();
}

class _DiseaseDetailScreenState extends State<DiseaseDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  String get _currentLang => LanguageController.instance.languageCode;

  bool get _isUrdu => _currentLang == 'ur';

  // Pick a smaller size when Urdu is active
  double _fs(double en, double ur) => _isUrdu ? ur : en;

  @override
  void initState() {
    super.initState();
    // Healthy: Overview + 3 routine care tabs
    // Disease: Overview, Spread, Prevention, Treatment
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ----------------------------------------------------------
  // Colors
  // ----------------------------------------------------------
  Color get _primaryColor {
    switch (widget.info.colorTag) {
      case 'blue':
        return _Palette.lightGreen;
      case 'orange':
        return _Palette.orange;
      case 'red':
        return _Palette.yellow;
      case 'green':
      default:
        return _Palette.darkGreen;
    }
  }

  Color get _lightColor {
    switch (widget.info.colorTag) {
      case 'blue':
        return _Palette.lightGreenLight;
      case 'orange':
        return _Palette.orangeLight;
      case 'red':
        return _Palette.yellowLight;
      case 'green':
      default:
        return _Palette.darkGreenLight;
    }
  }

  // Color for text/icons placed on light backgrounds
  Color get _accentTextColor {
    if (widget.info.colorTag == 'red') return _Palette.yellowDark;
    return _primaryColor;
  }

  // ----------------------------------------------------------
  // TAB LABELS
  // ----------------------------------------------------------
  List<String> get _tabLabels {
    final lang = _currentLang;
    if (widget.info.colorTag == 'green') {
      return [
        AppStrings.overviewTab(lang),
        AppStrings.weeklyTab(lang),
        AppStrings.monthlyTab(lang),
        AppStrings.seasonalTab(lang),
      ];
    }
    return [
      AppStrings.overviewTab(lang),
      AppStrings.spreadTab(lang),
      AppStrings.preventionTab(lang),
      AppStrings.treatmentTab(lang),
    ];
  }

  // ----------------------------------------------------------
  // BUILD
  // ----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF2DB),
      appBar: AppBar(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          '${widget.info.emoji} ${widget.info.diseaseName}',
          style: TextStyle(
            fontWeight: _isUrdu ? FontWeight.w600 : FontWeight.bold,
            fontSize: _fs(17, 15),
            height: _isUrdu ? 1.5 : 1.2,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelPadding: const EdgeInsets.symmetric(horizontal: 4),
          tabs: _tabLabels
              .map(
                (label) => Tab(
                  child: FittedBox(
                    fit: BoxFit.scaleDown, // shrinks text to fit, never clips
                    child: Text(
                      label,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: _fs(12.5, 10.5),
                        fontWeight:
                            _isUrdu ? FontWeight.w500 : FontWeight.bold,
                        height: _isUrdu ? 1.5 : 1.2,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: widget.info.colorTag == 'green'
            ? [
                _buildOverviewTab(),
                _buildRoutineCareTab(0),
                _buildRoutineCareTab(1),
                _buildRoutineCareTab(2),
              ]
            : [
                _buildOverviewTab(),
                _buildSpreadTab(),
                _buildPreventionTab(),
                _buildTreatmentTab(),
              ],
      ),
    );
  }

  // ----------------------------------------------------------
  // TAB 1: OVERVIEW
  // ----------------------------------------------------------
  Widget _buildOverviewTab() {
    final info = widget.info;
    final isHealthy = info.colorTag == 'green';
    final lang = _currentLang;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: _primaryColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Text(
                  info.emoji,
                  style: const TextStyle(fontSize: 42),
                ),
                const SizedBox(height: 6),
                Text(
                  info.diseaseName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _fs(20, 18),
                    fontWeight: _isUrdu ? FontWeight.w600 : FontWeight.bold,
                    height: _isUrdu ? 1.6 : 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  info.pathogen,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: _fs(12, 11),
                    height: _isUrdu ? 1.6 : 1.3,
                    fontStyle: _isUrdu ? FontStyle.normal : FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          if (isHealthy) ...[
            _buildInfoCard(
              icon: Icons.check_circle,
              iconColor: _Palette.darkGreen,
              title: AppStrings.healthyTitle(lang),
              content: AppStrings.healthyDesc(lang),
            ),
            const SizedBox(height: 10),
          ],

          // Overview card
          _buildSectionCard(
            title: AppStrings.overviewSectionTitle(lang),
            children: [
              _buildDetailRow(AppStrings.typeLabel(lang), info.diseaseType),
              _buildDetailRow(AppStrings.affectsLabel(lang), info.affects),
              _buildDetailRow(AppStrings.riskLabel(lang), info.risk),
              _buildDetailRow(
                AppStrings.severityLabel(lang),
                AppStrings.severityValue(info.severity, lang),
                valueColor: _severityColor(info.severity),
              ),
              if (!isHealthy)
                _buildDetailRow(AppStrings.foundInPkLabel(lang), info.foundInPk),
            ],
          ),

          const SizedBox(height: 10),

          // Source
          _buildSectionCard(
            title: AppStrings.dataSourceLabel(lang),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Icon(Icons.verified, color: _accentTextColor, size: 16),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      info.source,
                      style: TextStyle(
                        fontSize: 12.5,
                        height: 1.35,
                        color: _accentTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          if (!isHealthy) ...[
            const SizedBox(height: 10),
            // Warning for HLB
            if (info.colorTag == 'red')
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: _Palette.yellowLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _Palette.yellow, width: 1.5),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(Icons.warning_amber_rounded,
                          color: _Palette.yellowDark, size: 22),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        AppStrings.hlbWarning(lang),
                        softWrap: true,
                        style: TextStyle(
                          fontSize: _fs(12.5, 11.5),
                          height: _isUrdu ? 1.7 : 1.4,
                          color: _Palette.yellowDark,
                          fontWeight:
                              _isUrdu ? FontWeight.w500 : FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 10),

            // Quick treatment hint
            _buildInfoCard(
              icon: Icons.info_outline,
              iconColor: _accentTextColor,
              title: AppStrings.tabsNavHintTitle(lang),
              content: AppStrings.tabsNavHintDesc(lang),
            ),
          ],

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // TAB 2: SPREAD
  // ----------------------------------------------------------
  Widget _buildSpreadTab() {
    final lang = _currentLang;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabHeader(
            icon: Icons.bug_report,
            title: AppStrings.howItSpreadsTitle(lang),
            subtitle: AppStrings.spreadSubtitle(lang),
          ),
          const SizedBox(height: 12),
          _buildSectionCard(
            title: AppStrings.spreadDetailsTitle(lang),
            children: widget.info.spreadInfo
                .map((line) => _buildSpreadItem(line))
                .toList(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // TAB 3: PREVENTION
  // ----------------------------------------------------------
  Widget _buildPreventionTab() {
    final lang = _currentLang;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabHeader(
            icon: Icons.shield,
            title: AppStrings.preventionTitle(lang),
            subtitle: AppStrings.preventionSubtitle(lang),
          ),
          const SizedBox(height: 12),
          ...widget.info.preventionSteps.asMap().entries.map((entry) {
            return _buildPreventionStep(
              number: entry.key + 1,
              text: entry.value,
              isFirst: entry.key == 0,
            );
          }),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // TAB 4: TREATMENT (Stage-Based)
  // ----------------------------------------------------------
  Widget _buildTreatmentTab() {
    final lang = _currentLang;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabHeader(
            icon: Icons.medical_services,
            title: AppStrings.treatmentTitle(lang),
            subtitle: AppStrings.treatmentSubtitle(lang),
          ),
          const SizedBox(height: 12),
          ...widget.info.stages.map((stage) => _buildStageCard(stage)),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // TAB: ROUTINE CARE (Healthy only)
  // ----------------------------------------------------------
  Widget _buildRoutineCareTab(int tabIndex) {
    final lang = _currentLang;
    final routineCare = widget.info.routineCare;
    if (routineCare == null || tabIndex >= routineCare.length) {
      return const SizedBox.shrink();
    }

    final care = routineCare[tabIndex];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabHeader(
            icon: Icons.calendar_today,
            title: AppStrings.careTitle(care.tabName, lang),
            subtitle: AppStrings.routineCareSubtitle(lang),
          ),
          const SizedBox(height: 12),
          ...care.items.asMap().entries.map((entry) {
            return _buildRoutineCareItem(
              number: entry.key + 1,
              text: entry.value,
            );
          }),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // STAGE CARD
  // ----------------------------------------------------------
  Widget _buildStageCard(TreatmentStage stage) {
    Color stageAccent;
    Color stageBg;
    String stageEmoji;
    final lang = _currentLang;

    switch (stage.stageColor) {
      case 'early':
        stageAccent = _Palette.yellow;
        stageBg = _Palette.yellowLight;
        stageEmoji = '🟡';
        break;
      case 'moderate':
        stageAccent = _Palette.orange;
        stageBg = _Palette.orangeLight;
        stageEmoji = '🟠';
        break;
      case 'severe':
      default:
        stageAccent = _Palette.deepOrange;
        stageBg = _Palette.orangeLight;
        stageEmoji = '🔶';
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: stageAccent, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: stageAccent.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stage header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            decoration: BoxDecoration(
              color: stageAccent,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Text(stageEmoji, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    stage.stageName,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: _isUrdu ? FontWeight.w600 : FontWeight.bold,
                      fontSize: _fs(15, 13),
                      height: _isUrdu ? 1.6 : 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Signs
                _buildSubSection(
                  title: AppStrings.signsTitle(lang),
                  bgColor: stageBg,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: stage.signs
                        .map((sign) => _buildBulletItem(sign, stageAccent))
                        .toList(),
                  ),
                ),

                const SizedBox(height: 10),

                // Treatments
                _buildSubSection(
                  title: AppStrings.sprayTitle(lang),
                  bgColor: stageBg,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: stage.treatments
                        .map((t) => _buildTreatmentItem(t, stageAccent))
                        .toList(),
                  ),
                ),

                const SizedBox(height: 10),

                // Actions
                if (stage.actions.isNotEmpty) ...[
                  _buildSubSection(
                    title: AppStrings.actionsTitle(lang),
                    bgColor: stageBg,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: stage.actions
                          .map((a) => _buildBulletItem(a, stageAccent))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],

                // Follow-up + Source
                Row(
                  children: [
                    Expanded(
                      child: _buildPillChip(
                        icon: Icons.update,
                        label: stage.followUp,
                        color: stage.stageColor == 'early'
                            ? _Palette.yellowDark
                            : stageAccent,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Text(
                  '${AppStrings.sourceLabel(lang)}: ${stage.source}',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                    fontStyle: _isUrdu ? FontStyle.normal : FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // HELPERS
  // ----------------------------------------------------------

  Widget _buildTabHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _lightColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _primaryColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: _accentTextColor, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: _accentTextColor,
                    fontWeight: _isUrdu ? FontWeight.w600 : FontWeight.bold,
                    fontSize: _fs(15, 13),
                    height: _isUrdu ? 1.6 : 1.3,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: _accentTextColor.withValues(alpha: 0.75),
                    fontSize: _fs(11.5, 10),
                    height: _isUrdu ? 1.6 : 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
            child: Text(
              title,
              style: TextStyle(
                color: _accentTextColor,
                fontWeight: _isUrdu ? FontWeight.w600 : FontWeight.bold,
                fontSize: _fs(14, 12.5),
                height: _isUrdu ? 1.6 : 1.3,
              ),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _lightColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _primaryColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: _isUrdu ? FontWeight.w600 : FontWeight.bold,
                    fontSize: _fs(13.5, 12),
                    height: _isUrdu ? 1.6 : 1.3,
                    color: _accentTextColor,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: _fs(12.5, 11.5),
                    height: _isUrdu ? 1.7 : 1.4,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: _fs(12.5, 11.5),
                height: _isUrdu ? 1.6 : 1.3,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              softWrap: true,
              style: TextStyle(
                fontSize: _fs(12.5, 11.5),
                height: _isUrdu ? 1.7 : 1.35,
                fontWeight: FontWeight.w500,
                color: valueColor ?? Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpreadItem(String line) {
    final colonIdx = line.indexOf(':');
    if (colonIdx != -1) {
      final key = line.substring(0, colonIdx + 1).trim();
      final val = line.substring(colonIdx + 1).trim();
      final rtl = Directionality.of(context) == TextDirection.rtl;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              rtl ? Icons.arrow_left : Icons.arrow_right,
              color: _accentTextColor,
              size: 18,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$key ',
                      style: TextStyle(
                        fontWeight:
                            _isUrdu ? FontWeight.w600 : FontWeight.bold,
                        color: _accentTextColor,
                        fontSize: _fs(12.5, 11.5),
                        height: _isUrdu ? 1.7 : 1.4,
                      ),
                    ),
                    TextSpan(
                      text: val,
                      style: TextStyle(
                        fontSize: _fs(12.5, 11.5),
                        height: _isUrdu ? 1.7 : 1.4,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    return _buildBulletItem(line, _primaryColor);
  }

  Widget _buildPreventionStep({
    required int number,
    required String text,
    bool isFirst = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: isFirst ? _lightColor : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isFirst ? _primaryColor : Colors.grey.shade200,
          width: isFirst ? 1.5 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _primaryColor,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              softWrap: true,
              style: TextStyle(
                fontSize: _fs(12.5, 11.5),
                height: _isUrdu ? 1.7 : 1.4,
                color: Colors.black87,
                fontWeight: isFirst
                    ? (_isUrdu ? FontWeight.w500 : FontWeight.w600)
                    : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutineCareItem({required int number, required String text}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(Icons.check_circle_outline,
                color: _accentTextColor, size: 18),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              softWrap: true,
              style: TextStyle(
                fontSize: _fs(12.5, 11.5),
                height: _isUrdu ? 1.7 : 1.4,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubSection({
    required String title,
    required Color bgColor,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: _isUrdu ? FontWeight.w600 : FontWeight.bold,
            fontSize: _fs(13, 11.5),
            height: _isUrdu ? 1.6 : 1.3,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _buildBulletItem(String text, Color bulletColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: bulletColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              text,
              softWrap: true,
              style: TextStyle(
                fontSize: _fs(12, 11),
                height: _isUrdu ? 1.7 : 1.38,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreatmentItem(TreatmentItem item, Color accentColor) {
    final noteColor =
        accentColor == _Palette.yellow ? _Palette.yellowDark : accentColor;
    final lang = _currentLang;

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accentColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Icon(Icons.medication, color: noteColor, size: 15),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  item.name,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: _isUrdu ? FontWeight.w600 : FontWeight.bold,
                    fontSize: _fs(12.5, 11.5),
                    height: _isUrdu ? 1.6 : 1.35,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          _buildTreatmentDetail(AppStrings.doseLabel(lang), item.dose),
          if (item.timing != null)
            _buildTreatmentDetail(AppStrings.timingLabel(lang), item.timing!),
          if (item.note != null)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                '⚠ ${item.note}',
                softWrap: true,
                style: TextStyle(
                  fontSize: _fs(11.5, 10.5),
                  height: _isUrdu ? 1.7 : 1.35,
                  color: noteColor,
                  fontStyle: _isUrdu ? FontStyle.normal : FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTreatmentDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: _fs(11.5, 10.5),
              height: _isUrdu ? 1.7 : 1.3,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          Expanded(
            child: Text(
              value,
              softWrap: true,
              style: TextStyle(
                fontSize: _fs(11.5, 10.5),
                height: _isUrdu ? 1.7 : 1.35,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPillChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 13),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              label,
              softWrap: true,
              style: TextStyle(
                fontSize: _fs(11.5, 10.5),
                height: _isUrdu ? 1.6 : 1.3,
                color: color,
                fontWeight: _isUrdu ? FontWeight.w500 : FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _severityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
      case 'انتہائی شدید (کریٹیکل)':
        return _Palette.deepOrange;
      case 'high':
      case 'شدید':
        return _Palette.orange;
      case 'medium':
      case 'درمیانہ':
        return _Palette.yellowDark;
      case 'none':
      case 'کوئی نہیں':
        return _Palette.darkGreen;
      default:
        return Colors.black87;
    }
  }
}