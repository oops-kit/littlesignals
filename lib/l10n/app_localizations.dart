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
  /// **'높은 에너지'**
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
