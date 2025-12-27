import 'package:littlesignals/core/constants/algorithm_config.dart';
import 'package:littlesignals/l10n/app_localizations.dart';

/// Z점수 라벨 생성 서비스
///
/// SRP: Z점수에 대한 부모용 라벨 생성만 담당합니다.
class ZScoreLabelProvider {
  const ZScoreLabelProvider._();

  /// MER Z점수에 대한 부모용 라벨
  static String getMerLabel(double z, AppLocalizations l10n) {
    if (_isWithinAverageRange(z)) {
      return l10n.peerAverage;
    } else if (z > ZScoreConfig.highThreshold) {
      return l10n.highMemoryEfficiency;
    } else {
      return l10n.developingMemory;
    }
  }

  /// 재확인율 Z점수에 대한 부모용 라벨
  static String getRevisitLabel(double z, AppLocalizations l10n) {
    if (_isWithinAverageRange(z)) {
      return l10n.peerAverage;
    } else if (z > ZScoreConfig.highThreshold) {
      return l10n.stableMemory;
    } else {
      return l10n.activeExploration;
    }
  }

  /// 억제 비율 Z점수에 대한 부모용 라벨
  static String getInhibitionLabel(double z, AppLocalizations l10n) {
    if (_isWithinAverageRange(z)) {
      return l10n.peerAverage;
    } else if (z > ZScoreConfig.highThreshold) {
      return l10n.goodSelfControl;
    } else {
      return l10n.highEnergy;
    }
  }

  /// 부주의(Omission) Z점수에 대한 부모용 라벨
  /// 주의: Z점수가 높을수록 집중력이 좋음 (방향 반전됨)
  static String getOmissionLabel(double z, AppLocalizations l10n) {
    if (_isWithinAverageRange(z)) {
      return l10n.peerAverage;
    } else if (z > ZScoreConfig.highThreshold) {
      return l10n.attentionGood;
    } else {
      return l10n.attentionNeeds;
    }
  }

  /// Z점수가 또래 평균 범위 내에 있는지 확인
  static bool _isWithinAverageRange(double z) {
    return z >= ZScoreConfig.averageLowerThreshold &&
        z <= ZScoreConfig.averageUpperThreshold;
  }
}
