# Firebase Trigger Email from Firestore 가이드

## 목차

1. [개요](#개요)
2. [사전 준비](#사전-준비)
3. [확장 프로그램 설치](#확장-프로그램-설치)
4. [이메일 및 메타 정보 수집](#이메일-및-메타-정보-수집)
5. [Firestore 데이터 구조](#firestore-데이터-구조)
6. [이메일 발송 트리거](#이메일-발송-트리거)
7. [템플릿 시스템](#템플릿-시스템)
8. [스케줄링 서버를 통한 이메일 발송](#스케줄링-서버를-통한-이메일-발송)
9. [보안 설정](#보안-설정)
10. [모니터링 및 디버깅](#모니터링-및-디버깅)

---

## 개요

### Firebase Trigger Email from Firestore란?

Firebase의 공식 확장 프로그램으로, Firestore 컬렉션에 문서가 추가되면 자동으로 이메일을 발송합니다.

**주요 특징:**
- Firestore 문서 생성 시 자동 이메일 발송
- 템플릿 기반 이메일 지원
- SendGrid, Mailgun 등 다양한 SMTP 제공자 지원
- 발송 상태 추적 및 재시도 로직 내장
- 첨부파일 지원

**사용 사례:**
- 회원가입 환영 이메일
- 비밀번호 재설정 이메일
- 주문 확인 이메일
- 뉴스레터 발송
- 알림 이메일

---

## 사전 준비

### 1. Firebase 프로젝트 설정

```bash
# Firebase CLI 설치
npm install -g firebase-tools

# Firebase 로그인
firebase login

# 프로젝트 초기화
firebase init
```

### 2. Blaze 플랜 업그레이드

Firebase Extensions는 Blaze (종량제) 플랜이 필요합니다.

```
Firebase Console → 프로젝트 설정 → 사용량 및 결제 → Blaze 플랜으로 업그레이드
```

### 3. SendGrid 계정 및 API 키

1. [SendGrid](https://sendgrid.com) 계정 생성
2. API 키 발급:
   ```
   Settings → API Keys → Create API Key
   ```
3. 권한 설정:
   - **Mail Send**: Full Access

### 4. 발신자 인증 (Sender Authentication)

SendGrid에서 발신자 도메인 또는 단일 발신자 인증 필요:

```
Settings → Sender Authentication → Single Sender Verification
```

---

## 확장 프로그램 설치

### Firebase Console에서 설치

```
Firebase Console → Extensions → Trigger Email from Firestore → Install
```

### CLI로 설치

```bash
firebase ext:install firebase/firestore-send-email --project=YOUR_PROJECT_ID
```

### 설치 시 필수 설정값

| 설정 | 설명 | 예시 |
|------|------|------|
| `SMTP connection URI` | SMTP 연결 문자열 | `smtps://apikey:SG.xxx@smtp.sendgrid.net:465` |
| `Email documents collection` | 이메일 문서가 저장될 컬렉션 | `mail` |
| `Default FROM address` | 기본 발신 이메일 | `noreply@yourdomain.com` |
| `Templates collection` | 템플릿 문서 컬렉션 (선택) | `email_templates` |

### SendGrid SMTP 연결 문자열 형식

```
smtps://apikey:YOUR_SENDGRID_API_KEY@smtp.sendgrid.net:465
```

또는 TLS 포트 사용:

```
smtp://apikey:YOUR_SENDGRID_API_KEY@smtp.sendgrid.net:587
```

---

## 이메일 및 메타 정보 수집

### 구독자 컬렉션 구조

이메일 발송과 별도로 구독자 정보를 수집하는 컬렉션을 설계합니다.

```typescript
// Firestore 컬렉션: subscribers
interface Subscriber {
  // 필수 정보
  email: string;
  
  // 메타 정보
  firstName?: string;
  lastName?: string;
  language: string;           // 'ko', 'en', 'ja'
  
  // 구독 정보
  subscribedAt: Timestamp;
  source: 'landing_page' | 'app' | 'popup' | 'api';
  status: 'pending' | 'active' | 'unsubscribed';
  
  // 추가 메타 정보
  metadata: {
    deviceType: 'mobile' | 'desktop' | 'tablet';
    browser: string;
    os: string;
    ipAddress: string;
    country: string;
    city: string;
    userAgent: string;
    referrer: string;
    utmSource?: string;
    utmMedium?: string;
    utmCampaign?: string;
  };
  
  // 앱 관련 정보
  appVersion?: string;
  platform?: 'ios' | 'android' | 'web';
  
  // 관리용 필드
  unsubscribeToken: string;
  lastEmailSentAt?: Timestamp;
  emailsSentCount: number;
  
  // 시스템 필드
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

### Flutter에서 구독자 수집 구현

```dart
// lib/features/subscription/data/subscriber_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class SubscriberRepository {
  final FirebaseFirestore _firestore;
  
  SubscriberRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addSubscriber({
    required String email,
    String? firstName,
    String? lastName,
    required String source,
    required SubscriberMetadata metadata,
  }) async {
    final unsubscribeToken = const Uuid().v4();
    
    await _firestore.collection('subscribers').add({
      'email': email.toLowerCase().trim(),
      'firstName': firstName,
      'lastName': lastName,
      'language': metadata.language,
      'subscribedAt': FieldValue.serverTimestamp(),
      'source': source,
      'status': 'pending', // Double opt-in을 위해 pending으로 시작
      'metadata': {
        'deviceType': metadata.deviceType,
        'browser': metadata.browser,
        'os': metadata.os,
        'ipAddress': metadata.ipAddress,
        'country': metadata.country,
        'city': metadata.city,
        'userAgent': metadata.userAgent,
        'referrer': metadata.referrer,
        'utmSource': metadata.utmSource,
        'utmMedium': metadata.utmMedium,
        'utmCampaign': metadata.utmCampaign,
      },
      'appVersion': metadata.appVersion,
      'platform': metadata.platform,
      'unsubscribeToken': unsubscribeToken,
      'emailsSentCount': 0,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<bool> isEmailSubscribed(String email) async {
    final query = await _firestore
        .collection('subscribers')
        .where('email', isEqualTo: email.toLowerCase().trim())
        .where('status', isEqualTo: 'active')
        .limit(1)
        .get();
    
    return query.docs.isNotEmpty;
  }

  Future<void> confirmSubscription(String token) async {
    final query = await _firestore
        .collection('subscribers')
        .where('unsubscribeToken', isEqualTo: token)
        .where('status', isEqualTo: 'pending')
        .limit(1)
        .get();
    
    if (query.docs.isNotEmpty) {
      await query.docs.first.reference.update({
        'status': 'active',
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> unsubscribe(String token) async {
    final query = await _firestore
        .collection('subscribers')
        .where('unsubscribeToken', isEqualTo: token)
        .limit(1)
        .get();
    
    if (query.docs.isNotEmpty) {
      await query.docs.first.reference.update({
        'status': 'unsubscribed',
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }
}

class SubscriberMetadata {
  final String language;
  final String deviceType;
  final String browser;
  final String os;
  final String ipAddress;
  final String country;
  final String city;
  final String userAgent;
  final String referrer;
  final String? utmSource;
  final String? utmMedium;
  final String? utmCampaign;
  final String? appVersion;
  final String? platform;

  SubscriberMetadata({
    required this.language,
    required this.deviceType,
    required this.browser,
    required this.os,
    required this.ipAddress,
    required this.country,
    required this.city,
    required this.userAgent,
    required this.referrer,
    this.utmSource,
    this.utmMedium,
    this.utmCampaign,
    this.appVersion,
    this.platform,
  });
}
```

### 메타 정보 수집 헬퍼

```dart
// lib/core/utils/metadata_collector.dart
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class MetadataCollector {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<SubscriberMetadata> collect({
    required String language,
    String? referrer,
    String? utmSource,
    String? utmMedium,
    String? utmCampaign,
  }) async {
    String deviceType = 'unknown';
    String browser = 'unknown';
    String os = 'unknown';
    String userAgent = 'unknown';
    String platform = 'unknown';

    if (kIsWeb) {
      final webInfo = await _deviceInfo.webBrowserInfo;
      deviceType = _detectDeviceType(webInfo.userAgent ?? '');
      browser = webInfo.browserName.name;
      os = webInfo.platform ?? 'unknown';
      userAgent = webInfo.userAgent ?? 'unknown';
      platform = 'web';
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      deviceType = iosInfo.model.contains('iPad') ? 'tablet' : 'mobile';
      os = 'iOS ${iosInfo.systemVersion}';
      platform = 'ios';
    } else if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      deviceType = _isTablet(androidInfo) ? 'tablet' : 'mobile';
      os = 'Android ${androidInfo.version.release}';
      platform = 'android';
    } else if (Platform.isMacOS) {
      deviceType = 'desktop';
      os = 'macOS';
      platform = 'macos';
    } else if (Platform.isWindows) {
      deviceType = 'desktop';
      os = 'Windows';
      platform = 'windows';
    }

    return SubscriberMetadata(
      language: language,
      deviceType: deviceType,
      browser: browser,
      os: os,
      ipAddress: '', // 서버 사이드에서 수집 권장
      country: '',   // 서버 사이드에서 수집 권장
      city: '',      // 서버 사이드에서 수집 권장
      userAgent: userAgent,
      referrer: referrer ?? '',
      utmSource: utmSource,
      utmMedium: utmMedium,
      utmCampaign: utmCampaign,
      appVersion: '1.0.0', // 앱 버전 상수 또는 패키지에서 가져오기
      platform: platform,
    );
  }

  String _detectDeviceType(String userAgent) {
    final ua = userAgent.toLowerCase();
    if (ua.contains('mobile')) return 'mobile';
    if (ua.contains('tablet') || ua.contains('ipad')) return 'tablet';
    return 'desktop';
  }

  bool _isTablet(AndroidDeviceInfo info) {
    // 화면 크기 기반 태블릿 판별 로직
    return false;
  }
}
```

---

## Firestore 데이터 구조

### mail 컬렉션 (이메일 발송용)

확장 프로그램이 모니터링하는 메인 컬렉션입니다.

```typescript
// Firestore 컬렉션: mail
interface MailDocument {
  // 수신자 정보
  to: string | string[];           // 수신자 이메일
  cc?: string | string[];          // 참조
  bcc?: string | string[];         // 숨은 참조
  
  // 이메일 내용
  message: {
    subject: string;               // 제목
    text?: string;                 // 텍스트 본문
    html?: string;                 // HTML 본문
    amp?: string;                  // AMP HTML (선택)
  };
  
  // 발신자 정보 (선택, 기본값 사용 가능)
  from?: string;                   // 발신자 이메일
  replyTo?: string;                // 회신 주소
  
  // 템플릿 사용 시
  template?: {
    name: string;                  // 템플릿 이름
    data: Record<string, any>;     // 템플릿 변수
  };
  
  // 첨부파일
  attachments?: Attachment[];
  
  // 헤더 (선택)
  headers?: Record<string, string>;
  
  // 시스템 필드 (확장 프로그램이 자동 관리)
  delivery?: {
    state: 'PENDING' | 'PROCESSING' | 'SUCCESS' | 'ERROR' | 'RETRY';
    attempts: number;
    error?: string;
    startTime?: Timestamp;
    endTime?: Timestamp;
    leaseExpireTime?: Timestamp;
    info?: {
      messageId: string;
      accepted: string[];
      rejected: string[];
      pending: string[];
    };
  };
}

interface Attachment {
  filename: string;
  content?: string;        // Base64 인코딩된 컨텐츠
  path?: string;           // 파일 URL
  href?: string;           // 외부 URL
  contentType?: string;    // MIME 타입
  encoding?: string;       // 인코딩 방식
}
```

### email_templates 컬렉션 (템플릿용)

```typescript
// Firestore 컬렉션: email_templates
interface EmailTemplate {
  // 템플릿 식별자
  name: string;              // 고유 템플릿 이름
  
  // 이메일 내용
  subject: string;           // 제목 (Handlebars 변수 사용 가능)
  html: string;              // HTML 본문 (Handlebars 변수 사용 가능)
  text?: string;             // 텍스트 본문 (선택)
  
  // 다국어 지원
  locales?: {
    [locale: string]: {
      subject: string;
      html: string;
      text?: string;
    };
  };
  
  // 메타 정보
  description?: string;      // 템플릿 설명
  category?: string;         // 분류 (welcome, newsletter, notification 등)
  
  // 시스템 필드
  createdAt: Timestamp;
  updatedAt: Timestamp;
  isActive: boolean;
}
```

---

## 이메일 발송 트리거

### 기본 이메일 발송

```dart
// 간단한 이메일 발송
Future<void> sendSimpleEmail(String toEmail, String subject, String body) async {
  await FirebaseFirestore.instance.collection('mail').add({
    'to': toEmail,
    'message': {
      'subject': subject,
      'html': body,
    },
  });
}
```

### 환영 이메일 발송 예시

```dart
// lib/features/subscription/domain/send_welcome_email.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class WelcomeEmailSender {
  final FirebaseFirestore _firestore;

  WelcomeEmailSender({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> sendWelcomeEmail({
    required String email,
    required String firstName,
    required String language,
    required String unsubscribeToken,
  }) async {
    await _firestore.collection('mail').add({
      'to': email,
      'template': {
        'name': 'welcome-email',
        'data': {
          'firstName': firstName,
          'language': language,
          'unsubscribeUrl': 'https://yourdomain.com/unsubscribe?token=$unsubscribeToken',
          'preferencesUrl': 'https://yourdomain.com/preferences?token=$unsubscribeToken',
        },
      },
    });
  }

  Future<void> sendConfirmationEmail({
    required String email,
    required String confirmationToken,
    required String language,
  }) async {
    await _firestore.collection('mail').add({
      'to': email,
      'template': {
        'name': 'confirm-subscription',
        'data': {
          'confirmUrl': 'https://yourdomain.com/confirm?token=$confirmationToken',
          'language': language,
        },
      },
    });
  }
}
```

### Cloud Functions로 자동 트리거 (Double Opt-in)

```typescript
// functions/src/index.ts
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

const db = admin.firestore();

// 구독자가 추가되면 확인 이메일 자동 발송
export const onSubscriberCreated = functions.firestore
  .document('subscribers/{subscriberId}')
  .onCreate(async (snap, context) => {
    const subscriber = snap.data();
    
    if (subscriber.status !== 'pending') {
      return null;
    }

    // 확인 이메일 발송
    await db.collection('mail').add({
      to: subscriber.email,
      template: {
        name: 'confirm-subscription',
        data: {
          firstName: subscriber.firstName || '구독자',
          confirmUrl: `https://yourdomain.com/confirm?token=${subscriber.unsubscribeToken}`,
          language: subscriber.language || 'ko',
        },
      },
    });

    console.log(`Confirmation email sent to ${subscriber.email}`);
    return null;
  });

// 구독이 확인되면 환영 이메일 발송
export const onSubscriptionConfirmed = functions.firestore
  .document('subscribers/{subscriberId}')
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();

    // pending → active 변경 감지
    if (before.status === 'pending' && after.status === 'active') {
      await db.collection('mail').add({
        to: after.email,
        template: {
          name: 'welcome-email',
          data: {
            firstName: after.firstName || '구독자',
            unsubscribeUrl: `https://yourdomain.com/unsubscribe?token=${after.unsubscribeToken}`,
            language: after.language || 'ko',
          },
        },
      });

      console.log(`Welcome email sent to ${after.email}`);
    }

    return null;
  });
```

---

## 템플릿 시스템

### Handlebars 템플릿 문법

확장 프로그램은 Handlebars 템플릿 엔진을 사용합니다.

```html
<!-- email_templates 컬렉션의 welcome-email 문서 -->
{
  "name": "welcome-email",
  "subject": "{{firstName}}님, Little Signals에 오신 것을 환영합니다! 🎉",
  "html": "<!DOCTYPE html>
    <html>
    <head>
      <meta charset='utf-8'>
      <style>
        body { font-family: 'Apple SD Gothic Neo', sans-serif; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 40px; text-align: center; border-radius: 12px 12px 0 0; }
        .header h1 { color: white; margin: 0; font-size: 28px; }
        .content { background: #ffffff; padding: 40px; border: 1px solid #e5e7eb; }
        .button { display: inline-block; background: #667eea; color: white; padding: 16px 32px; text-decoration: none; border-radius: 8px; font-weight: bold; margin: 20px 0; }
        .footer { background: #f9fafb; padding: 20px; text-align: center; font-size: 12px; color: #6b7280; border-radius: 0 0 12px 12px; }
        .footer a { color: #667eea; }
      </style>
    </head>
    <body>
      <div class='container'>
        <div class='header'>
          <h1>Little Signals</h1>
        </div>
        <div class='content'>
          <h2>안녕하세요, {{firstName}}님! 👋</h2>
          <p>Little Signals 커뮤니티에 가입해 주셔서 감사합니다.</p>
          <p>앞으로 유용한 정보와 업데이트를 보내드릴게요:</p>
          <ul>
            <li>📱 새로운 기능 안내</li>
            <li>💡 활용 팁과 가이드</li>
            <li>🎁 특별 이벤트 및 프로모션</li>
          </ul>
          <a href='{{preferencesUrl}}' class='button'>환경설정 바로가기</a>
        </div>
        <div class='footer'>
          <p>더 이상 이메일을 받고 싶지 않으시면 <a href='{{unsubscribeUrl}}'>구독 취소</a>를 클릭하세요.</p>
          <p>© 2024 Little Signals. All rights reserved.</p>
        </div>
      </div>
    </body>
    </html>",
  "isActive": true,
  "createdAt": "2024-12-26T00:00:00Z",
  "updatedAt": "2024-12-26T00:00:00Z"
}
```

### 조건부 렌더링

```html
{{#if isPremium}}
  <p>프리미엄 회원 전용 혜택을 확인하세요!</p>
{{else}}
  <p>프리미엄으로 업그레이드하고 더 많은 혜택을 누리세요.</p>
{{/if}}

{{#each items}}
  <li>{{this.name}} - {{this.price}}원</li>
{{/each}}
```

### 다국어 템플릿 관리

```typescript
// 다국어 템플릿 구조
interface MultilingualTemplate {
  name: string;
  defaultLocale: string;
  locales: {
    ko: {
      subject: string;
      html: string;
    };
    en: {
      subject: string;
      html: string;
    };
    ja: {
      subject: string;
      html: string;
    };
  };
}

// Cloud Function에서 언어별 템플릿 선택
export async function sendLocalizedEmail(
  email: string,
  templateName: string,
  locale: string,
  data: Record<string, any>
) {
  const templateDoc = await db.collection('email_templates').doc(templateName).get();
  const template = templateDoc.data() as MultilingualTemplate;
  
  const localizedContent = template.locales[locale] || template.locales[template.defaultLocale];
  
  await db.collection('mail').add({
    to: email,
    message: {
      subject: renderTemplate(localizedContent.subject, data),
      html: renderTemplate(localizedContent.html, data),
    },
  });
}
```

---

## 스케줄링 서버를 통한 이메일 발송

### 방법 1: Firebase Scheduled Functions

```typescript
// functions/src/scheduled/newsletter.ts
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

const db = admin.firestore();

// 매주 월요일 오전 9시 (KST) 뉴스레터 발송
export const sendWeeklyNewsletter = functions.pubsub
  .schedule('0 0 * * 1') // UTC 기준 매주 월요일 00:00 (KST 09:00)
  .timeZone('Asia/Seoul')
  .onRun(async (context) => {
    console.log('📧 주간 뉴스레터 발송 시작...');

    try {
      // 활성 구독자 조회
      const subscribersSnapshot = await db
        .collection('subscribers')
        .where('status', '==', 'active')
        .get();

      const batch = db.batch();
      let emailCount = 0;

      for (const doc of subscribersSnapshot.docs) {
        const subscriber = doc.data();
        
        // 이메일 발송 문서 생성
        const mailRef = db.collection('mail').doc();
        batch.set(mailRef, {
          to: subscriber.email,
          template: {
            name: 'weekly-newsletter',
            data: {
              firstName: subscriber.firstName || '구독자',
              unsubscribeUrl: `https://yourdomain.com/unsubscribe?token=${subscriber.unsubscribeToken}`,
              // 뉴스레터 컨텐츠...
            },
          },
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        // 구독자 업데이트
        batch.update(doc.ref, {
          lastEmailSentAt: admin.firestore.FieldValue.serverTimestamp(),
          emailsSentCount: admin.firestore.FieldValue.increment(1),
        });

        emailCount++;

        // Firestore 배치 제한 (500개)
        if (emailCount % 450 === 0) {
          await batch.commit();
        }
      }

      await batch.commit();
      console.log(`✅ ${emailCount}개의 뉴스레터 발송 완료`);

    } catch (error) {
      console.error('❌ 뉴스레터 발송 실패:', error);
      throw error;
    }

    return null;
  });

// 매일 오후 6시 (KST) 활동 리마인더
export const sendDailyReminder = functions.pubsub
  .schedule('0 9 * * *') // UTC 09:00 = KST 18:00
  .timeZone('Asia/Seoul')
  .onRun(async (context) => {
    console.log('⏰ 일일 리마인더 발송 시작...');

    const oneDayAgo = new Date();
    oneDayAgo.setDate(oneDayAgo.getDate() - 1);

    // 24시간 동안 활동이 없는 사용자 조회
    const inactiveUsersSnapshot = await db
      .collection('subscribers')
      .where('status', '==', 'active')
      .where('lastActivityAt', '<', oneDayAgo)
      .get();

    for (const doc of inactiveUsersSnapshot.docs) {
      const subscriber = doc.data();

      await db.collection('mail').add({
        to: subscriber.email,
        template: {
          name: 'activity-reminder',
          data: {
            firstName: subscriber.firstName || '구독자',
            unsubscribeUrl: `https://yourdomain.com/unsubscribe?token=${subscriber.unsubscribeToken}`,
          },
        },
      });
    }

    console.log(`✅ ${inactiveUsersSnapshot.size}명에게 리마인더 발송 완료`);
    return null;
  });
```

### 방법 2: Cloud Tasks + HTTP Functions

더 정밀한 스케줄링이 필요한 경우:

```typescript
// functions/src/tasks/email_queue.ts
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { CloudTasksClient } from '@google-cloud/tasks';

const db = admin.firestore();
const tasksClient = new CloudTasksClient();

const PROJECT = process.env.GCLOUD_PROJECT!;
const LOCATION = 'asia-northeast3'; // 서울 리전
const QUEUE = 'email-queue';

// 이메일 예약 함수
export async function scheduleEmail(
  email: string,
  templateName: string,
  data: Record<string, any>,
  scheduledTime: Date
): Promise<string> {
  const parent = tasksClient.queuePath(PROJECT, LOCATION, QUEUE);
  
  const task = {
    httpRequest: {
      httpMethod: 'POST' as const,
      url: `https://${LOCATION}-${PROJECT}.cloudfunctions.net/processScheduledEmail`,
      headers: {
        'Content-Type': 'application/json',
      },
      body: Buffer.from(JSON.stringify({
        email,
        templateName,
        data,
      })).toString('base64'),
    },
    scheduleTime: {
      seconds: Math.floor(scheduledTime.getTime() / 1000),
    },
  };

  const [response] = await tasksClient.createTask({ parent, task });
  return response.name!;
}

// 예약된 이메일 처리 함수
export const processScheduledEmail = functions.https.onRequest(async (req, res) => {
  try {
    const { email, templateName, data } = req.body;

    await db.collection('mail').add({
      to: email,
      template: {
        name: templateName,
        data,
      },
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    res.status(200).send('Email queued successfully');
  } catch (error) {
    console.error('Error processing scheduled email:', error);
    res.status(500).send('Error processing email');
  }
});
```

### 방법 3: 외부 스케줄링 서버 (Node.js + Bull)

대규모 이메일 발송을 위한 독립 서버:

```typescript
// scheduler-server/src/queues/email_queue.ts
import Queue from 'bull';
import { initializeApp, cert } from 'firebase-admin/app';
import { getFirestore, FieldValue } from 'firebase-admin/firestore';

// Firebase Admin 초기화
initializeApp({
  credential: cert('./service-account.json'),
});

const db = getFirestore();

// Redis 기반 큐 생성
const emailQueue = new Queue('scheduled-emails', {
  redis: {
    host: process.env.REDIS_HOST || 'localhost',
    port: parseInt(process.env.REDIS_PORT || '6379'),
  },
  defaultJobOptions: {
    attempts: 3,
    backoff: {
      type: 'exponential',
      delay: 5000,
    },
    removeOnComplete: 100,
    removeOnFail: 50,
  },
});

// 이메일 작업 처리
emailQueue.process(async (job) => {
  const { email, templateName, data, subscriberId } = job.data;

  try {
    // Firestore mail 컬렉션에 추가
    await db.collection('mail').add({
      to: email,
      template: {
        name: templateName,
        data,
      },
      createdAt: FieldValue.serverTimestamp(),
    });

    // 구독자 통계 업데이트
    if (subscriberId) {
      await db.collection('subscribers').doc(subscriberId).update({
        lastEmailSentAt: FieldValue.serverTimestamp(),
        emailsSentCount: FieldValue.increment(1),
      });
    }

    return { success: true, email };
  } catch (error) {
    console.error(`Failed to send email to ${email}:`, error);
    throw error;
  }
});

// 반복 작업 스케줄 설정
async function setupRecurringJobs() {
  // 매주 월요일 오전 9시 뉴스레터
  await emailQueue.add(
    'weekly-newsletter',
    {},
    {
      repeat: {
        cron: '0 9 * * 1',
        tz: 'Asia/Seoul',
      },
    }
  );

  // 매일 오후 6시 리마인더
  await emailQueue.add(
    'daily-reminder',
    {},
    {
      repeat: {
        cron: '0 18 * * *',
        tz: 'Asia/Seoul',
      },
    }
  );
}

// 뉴스레터 작업 처리
emailQueue.process('weekly-newsletter', async (job) => {
  console.log('📧 주간 뉴스레터 작업 시작...');

  const subscribersSnapshot = await db
    .collection('subscribers')
    .where('status', '==', 'active')
    .get();

  for (const doc of subscribersSnapshot.docs) {
    const subscriber = doc.data();

    // 개별 이메일을 큐에 추가
    await emailQueue.add({
      email: subscriber.email,
      templateName: 'weekly-newsletter',
      data: {
        firstName: subscriber.firstName || '구독자',
        unsubscribeUrl: `https://yourdomain.com/unsubscribe?token=${subscriber.unsubscribeToken}`,
      },
      subscriberId: doc.id,
    }, {
      delay: Math.random() * 60000, // 0-60초 랜덤 딜레이 (rate limiting)
    });
  }

  console.log(`✅ ${subscribersSnapshot.size}개의 뉴스레터 작업 큐잉 완료`);
});

// 이벤트 리스너
emailQueue.on('completed', (job, result) => {
  console.log(`✅ Job ${job.id} completed:`, result);
});

emailQueue.on('failed', (job, err) => {
  console.error(`❌ Job ${job.id} failed:`, err);
});

// 서버 시작
setupRecurringJobs().then(() => {
  console.log('📅 이메일 스케줄러 서버 시작됨');
});
```

### 방법 4: Google Cloud Scheduler + Pub/Sub

```yaml
# cloudbuild.yaml
steps:
  - name: 'gcr.io/google.com/cloudsdktool/cloud-sdk'
    entrypoint: 'gcloud'
    args:
      - scheduler
      - jobs
      - create
      - pubsub
      - weekly-newsletter
      - --schedule=0 9 * * 1
      - --time-zone=Asia/Seoul
      - --topic=email-jobs
      - --message-body={"type": "weekly-newsletter"}
```

```typescript
// functions/src/pubsub/email_handler.ts
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

const db = admin.firestore();

export const emailJobHandler = functions.pubsub
  .topic('email-jobs')
  .onPublish(async (message) => {
    const data = message.json;

    switch (data.type) {
      case 'weekly-newsletter':
        await sendWeeklyNewsletter();
        break;
      case 'daily-digest':
        await sendDailyDigest();
        break;
      case 'campaign':
        await sendCampaign(data.campaignId);
        break;
      default:
        console.log('Unknown email job type:', data.type);
    }
  });
```

---

## 보안 설정

### Firestore 보안 규칙

```javascript
// firestore.rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // mail 컬렉션: 인증된 사용자만 쓰기 가능, 읽기 불가
    match /mail/{document=**} {
      allow read: if false;
      allow create: if request.auth != null;
      allow update, delete: if false;
    }
    
    // subscribers 컬렉션
    match /subscribers/{subscriberId} {
      // 읽기: 관리자만
      allow read: if request.auth != null && 
                    request.auth.token.admin == true;
      
      // 생성: 누구나 (구독 신청)
      allow create: if true;
      
      // 업데이트: 관리자 또는 올바른 토큰 소유자
      allow update: if request.auth != null && 
                      request.auth.token.admin == true ||
                      resource.data.unsubscribeToken == request.resource.data.unsubscribeToken;
      
      // 삭제: 관리자만
      allow delete: if request.auth != null && 
                      request.auth.token.admin == true;
    }
    
    // email_templates 컬렉션: 읽기만 허용
    match /email_templates/{templateId} {
      allow read: if true;
      allow write: if request.auth != null && 
                     request.auth.token.admin == true;
    }
  }
}
```

### 환경 변수 보안

```bash
# Firebase 환경 설정
firebase functions:secrets:set SENDGRID_API_KEY
firebase functions:secrets:set SMTP_CONNECTION_URI
```

```typescript
// functions/src/index.ts
import { defineSecret } from 'firebase-functions/params';

const sendgridApiKey = defineSecret('SENDGRID_API_KEY');

export const someFunction = functions
  .runWith({ secrets: [sendgridApiKey] })
  .https.onRequest((req, res) => {
    const apiKey = sendgridApiKey.value();
    // ...
  });
```

### Rate Limiting

```typescript
// functions/src/middleware/rate_limit.ts
import * as admin from 'firebase-admin';

const db = admin.firestore();

export async function checkRateLimit(
  identifier: string,
  maxRequests: number,
  windowMs: number
): Promise<boolean> {
  const windowStart = Date.now() - windowMs;
  const rateLimitRef = db.collection('rate_limits').doc(identifier);

  const doc = await rateLimitRef.get();
  
  if (!doc.exists) {
    await rateLimitRef.set({
      count: 1,
      windowStart: Date.now(),
    });
    return true;
  }

  const data = doc.data()!;
  
  if (data.windowStart < windowStart) {
    // 새로운 윈도우 시작
    await rateLimitRef.set({
      count: 1,
      windowStart: Date.now(),
    });
    return true;
  }

  if (data.count >= maxRequests) {
    return false; // 제한 초과
  }

  await rateLimitRef.update({
    count: admin.firestore.FieldValue.increment(1),
  });
  
  return true;
}
```

---

## 모니터링 및 디버깅

### 발송 상태 모니터링

```typescript
// 이메일 발송 상태 조회
async function getEmailStatus(emailDocId: string): Promise<EmailDeliveryStatus> {
  const doc = await db.collection('mail').doc(emailDocId).get();
  const data = doc.data();
  
  return {
    state: data?.delivery?.state || 'PENDING',
    attempts: data?.delivery?.attempts || 0,
    error: data?.delivery?.error,
    messageId: data?.delivery?.info?.messageId,
    startTime: data?.delivery?.startTime?.toDate(),
    endTime: data?.delivery?.endTime?.toDate(),
  };
}

interface EmailDeliveryStatus {
  state: 'PENDING' | 'PROCESSING' | 'SUCCESS' | 'ERROR' | 'RETRY';
  attempts: number;
  error?: string;
  messageId?: string;
  startTime?: Date;
  endTime?: Date;
}
```

### 실패한 이메일 재시도

```typescript
// 실패한 이메일 재시도 함수
export const retryFailedEmails = functions.pubsub
  .schedule('0 */6 * * *') // 6시간마다
  .onRun(async () => {
    const failedEmails = await db
      .collection('mail')
      .where('delivery.state', '==', 'ERROR')
      .where('delivery.attempts', '<', 5)
      .get();

    for (const doc of failedEmails.docs) {
      const data = doc.data();
      
      // 새 이메일 문서 생성으로 재시도
      await db.collection('mail').add({
        to: data.to,
        message: data.message,
        template: data.template,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        retryOf: doc.id,
      });

      // 원본 문서에 재시도 기록
      await doc.ref.update({
        'delivery.retriedAt': admin.firestore.FieldValue.serverTimestamp(),
      });
    }

    console.log(`✅ ${failedEmails.size}개의 실패한 이메일 재시도 완료`);
  });
```

### 대시보드용 통계 조회

```typescript
// 이메일 통계 조회
interface EmailStats {
  total: number;
  pending: number;
  success: number;
  failed: number;
  successRate: number;
}

async function getEmailStats(startDate: Date, endDate: Date): Promise<EmailStats> {
  const snapshot = await db
    .collection('mail')
    .where('createdAt', '>=', startDate)
    .where('createdAt', '<=', endDate)
    .get();

  let pending = 0;
  let success = 0;
  let failed = 0;

  snapshot.docs.forEach(doc => {
    const state = doc.data().delivery?.state;
    if (state === 'SUCCESS') success++;
    else if (state === 'ERROR') failed++;
    else pending++;
  });

  const total = snapshot.size;
  const successRate = total > 0 ? (success / total) * 100 : 0;

  return { total, pending, success, failed, successRate };
}
```

### 디버깅 팁

1. **Firebase Console에서 확인:**
   ```
   Firebase Console → Extensions → Trigger Email → View Logs
   ```

2. **Firestore에서 delivery 필드 확인:**
   ```typescript
   // delivery.error에 상세 오류 메시지 포함
   {
     "delivery": {
       "state": "ERROR",
       "error": "Invalid login: 535 Authentication failed",
       "attempts": 3
     }
   }
   ```

3. **흔한 오류 및 해결 방법:**
   - `Invalid login`: SMTP 자격 증명 확인
   - `Invalid recipient`: 이메일 주소 형식 검증
   - `Rate limit exceeded`: 발송 속도 조절

---

## 참고 자료

- [Firebase Trigger Email Extension 공식 문서](https://firebase.google.com/products/extensions/firebase-firestore-send-email)
- [SendGrid SMTP 설정 가이드](https://docs.sendgrid.com/for-developers/sending-email/getting-started-smtp)
- [Firestore 보안 규칙](https://firebase.google.com/docs/firestore/security/get-started)
- [Cloud Functions 스케줄링](https://firebase.google.com/docs/functions/schedule-functions)
- [Handlebars 템플릿 문법](https://handlebarsjs.com/guide/)

