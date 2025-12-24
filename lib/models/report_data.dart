import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:littlesignals/models/z_score_result.dart';

part 'report_data.freezed.dart';

/// 리포트 화면에서 사용되는 데이터 모델
@freezed
abstract class ReportData with _$ReportData {
  const factory ReportData({
    /// 시각화용 점수 (0-100, Z점수 기반으로 변환됨)
    required double visualScore,

    /// 행동 스타일 제목
    required String title,

    /// 행동 스타일 설명
    required String description,

    /// 양육 팁 목록
    required List<String> tips,

    /// 그래프 왼쪽 라벨
    required String lowLabel,

    /// 그래프 오른쪽 라벨
    required String highLabel,

    /// Z점수 결과 (null이면 기존 방식 사용)
    ZScoreResult? zScoreResult,

    /// 주의력 분석 결과 (주의력 테스트인 경우)
    AttentionAnalysisResult? attentionAnalysis,

    /// 충동성 분석 결과 (충동성 테스트인 경우)
    ImpulsivityAnalysisResult? impulsivityAnalysis,
  }) = _ReportData;
}
