import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko'),
  ];

  /// 앱 제목
  ///
  /// In ko, this message translates to:
  /// **'리틀시그널'**
  String get appTitle;

  /// No description provided for @landingSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'의학적 진단이 아닌 관찰 도구입니다'**
  String get landingSubtitle;

  /// No description provided for @childBirthday.
  ///
  /// In ko, this message translates to:
  /// **'아이의 생년월일'**
  String get childBirthday;

  /// No description provided for @startButton.
  ///
  /// In ko, this message translates to:
  /// **'시작하기'**
  String get startButton;

  /// No description provided for @selectObservation.
  ///
  /// In ko, this message translates to:
  /// **'무엇을 관찰할까요?'**
  String get selectObservation;

  /// No description provided for @selectActivityDesc.
  ///
  /// In ko, this message translates to:
  /// **'아이를 위한 놀이를 선택해주세요.'**
  String get selectActivityDesc;

  /// No description provided for @attentionTitle.
  ///
  /// In ko, this message translates to:
  /// **'집중력 관찰'**
  String get attentionTitle;

  /// No description provided for @attentionDesc.
  ///
  /// In ko, this message translates to:
  /// **'아이가 하나에 진득하게 집중하지 못하나요?'**
  String get attentionDesc;

  /// No description provided for @impulsivityTitle.
  ///
  /// In ko, this message translates to:
  /// **'참기/조절 관찰'**
  String get impulsivityTitle;

  /// No description provided for @impulsivityDesc.
  ///
  /// In ko, this message translates to:
  /// **'하지 말라고 해도 자꾸 손이 먼저 나가나요?'**
  String get impulsivityDesc;

  /// No description provided for @startActivity.
  ///
  /// In ko, this message translates to:
  /// **'놀이 시작'**
  String get startActivity;

  /// No description provided for @doNotDisturbNotice.
  ///
  /// In ko, this message translates to:
  /// **'방해 금지 모드를 켜주세요.'**
  String get doNotDisturbNotice;

  /// No description provided for @warmUp.
  ///
  /// In ko, this message translates to:
  /// **'워밍업'**
  String get warmUp;

  /// No description provided for @warmUpDesc.
  ///
  /// In ko, this message translates to:
  /// **'아이가 3개의 버블을 터치하게 해주세요!'**
  String get warmUpDesc;

  /// No description provided for @pop.
  ///
  /// In ko, this message translates to:
  /// **'펑!'**
  String get pop;

  /// No description provided for @findAnimalFriends.
  ///
  /// In ko, this message translates to:
  /// **'동물 친구 찾기'**
  String get findAnimalFriends;

  /// No description provided for @exit.
  ///
  /// In ko, this message translates to:
  /// **'나가기'**
  String get exit;

  /// No description provided for @level.
  ///
  /// In ko, this message translates to:
  /// **'레벨'**
  String get level;

  /// No description provided for @balloonGame.
  ///
  /// In ko, this message translates to:
  /// **'풍선 놀이'**
  String get balloonGame;

  /// No description provided for @getReady.
  ///
  /// In ko, this message translates to:
  /// **'준비!'**
  String get getReady;

  /// No description provided for @observationSummary.
  ///
  /// In ko, this message translates to:
  /// **'관찰 요약'**
  String get observationSummary;

  /// No description provided for @behaviorStyle.
  ///
  /// In ko, this message translates to:
  /// **'행동 유형'**
  String get behaviorStyle;

  /// No description provided for @steadyExplorer.
  ///
  /// In ko, this message translates to:
  /// **'차분한 탐험가'**
  String get steadyExplorer;

  /// No description provided for @steadyExplorerDesc.
  ///
  /// In ko, this message translates to:
  /// **'또래 기준으로 집중력이 좋은 편이에요. 체계적으로 짝을 찾았어요.'**
  String get steadyExplorerDesc;

  /// No description provided for @freeExplorer.
  ///
  /// In ko, this message translates to:
  /// **'자유로운 탐험가'**
  String get freeExplorer;

  /// No description provided for @freeExplorerDesc.
  ///
  /// In ko, this message translates to:
  /// **'오래 집중하기보다 빠르게 탐색하는 것을 좋아해요. 이 나이에 흔한 모습이에요.'**
  String get freeExplorerDesc;

  /// No description provided for @carefulObserver.
  ///
  /// In ko, this message translates to:
  /// **'신중한 관찰자'**
  String get carefulObserver;

  /// No description provided for @carefulObserverDesc.
  ///
  /// In ko, this message translates to:
  /// **'행동하기 전에 기다리고 확인하는 능력이 좋아요.'**
  String get carefulObserverDesc;

  /// No description provided for @highEnergyLeader.
  ///
  /// In ko, this message translates to:
  /// **'에너지 넘치는 돌격대장'**
  String get highEnergyLeader;

  /// No description provided for @highEnergyLeaderDesc.
  ///
  /// In ko, this message translates to:
  /// **'열정과 속도로 반응해요! 멈추고 기다리는 것은 아직 발달 중이에요.'**
  String get highEnergyLeaderDesc;

  /// No description provided for @typicalRangeForAge.
  ///
  /// In ko, this message translates to:
  /// **'3-4세 또래 범위'**
  String get typicalRangeForAge;

  /// No description provided for @comparisonDesc.
  ///
  /// In ko, this message translates to:
  /// **'또래 발달 기준과의 비교입니다.'**
  String get comparisonDesc;

  /// No description provided for @freeSpirit.
  ///
  /// In ko, this message translates to:
  /// **'자유로운 영혼'**
  String get freeSpirit;

  /// No description provided for @deepFocus.
  ///
  /// In ko, this message translates to:
  /// **'깊은 집중'**
  String get deepFocus;

  /// No description provided for @highEnergy.
  ///
  /// In ko, this message translates to:
  /// **'에너지가 많음'**
  String get highEnergy;

  /// No description provided for @calmControl.
  ///
  /// In ko, this message translates to:
  /// **'차분한 조절'**
  String get calmControl;

  /// No description provided for @parentingTips.
  ///
  /// In ko, this message translates to:
  /// **'양육 팁'**
  String get parentingTips;

  /// No description provided for @attentionTip1.
  ///
  /// In ko, this message translates to:
  /// **'한 번에 장난감 하나만 꺼내서 깊이 놀게 해주세요.'**
  String get attentionTip1;

  /// No description provided for @attentionTip2.
  ///
  /// In ko, this message translates to:
  /// **'짧은 이야기를 읽고 간단한 질문을 해서 작업 기억을 키워주세요.'**
  String get attentionTip2;

  /// No description provided for @impulsivityTip1.
  ///
  /// In ko, this message translates to:
  /// **'\"그대로 멈춰라\" 놀이로 신호에 맞춰 멈추는 연습을 해보세요.'**
  String get impulsivityTip1;

  /// No description provided for @impulsivityTip2.
  ///
  /// In ko, this message translates to:
  /// **'일상에서 순서 기다리기를 연습해보세요. (예: 엘리베이터 버튼)'**
  String get impulsivityTip2;

  /// No description provided for @observeAnotherTrait.
  ///
  /// In ko, this message translates to:
  /// **'다른 특성 관찰하기'**
  String get observeAnotherTrait;

  /// No description provided for @getFreeReport.
  ///
  /// In ko, this message translates to:
  /// **'무료로 관찰 보고서 받기'**
  String get getFreeReport;

  /// No description provided for @disclaimer.
  ///
  /// In ko, this message translates to:
  /// **'이 결과는 의학적 진단이 아닙니다. 결과는 아이의 수면, 배고픔, 기분에 따라 달라질 수 있습니다.'**
  String get disclaimer;

  /// No description provided for @stopGame.
  ///
  /// In ko, this message translates to:
  /// **'놀이를 중단할까요?'**
  String get stopGame;

  /// No description provided for @progressWillBeLost.
  ///
  /// In ko, this message translates to:
  /// **'진행 상황이 사라집니다.'**
  String get progressWillBeLost;

  /// No description provided for @cancel.
  ///
  /// In ko, this message translates to:
  /// **'취소'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In ko, this message translates to:
  /// **'확인'**
  String get confirm;

  /// No description provided for @enterBirthday.
  ///
  /// In ko, this message translates to:
  /// **'생년월일을 입력해주세요'**
  String get enterBirthday;

  /// No description provided for @observationDataPoints.
  ///
  /// In ko, this message translates to:
  /// **'관찰 데이터'**
  String get observationDataPoints;

  /// No description provided for @randomTapping.
  ///
  /// In ko, this message translates to:
  /// **'무작위 터치'**
  String get randomTapping;

  /// No description provided for @randomTappingDesc.
  ///
  /// In ko, this message translates to:
  /// **'위치를 기억하려고 하지 않고 마구잡이로 터치한 횟수'**
  String get randomTappingDesc;

  /// No description provided for @sustainability.
  ///
  /// In ko, this message translates to:
  /// **'지속성'**
  String get sustainability;

  /// No description provided for @sustainabilityDesc.
  ///
  /// In ko, this message translates to:
  /// **'전반부와 후반부의 반응 속도 비교'**
  String get sustainabilityDesc;

  /// No description provided for @errorType.
  ///
  /// In ko, this message translates to:
  /// **'오류 유형'**
  String get errorType;

  /// No description provided for @errorTypeDesc.
  ///
  /// In ko, this message translates to:
  /// **'방금 확인한 카드를 기억하지 못하고 바로 다시 누른 횟수'**
  String get errorTypeDesc;

  /// No description provided for @times.
  ///
  /// In ko, this message translates to:
  /// **'회'**
  String get times;

  /// No description provided for @firstHalf.
  ///
  /// In ko, this message translates to:
  /// **'전반부'**
  String get firstHalf;

  /// No description provided for @secondHalf.
  ///
  /// In ko, this message translates to:
  /// **'후반부'**
  String get secondHalf;

  /// No description provided for @seconds.
  ///
  /// In ko, this message translates to:
  /// **'초'**
  String get seconds;

  /// No description provided for @sustainabilityGood.
  ///
  /// In ko, this message translates to:
  /// **'집중력이 일정하게 유지되었어요'**
  String get sustainabilityGood;

  /// No description provided for @sustainabilityDecline.
  ///
  /// In ko, this message translates to:
  /// **'후반부에 집중력이 떨어지는 경향이 보여요'**
  String get sustainabilityDecline;

  /// No description provided for @workingMemoryGood.
  ///
  /// In ko, this message translates to:
  /// **'작업 기억력이 좋아요'**
  String get workingMemoryGood;

  /// No description provided for @workingMemoryLimited.
  ///
  /// In ko, this message translates to:
  /// **'작업 기억에 어려움이 있을 수 있어요'**
  String get workingMemoryLimited;

  /// No description provided for @attentionFocused.
  ///
  /// In ko, this message translates to:
  /// **'체계적으로 카드를 찾았어요'**
  String get attentionFocused;

  /// No description provided for @attentionRandom.
  ///
  /// In ko, this message translates to:
  /// **'무작위로 터치하는 경향이 보여요'**
  String get attentionRandom;

  /// No description provided for @commissionError.
  ///
  /// In ko, this message translates to:
  /// **'충동성 (빨간 풍선 터치)'**
  String get commissionError;

  /// No description provided for @commissionErrorDesc.
  ///
  /// In ko, this message translates to:
  /// **'빨간 풍선이 나왔을 때 손이 먼저 나간 횟수'**
  String get commissionErrorDesc;

  /// No description provided for @omissionError.
  ///
  /// In ko, this message translates to:
  /// **'부주의 (파란 풍선 놓침)'**
  String get omissionError;

  /// No description provided for @omissionErrorDesc.
  ///
  /// In ko, this message translates to:
  /// **'파란 풍선이 나왔는데 딴청 피우다 놓친 횟수'**
  String get omissionErrorDesc;

  /// No description provided for @reactionTime.
  ///
  /// In ko, this message translates to:
  /// **'반응 시간'**
  String get reactionTime;

  /// No description provided for @reactionTimeDesc.
  ///
  /// In ko, this message translates to:
  /// **'풍선이 뜨기 전에 화면을 누르는지 확인'**
  String get reactionTimeDesc;

  /// No description provided for @averageReactionTime.
  ///
  /// In ko, this message translates to:
  /// **'평균 반응 시간'**
  String get averageReactionTime;

  /// No description provided for @anticipatoryResponse.
  ///
  /// In ko, this message translates to:
  /// **'예측 반응'**
  String get anticipatoryResponse;

  /// No description provided for @redBalloons.
  ///
  /// In ko, this message translates to:
  /// **'빨간 풍선'**
  String get redBalloons;

  /// No description provided for @impulseControlGood.
  ///
  /// In ko, this message translates to:
  /// **'충동 조절을 잘하고 있어요'**
  String get impulseControlGood;

  /// No description provided for @impulseControlNeeds.
  ///
  /// In ko, this message translates to:
  /// **'충동 조절 연습이 필요해요'**
  String get impulseControlNeeds;

  /// No description provided for @attentionGood.
  ///
  /// In ko, this message translates to:
  /// **'집중력이 좋아요'**
  String get attentionGood;

  /// No description provided for @attentionNeeds.
  ///
  /// In ko, this message translates to:
  /// **'주의 집중 연습이 필요해요'**
  String get attentionNeeds;

  /// No description provided for @anticipatoryResponseHigh.
  ///
  /// In ko, this message translates to:
  /// **'기다리지 못하고 미리 반응하는 경향이 있어요'**
  String get anticipatoryResponseHigh;

  /// No description provided for @anticipatoryResponseLow.
  ///
  /// In ko, this message translates to:
  /// **'기다렸다가 반응하는 것을 잘해요'**
  String get anticipatoryResponseLow;

  /// No description provided for @eventLog.
  ///
  /// In ko, this message translates to:
  /// **'이벤트 로그'**
  String get eventLog;

  /// No description provided for @showAll.
  ///
  /// In ko, this message translates to:
  /// **'전체 보기'**
  String get showAll;

  /// No description provided for @showLess.
  ///
  /// In ko, this message translates to:
  /// **'간략히 보기'**
  String get showLess;

  /// No description provided for @noEventsRecorded.
  ///
  /// In ko, this message translates to:
  /// **'기록된 이벤트가 없습니다'**
  String get noEventsRecorded;

  /// No description provided for @blueBalloonTap.
  ///
  /// In ko, this message translates to:
  /// **'터치!'**
  String get blueBalloonTap;

  /// No description provided for @redBalloonNoTap.
  ///
  /// In ko, this message translates to:
  /// **'터치 안 함!'**
  String get redBalloonNoTap;

  /// No description provided for @peerAverage.
  ///
  /// In ko, this message translates to:
  /// **'또래 평균'**
  String get peerAverage;

  /// No description provided for @highMemoryEfficiency.
  ///
  /// In ko, this message translates to:
  /// **'기억 효율이 높음'**
  String get highMemoryEfficiency;

  /// No description provided for @developingMemory.
  ///
  /// In ko, this message translates to:
  /// **'기억력 발달 중'**
  String get developingMemory;

  /// No description provided for @stableMemory.
  ///
  /// In ko, this message translates to:
  /// **'안정적인 기억 유지'**
  String get stableMemory;

  /// No description provided for @activeExploration.
  ///
  /// In ko, this message translates to:
  /// **'활발한 탐색'**
  String get activeExploration;

  /// No description provided for @goodSelfControl.
  ///
  /// In ko, this message translates to:
  /// **'참을성이 좋음'**
  String get goodSelfControl;

  /// No description provided for @carefulExplorerTitle.
  ///
  /// In ko, this message translates to:
  /// **'신중한 탐색가'**
  String get carefulExplorerTitle;

  /// No description provided for @carefulExplorerDesc.
  ///
  /// In ko, this message translates to:
  /// **'아이의 속도는 느릴 수 있지만, 한 번 본 정보는 잘 기억하고 신중하게 행동하는 편이에요.'**
  String get carefulExplorerDesc;

  /// No description provided for @quickProcessorTitle.
  ///
  /// In ko, this message translates to:
  /// **'빠른 처리형'**
  String get quickProcessorTitle;

  /// No description provided for @quickProcessorDesc.
  ///
  /// In ko, this message translates to:
  /// **'아이의 기억과 판단 속도가 또래에 비해 빠른 편이에요. 놀이를 금방 파악하고 활용하고 있어요.'**
  String get quickProcessorDesc;

  /// No description provided for @energeticExplorerTitle.
  ///
  /// In ko, this message translates to:
  /// **'에너지 탐색형'**
  String get energeticExplorerTitle;

  /// No description provided for @energeticExplorerDesc.
  ///
  /// In ko, this message translates to:
  /// **'아이에게는 새로운 것을 바로 확인하고 싶어 하는 에너지가 많이 느껴져요. 지금은 탐색이 더 중요한 시기일 수 있어요.'**
  String get energeticExplorerDesc;

  /// No description provided for @diligentTrierTitle.
  ///
  /// In ko, this message translates to:
  /// **'성실한 시도형'**
  String get diligentTrierTitle;

  /// No description provided for @diligentTrierDesc.
  ///
  /// In ko, this message translates to:
  /// **'아이 스스로 잘 해보려는 모습이 보여요. 다만 기억해야 할 정보가 아직은 조금 많은 단계일 수 있어요.'**
  String get diligentTrierDesc;

  /// No description provided for @confirmingMemoryTitle.
  ///
  /// In ko, this message translates to:
  /// **'확인형 기억 우수형'**
  String get confirmingMemoryTitle;

  /// No description provided for @confirmingMemoryDesc.
  ///
  /// In ko, this message translates to:
  /// **'아이의 기억력은 안정적인 편이에요. 다만 스스로 한 선택을 다시 확인하려는 신중함이 함께 나타나요.'**
  String get confirmingMemoryDesc;

  /// No description provided for @intuitiveGuesserTitle.
  ///
  /// In ko, this message translates to:
  /// **'직관적 추측형'**
  String get intuitiveGuesserTitle;

  /// No description provided for @intuitiveGuesserDesc.
  ///
  /// In ko, this message translates to:
  /// **'아이는 빠르게 진행하려는 경향이 있어요. 지금은 기억을 활용하기보다는 직관적으로 반응하는 모습이 더 두드러져요.'**
  String get intuitiveGuesserDesc;

  /// No description provided for @quickAndControlledTitle.
  ///
  /// In ko, this message translates to:
  /// **'빠르게 반응하지만 멈출 줄 아는 아이'**
  String get quickAndControlledTitle;

  /// No description provided for @quickAndControlledDesc.
  ///
  /// In ko, this message translates to:
  /// **'새로운 자극을 빠르게 포착해서 재빨리 반응할 수 있으면서도, 멈추라는 신호를 보면 잘 멈출 수 있어요.'**
  String get quickAndControlledDesc;

  /// No description provided for @energyFirstTitle.
  ///
  /// In ko, this message translates to:
  /// **'에너지가 먼저 나오는 아이'**
  String get energyFirstTitle;

  /// No description provided for @energyFirstDesc.
  ///
  /// In ko, this message translates to:
  /// **'재미있어 보이는 것은 일단 먼저 눌러 보고 싶은 마음이 큰 편이에요. 짧은 게임처럼 \'멈추기 신호\'를 연습하면 좋아요.'**
  String get energyFirstDesc;

  /// No description provided for @calmAndStableTitle.
  ///
  /// In ko, this message translates to:
  /// **'차분하고 안정적인 아이'**
  String get calmAndStableTitle;

  /// No description provided for @calmAndStableDesc.
  ///
  /// In ko, this message translates to:
  /// **'서두르기보다 한 번 더 보고, 생각한 뒤에 움직이는 편이에요. 규칙을 지키는 활동에서 강점을 보일 수 있어요.'**
  String get calmAndStableDesc;

  /// No description provided for @learningAtOwnPaceTitle.
  ///
  /// In ko, this message translates to:
  /// **'천천히 익혀가는 단계의 아이'**
  String get learningAtOwnPaceTitle;

  /// No description provided for @learningAtOwnPaceDesc.
  ///
  /// In ko, this message translates to:
  /// **'새로운 과제에서는 속도도 아직 느리고, 멈추기 규칙도 이제 막 익혀 가는 중이에요. 충분한 시간과 반복 기회를 주면 좋아요.'**
  String get learningAtOwnPaceDesc;

  /// No description provided for @carefulExplorerTip1.
  ///
  /// In ko, this message translates to:
  /// **'퍼즐이나 블록 놀이처럼 차근차근 완성해가는 활동을 즐겨보세요.'**
  String get carefulExplorerTip1;

  /// No description provided for @carefulExplorerTip2.
  ///
  /// In ko, this message translates to:
  /// **'아이의 속도를 존중하며 충분한 시간을 주세요.'**
  String get carefulExplorerTip2;

  /// No description provided for @quickProcessorTip1.
  ///
  /// In ko, this message translates to:
  /// **'새로운 규칙이 있는 게임을 시도해보세요. 빠르게 적응할 거예요.'**
  String get quickProcessorTip1;

  /// No description provided for @quickProcessorTip2.
  ///
  /// In ko, this message translates to:
  /// **'집중 시간이 길어질 수 있도록 점점 복잡한 활동을 도전해보세요.'**
  String get quickProcessorTip2;

  /// No description provided for @energeticExplorerTip1.
  ///
  /// In ko, this message translates to:
  /// **'탐색 에너지를 발산할 수 있는 야외 활동을 충분히 해주세요.'**
  String get energeticExplorerTip1;

  /// No description provided for @energeticExplorerTip2.
  ///
  /// In ko, this message translates to:
  /// **'짧은 집중 → 보상 → 짧은 집중 패턴으로 놀이해보세요.'**
  String get energeticExplorerTip2;

  /// No description provided for @diligentTrierTip1.
  ///
  /// In ko, this message translates to:
  /// **'작은 성공에도 격려해주세요. 노력하는 과정이 중요해요.'**
  String get diligentTrierTip1;

  /// No description provided for @diligentTrierTip2.
  ///
  /// In ko, this message translates to:
  /// **'한 번에 기억해야 할 양을 줄이고 반복해주세요.'**
  String get diligentTrierTip2;

  /// No description provided for @confirmingMemoryTip1.
  ///
  /// In ko, this message translates to:
  /// **'아이의 신중함을 인정해주고, 자신감을 가질 수 있도록 격려해주세요.'**
  String get confirmingMemoryTip1;

  /// No description provided for @confirmingMemoryTip2.
  ///
  /// In ko, this message translates to:
  /// **'한 번 선택하면 그대로 진행해보는 연습을 놀이처럼 해보세요.'**
  String get confirmingMemoryTip2;

  /// No description provided for @intuitiveGuesserTip1.
  ///
  /// In ko, this message translates to:
  /// **'기억 게임을 짧게 자주 반복하여 기억 전략을 연습해보세요.'**
  String get intuitiveGuesserTip1;

  /// No description provided for @intuitiveGuesserTip2.
  ///
  /// In ko, this message translates to:
  /// **'천천히 생각하고 선택하는 것도 재미있다는 것을 알려주세요.'**
  String get intuitiveGuesserTip2;

  /// No description provided for @quickAndControlledTip1.
  ///
  /// In ko, this message translates to:
  /// **'팀 놀이나 운동에서 \'선두이자 안전요원\' 역할을 맡겨보세요.'**
  String get quickAndControlledTip1;

  /// No description provided for @quickAndControlledTip2.
  ///
  /// In ko, this message translates to:
  /// **'신호에 따라 행동하는 게임을 더 즐겨보세요.'**
  String get quickAndControlledTip2;

  /// No description provided for @energyFirstTip1.
  ///
  /// In ko, this message translates to:
  /// **'\'그대로 멈춰라\' 같은 브레이크 연습 놀이를 해보세요.'**
  String get energyFirstTip1;

  /// No description provided for @energyFirstTip2.
  ///
  /// In ko, this message translates to:
  /// **'짧은 게임으로 \'멈추기 신호\' 연습을 반복해보세요.'**
  String get energyFirstTip2;

  /// No description provided for @calmAndStableTip1.
  ///
  /// In ko, this message translates to:
  /// **'차분한 성격을 활용한 집중 활동을 시도해보세요.'**
  String get calmAndStableTip1;

  /// No description provided for @calmAndStableTip2.
  ///
  /// In ko, this message translates to:
  /// **'새로운 도전 앞에서 작은 단계부터 속도를 올려보세요.'**
  String get calmAndStableTip2;

  /// No description provided for @learningAtOwnPaceTip1.
  ///
  /// In ko, this message translates to:
  /// **'같은 규칙을 여러 번, 짧게 나누어 연습해주세요.'**
  String get learningAtOwnPaceTip1;

  /// No description provided for @learningAtOwnPaceTip2.
  ///
  /// In ko, this message translates to:
  /// **'충분한 시간을 주고 아이의 속도에 맞춰주세요.'**
  String get learningAtOwnPaceTip2;

  /// No description provided for @peerRangeLabel.
  ///
  /// In ko, this message translates to:
  /// **'또래 평균 범위 (참고용)'**
  String get peerRangeLabel;

  /// No description provided for @peerRangeDesc.
  ///
  /// In ko, this message translates to:
  /// **'같은 나이 또래 아이들이 이 과제에서 보이는 대략적인 범위입니다. 범위를 벗어난다고 해서 이상을 뜻하지는 않으며, 아이의 반응 경향을 이해하기 위한 참고 자료입니다.'**
  String get peerRangeDesc;

  /// No description provided for @myChild.
  ///
  /// In ko, this message translates to:
  /// **'내 아이'**
  String get myChild;

  /// No description provided for @resultInterpretation.
  ///
  /// In ko, this message translates to:
  /// **'결과 해석'**
  String get resultInterpretation;

  /// No description provided for @whyThisResult.
  ///
  /// In ko, this message translates to:
  /// **'왜 이런 결과가 나왔나요?'**
  String get whyThisResult;

  /// No description provided for @whatItMeans.
  ///
  /// In ko, this message translates to:
  /// **'이 수치가 의미하는 것'**
  String get whatItMeans;

  /// No description provided for @merHighExplanation.
  ///
  /// In ko, this message translates to:
  /// **'아이가 카드 위치를 잘 기억하고 효율적으로 짝을 찾았어요. 작업기억이 또래보다 잘 발달되어 있어요.'**
  String get merHighExplanation;

  /// No description provided for @merAverageExplanation.
  ///
  /// In ko, this message translates to:
  /// **'아이가 또래와 비슷한 수준으로 카드 위치를 기억했어요. 연령에 맞는 정상적인 발달을 보이고 있어요.'**
  String get merAverageExplanation;

  /// No description provided for @merLowExplanation.
  ///
  /// In ko, this message translates to:
  /// **'카드 위치를 기억하는 데 조금 더 시간이 필요했어요. 반복 연습을 통해 기억력이 향상될 수 있어요.'**
  String get merLowExplanation;

  /// No description provided for @revisitLowExplanation.
  ///
  /// In ko, this message translates to:
  /// **'한 번 본 카드를 잘 기억해서 다시 뒤집는 경우가 적었어요. 안정적인 기억력을 보여주고 있어요.'**
  String get revisitLowExplanation;

  /// No description provided for @revisitAverageExplanation.
  ///
  /// In ko, this message translates to:
  /// **'가끔 확인한 카드를 다시 뒤집었지만, 또래와 비슷한 수준이에요.'**
  String get revisitAverageExplanation;

  /// No description provided for @revisitHighExplanation.
  ///
  /// In ko, this message translates to:
  /// **'확인한 카드를 다시 뒤집는 경우가 많았어요. 집중력이 흐트러졌거나 게임에 익숙해지는 중일 수 있어요.'**
  String get revisitHighExplanation;

  /// No description provided for @inhibitionHighExplanation.
  ///
  /// In ko, this message translates to:
  /// **'빨간 풍선을 잘 참았어요! 충동을 조절하는 능력이 또래보다 잘 발달되어 있어요.'**
  String get inhibitionHighExplanation;

  /// No description provided for @inhibitionAverageExplanation.
  ///
  /// In ko, this message translates to:
  /// **'빨간 풍선을 참는 것이 또래와 비슷한 수준이에요. 연령에 맞는 정상적인 발달을 보이고 있어요.'**
  String get inhibitionAverageExplanation;

  /// No description provided for @inhibitionLowExplanation.
  ///
  /// In ko, this message translates to:
  /// **'빨간 풍선을 참기 어려웠어요. 이 나이에는 자연스러운 반응이며, 연습을 통해 조절력이 향상될 수 있어요.'**
  String get inhibitionLowExplanation;

  /// No description provided for @omissionHighExplanation.
  ///
  /// In ko, this message translates to:
  /// **'파란 풍선을 잘 눌렀어요! 집중력이 또래보다 잘 발달되어 있어요.'**
  String get omissionHighExplanation;

  /// No description provided for @omissionAverageExplanation.
  ///
  /// In ko, this message translates to:
  /// **'파란 풍선에 반응하는 것이 또래와 비슷한 수준이에요. 연령에 맞는 정상적인 집중력을 보이고 있어요.'**
  String get omissionAverageExplanation;

  /// No description provided for @omissionLowExplanation.
  ///
  /// In ko, this message translates to:
  /// **'파란 풍선을 놓치는 경우가 있었어요. 이 나이에는 자연스러운 반응이며, 집중력 연습을 통해 향상될 수 있어요.'**
  String get omissionLowExplanation;

  /// No description provided for @reactionFastExplanation.
  ///
  /// In ko, this message translates to:
  /// **'반응이 빠른 편이에요. 빠른 반응은 좋지만, 때로는 신중함도 필요해요.'**
  String get reactionFastExplanation;

  /// No description provided for @reactionNormalExplanation.
  ///
  /// In ko, this message translates to:
  /// **'반응 속도가 또래와 비슷해요. 적절한 속도로 과제를 수행했어요.'**
  String get reactionNormalExplanation;

  /// No description provided for @reactionSlowExplanation.
  ///
  /// In ko, this message translates to:
  /// **'신중하게 생각하고 반응하는 편이에요. 정확성을 중시하는 성향일 수 있어요.'**
  String get reactionSlowExplanation;

  /// No description provided for @keyMetrics.
  ///
  /// In ko, this message translates to:
  /// **'핵심 지표'**
  String get keyMetrics;

  /// No description provided for @memoryEfficiencyRatio.
  ///
  /// In ko, this message translates to:
  /// **'기억 효율 (MER)'**
  String get memoryEfficiencyRatio;

  /// No description provided for @memoryEfficiencyRatioDesc.
  ///
  /// In ko, this message translates to:
  /// **'최소 이동 횟수 대비 실제 이동 횟수의 효율'**
  String get memoryEfficiencyRatioDesc;

  /// No description provided for @revisitingRate.
  ///
  /// In ko, this message translates to:
  /// **'재확인율'**
  String get revisitingRate;

  /// No description provided for @revisitingRateDesc.
  ///
  /// In ko, this message translates to:
  /// **'이미 확인한 카드를 다시 뒤집은 비율'**
  String get revisitingRateDesc;

  /// No description provided for @avgReactionTimeSec.
  ///
  /// In ko, this message translates to:
  /// **'평균 반응 시간'**
  String get avgReactionTimeSec;

  /// No description provided for @inhibitionRate.
  ///
  /// In ko, this message translates to:
  /// **'억제 비율'**
  String get inhibitionRate;

  /// No description provided for @inhibitionRateDesc.
  ///
  /// In ko, this message translates to:
  /// **'빨간 풍선을 정확히 참은 비율'**
  String get inhibitionRateDesc;

  /// No description provided for @peerAvgLabel.
  ///
  /// In ko, this message translates to:
  /// **'또래 평균'**
  String get peerAvgLabel;

  /// No description provided for @myChildValue.
  ///
  /// In ko, this message translates to:
  /// **'내 아이'**
  String get myChildValue;

  /// No description provided for @lowerIsBetter.
  ///
  /// In ko, this message translates to:
  /// **'(낮을수록 좋음)'**
  String get lowerIsBetter;

  /// No description provided for @higherIsBetter.
  ///
  /// In ko, this message translates to:
  /// **'(높을수록 좋음)'**
  String get higherIsBetter;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
