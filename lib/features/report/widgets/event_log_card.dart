import 'package:flutter/material.dart';
import 'package:littlesignals/core/theme/app_theme.dart';
import 'package:littlesignals/l10n/app_localizations.dart';
import 'package:littlesignals/models/test_event_log.dart';

/// 이벤트 로그 카드 위젯
///
/// 테스트 중 발생한 이벤트들의 타임라인을 표시합니다.
class EventLogCard extends StatefulWidget {
  const EventLogCard({super.key, required this.eventLogs, this.startTime});

  final List<TestEventLog> eventLogs;
  final DateTime? startTime;

  @override
  State<EventLogCard> createState() => _EventLogCardState();
}

class _EventLogCardState extends State<EventLogCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // 중요한 이벤트만 필터링 (카드 뒤집기는 너무 많으므로 제외)
    final importantLogs = widget.eventLogs.where((log) {
      return log.type != TestEventType.cardFlip &&
          log.type != TestEventType.blueBalloonTap;
    }).toList();

    final displayLogs = _isExpanded ? widget.eventLogs : importantLogs;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.slate100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 헤더
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Icon(Icons.history, color: AppTheme.slate400, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.eventLog,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.slate600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() => _isExpanded = !_isExpanded),
                  child: Text(
                    _isExpanded ? l10n.showLess : l10n.showAll,
                    style: TextStyle(fontSize: 12, color: AppTheme.primaryBlue),
                  ),
                ),
              ],
            ),
          ),
          // 로그 목록
          if (displayLogs.isEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Text(
                l10n.noEventsRecorded,
                style: const TextStyle(fontSize: 14, color: AppTheme.slate400),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              itemCount: displayLogs.length,
              itemBuilder: (context, index) {
                final log = displayLogs[index];
                return _EventLogItem(
                  log: log,
                  startTime: widget.startTime,
                  isLast: index == displayLogs.length - 1,
                );
              },
            ),
        ],
      ),
    );
  }
}

/// 개별 이벤트 로그 항목
class _EventLogItem extends StatelessWidget {
  const _EventLogItem({
    required this.log,
    required this.startTime,
    required this.isLast,
  });

  final TestEventLog log;
  final DateTime? startTime;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final elapsedSeconds = startTime != null
        ? log.timestamp.difference(startTime!).inMilliseconds / 1000.0
        : 0.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 타임라인 인디케이터
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: _getEventColor(log.type),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  _getEventIcon(log.type),
                  size: 8,
                  color: Colors.white,
                ),
              ),
            ),
            if (!isLast)
              Container(width: 2, height: 32, color: AppTheme.slate100),
          ],
        ),
        const SizedBox(width: 12),
        // 이벤트 내용
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${elapsedSeconds.toStringAsFixed(1)}초',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.slate400,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getEventColor(log.type).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _getEventLabel(log.type),
                        style: TextStyle(
                          fontSize: 10,
                          color: _getEventColor(log.type),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  log.description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.slate600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _getEventColor(TestEventType type) {
    switch (type) {
      case TestEventType.matchSuccess:
      case TestEventType.blueBalloonTap:
      case TestEventType.levelComplete:
      case TestEventType.testComplete:
        return Colors.green;
      case TestEventType.matchFail:
      case TestEventType.redBalloonTap:
        return Colors.red;
      case TestEventType.randomTap:
      case TestEventType.immediateRepeat:
      case TestEventType.anticipatoryTap:
        return Colors.orange;
      case TestEventType.blueBalloonMiss:
        return Colors.grey;
      case TestEventType.cardFlip:
        return Colors.blue;
      case TestEventType.testStart:
        return AppTheme.primaryBlue;
    }
  }

  IconData _getEventIcon(TestEventType type) {
    switch (type) {
      case TestEventType.matchSuccess:
      case TestEventType.blueBalloonTap:
        return Icons.check;
      case TestEventType.matchFail:
      case TestEventType.redBalloonTap:
        return Icons.close;
      case TestEventType.randomTap:
      case TestEventType.anticipatoryTap:
        return Icons.touch_app;
      case TestEventType.immediateRepeat:
        return Icons.replay;
      case TestEventType.blueBalloonMiss:
        return Icons.visibility_off;
      case TestEventType.levelComplete:
      case TestEventType.testComplete:
        return Icons.star;
      case TestEventType.cardFlip:
        return Icons.flip;
      case TestEventType.testStart:
        return Icons.play_arrow;
    }
  }

  String _getEventLabel(TestEventType type) {
    switch (type) {
      case TestEventType.matchSuccess:
        return '매칭 성공';
      case TestEventType.matchFail:
        return '매칭 실패';
      case TestEventType.randomTap:
        return '무작위 터치';
      case TestEventType.immediateRepeat:
        return '반복 오류';
      case TestEventType.levelComplete:
        return '레벨 완료';
      case TestEventType.blueBalloonTap:
        return '터치 성공';
      case TestEventType.redBalloonTap:
        return '충동성';
      case TestEventType.blueBalloonMiss:
        return '부주의';
      case TestEventType.anticipatoryTap:
        return '예측 반응';
      case TestEventType.testStart:
        return '시작';
      case TestEventType.testComplete:
        return '완료';
      case TestEventType.cardFlip:
        return '카드 뒤집기';
    }
  }
}
