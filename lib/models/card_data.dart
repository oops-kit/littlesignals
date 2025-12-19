import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_data.freezed.dart';

/// 주의력 테스트에서 사용되는 카드 데이터
@freezed
abstract class CardData with _$CardData {
  const factory CardData({
    required int id,
    required IconData icon,
    required String name,
    @Default(false) bool isFlipped,
    @Default(false) bool isMatched,
  }) = _CardData;
}
