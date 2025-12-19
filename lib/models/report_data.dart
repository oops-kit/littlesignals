import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_data.freezed.dart';

/// 리포트 화면에서 사용되는 데이터 모델
@freezed
abstract class ReportData with _$ReportData {
  const factory ReportData({
    required double visualScore,
    required String title,
    required String description,
    required List<String> tips,
    required String lowLabel,
    required String highLabel,
  }) = _ReportData;
}
