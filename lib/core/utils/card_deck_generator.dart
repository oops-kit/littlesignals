import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:littlesignals/core/domain/deck_generator.dart';
import 'package:littlesignals/models/card_data.dart';

/// 카드 덱 생성 클래스
///
/// [DeckGenerator] 인터페이스의 기본 구현체입니다.
/// 주의력 테스트용 카드 덱을 생성합니다.
class CardDeckGenerator implements DeckGenerator {
  CardDeckGenerator({this.icons = defaultIcons});

  /// 사용할 아이콘 목록
  final List<IconData> icons;

  /// 기본 아이콘 목록 (동물 아이콘)
  static const List<IconData> defaultIcons = [
    MaterialCommunityIcons.rabbit, // 토끼
    MaterialCommunityIcons.cat, // 고양이
    MaterialCommunityIcons.dog, // 강아지
    MaterialCommunityIcons.fish, // 물고기
  ];

  /// 지정된 쌍 수만큼의 카드 덱 생성
  ///
  /// [pairCount]: 생성할 카드 쌍의 수
  /// 반환: 섞인 카드 리스트
  @override
  List<CardData> generate(int pairCount) {
    final selectedIcons = icons.sublist(0, pairCount.clamp(1, icons.length));

    final List<CardData> deck = [];
    for (int i = 0; i < selectedIcons.length; i++) {
      deck.add(CardData(id: i * 2, icon: selectedIcons[i], name: 'animal-$i'));
      deck.add(
        CardData(id: i * 2 + 1, icon: selectedIcons[i], name: 'animal-$i'),
      );
    }
    deck.shuffle();

    return deck;
  }
}
