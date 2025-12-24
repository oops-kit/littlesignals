import 'package:littlesignals/l10n/app_localizations.dart';

/// Z점수 라벨 생성 서비스
///
/// SRP: Z점수에 대한 부모용 라벨 생성만 담당합니다.
class ZScoreLabelProvider {
  const ZScoreLabelProvider._();

  /// MER Z점수에 대한 부모용 라벨
  static String getMerLabel(double z, AppLocalizations l10n) {
    if (z >= -1 && z <= 1) {
      return l10n.peerAverage;
    } else if (z > 1) {
      return l10n.highMemoryEfficiency;
    } else {
      return l10n.developingMemory;
    }
  }

  /// 재확인율 Z점수에 대한 부모용 라벨
  static String getRevisitLabel(double z, AppLocalizations l10n) {
    if (z >= -1 && z <= 1) {
      return l10n.peerAverage;
    } else if (z > 1) {
      return l10n.stableMemory;
    } else {
      return l10n.activeExploration;
    }
  }

  /// 억제 비율 Z점수에 대한 부모용 라벨
  static String getInhibitionLabel(double z, AppLocalizations l10n) {
    if (z >= -1 && z <= 1) {
      return l10n.peerAverage;
    } else if (z > 1) {
      return l10n.goodSelfControl;
    } else {
      return l10n.highEnergy;
    }
  }
}

