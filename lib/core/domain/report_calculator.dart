import 'package:littlesignals/core/domain/test_result.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/report_data.dart';

/// 리포트 계산기 인터페이스
///
/// Strategy 패턴을 적용하여 테스트 타입별로 다른 계산 로직을 적용합니다.
/// OCP: 새 테스트 타입 추가 시 새 구현체만 추가하면 됩니다.
abstract class ReportCalculator {
  /// 테스트 결과를 기반으로 리포트 데이터를 계산합니다.
  ReportData calculate(TestResult result, AppLocalizations l10n);
}
