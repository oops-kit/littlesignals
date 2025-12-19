import 'package:littlesignals/models/card_data.dart';

/// 카드 덱 생성 인터페이스
///
/// DIP를 위한 추상화입니다.
/// 주의력 테스트용 카드 덱을 생성하는 역할을 담당합니다.
abstract class DeckGenerator {
  /// 지정된 쌍 수만큼의 카드 덱 생성
  ///
  /// [pairCount]: 생성할 카드 쌍의 수
  /// 반환: 섞인 카드 리스트
  List<CardData> generate(int pairCount);
}
