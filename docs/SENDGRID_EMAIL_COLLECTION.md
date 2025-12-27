# SendGrid 이메일 수집 및 발송 가이드

## 목차

1. [개요](#개요)
2. [사전 준비](#사전-준비)
3. [이메일 및 메타 정보 수집](#이메일-및-메타-정보-수집)
4. [SendGrid Marketing Contacts API](#sendgrid-marketing-contacts-api)
5. [스케줄링 서버를 통한 이메일 발송](#스케줄링-서버를-통한-이메일-발송)
6. [보안 및 인증 설정](#보안-및-인증-설정)
7. [베스트 프랙티스](#베스트-프랙티스)

---

## 개요

이 문서는 SendGrid를 사용하여 이메일 구독자를 수집하고, 메타 정보를 함께 저장하며, 스케줄링 서버를 통해 자동화된 이메일을 발송하는 방법을 설명합니다.

### SendGrid란?

SendGrid는 Twilio가 제공하는 클라우드 기반 이메일 서비스 플랫폼으로, 다음 기능을 제공합니다:

- **트랜잭션 이메일**: 회원가입 확인, 비밀번호 재설정 등
- **마케팅 이메일**: 뉴스레터, 프로모션 캠페인
- **연락처 관리**: 구독자 목록 및 세그먼트 관리
- **분석 및 리포팅**: 이메일 성과 추적

---

## 사전 준비

### 1. SendGrid 계정 생성

1. [SendGrid 웹사이트](https://sendgrid.com)에서 계정 생성
2. 이메일 인증 완료
3. 발신자 인증(Sender Authentication) 설정

### 2. API 키 발급

```
Dashboard → Settings → API Keys → Create API Key
```

권한 설정:
- **Full Access**: 모든 기능 사용 (개발 시 권장)
- **Restricted Access**: 필요한 권한만 선택
  - `Marketing` - 연락처 및 캠페인 관리
  - `Mail Send` - 이메일 발송

### 3. 환경 변수 설정

```bash
# .env 파일
SENDGRID_API_KEY=SG.xxxxxxxxxxxxxxxxxxxxxxxx
SENDGRID_FROM_EMAIL=noreply@yourdomain.com
SENDGRID_FROM_NAME=Little Signals
```

---

## 이메일 및 메타 정보 수집

### 수집 가능한 메타 정보

| 필드명 | 타입 | 설명 | 예시 |
|--------|------|------|------|
| `email` | String (필수) | 이메일 주소 | user@example.com |
| `first_name` | String | 이름 | 홍길동 |
| `last_name` | String | 성 | 홍 |
| `country` | String | 국가 | KR |
| `city` | String | 도시 | Seoul |
| `custom_fields` | Object | 커스텀 필드 | (아래 참조) |

### 커스텀 필드 정의

SendGrid에서 커스텀 필드를 생성하여 추가 메타 정보를 저장할 수 있습니다:

```json
{
  "source": "landing_page",          // 구독 출처
  "signup_date": "2024-12-26",       // 가입일
  "interest_category": "newsletter", // 관심 카테고리
  "app_version": "1.0.0",            // 앱 버전
  "device_type": "mobile",           // 기기 타입
  "language": "ko"                   // 언어 설정
}
```

### 프론트엔드 구독 폼 예시

```typescript
// subscription_form.tsx
interface SubscriptionData {
  email: string;
  firstName?: string;
  lastName?: string;
  source: 'landing_page' | 'app' | 'popup';
  interestCategory: string[];
  deviceType: string;
  language: string;
  appVersion: string;
}

async function submitSubscription(data: SubscriptionData): Promise<void> {
  const response = await fetch('/api/subscribe', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      email: data.email,
      firstName: data.firstName,
      lastName: data.lastName,
      metadata: {
        source: data.source,
        interestCategory: data.interestCategory.join(','),
        deviceType: data.deviceType,
        language: data.language,
        appVersion: data.appVersion,
        signupDate: new Date().toISOString(),
      },
    }),
  });

  if (!response.ok) {
    throw new Error('Subscription failed');
  }
}
```

---

## SendGrid Marketing Contacts API

### 1. 커스텀 필드 생성

먼저 커스텀 필드를 생성해야 합니다:

```bash
# 커스텀 필드 생성 API
curl --request POST \
  --url https://api.sendgrid.com/v3/marketing/field_definitions \
  --header "Authorization: Bearer $SENDGRID_API_KEY" \
  --header "Content-Type: application/json" \
  --data '{
    "name": "source",
    "field_type": "Text"
  }'
```

지원되는 필드 타입:
- `Text` - 문자열
- `Number` - 숫자
- `Date` - 날짜 (YYYY-MM-DD)

### 2. 연락처 추가 (단일)

```bash
curl --request PUT \
  --url https://api.sendgrid.com/v3/marketing/contacts \
  --header "Authorization: Bearer $SENDGRID_API_KEY" \
  --header "Content-Type: application/json" \
  --data '{
    "contacts": [
      {
        "email": "user@example.com",
        "first_name": "길동",
        "last_name": "홍",
        "country": "KR",
        "city": "Seoul",
        "custom_fields": {
          "source": "landing_page",
          "signup_date": "2024-12-26",
          "interest_category": "newsletter",
          "app_version": "1.0.0"
        }
      }
    ]
  }'
```

### 3. 연락처 일괄 추가

```bash
curl --request PUT \
  --url https://api.sendgrid.com/v3/marketing/contacts \
  --header "Authorization: Bearer $SENDGRID_API_KEY" \
  --header "Content-Type: application/json" \
  --data '{
    "list_ids": ["list-id-here"],
    "contacts": [
      {
        "email": "user1@example.com",
        "custom_fields": { "source": "app" }
      },
      {
        "email": "user2@example.com", 
        "custom_fields": { "source": "landing_page" }
      }
    ]
  }'
```

### 4. 백엔드 구현 예시 (Node.js)

```typescript
// api/subscribe.ts
import sgClient from '@sendgrid/client';

sgClient.setApiKey(process.env.SENDGRID_API_KEY!);

interface SubscribeRequest {
  email: string;
  firstName?: string;
  lastName?: string;
  metadata: {
    source: string;
    interestCategory: string;
    deviceType: string;
    language: string;
    appVersion: string;
    signupDate: string;
  };
}

export async function addContact(data: SubscribeRequest): Promise<void> {
  // 1. 커스텀 필드 ID 조회 (캐싱 권장)
  const [fieldResponse] = await sgClient.request({
    method: 'GET',
    url: '/v3/marketing/field_definitions',
  });

  const customFields = fieldResponse.body.custom_fields.reduce(
    (acc: Record<string, string>, field: { id: string; name: string }) => {
      acc[field.name] = field.id;
      return acc;
    },
    {}
  );

  // 2. 연락처 추가
  const contact = {
    email: data.email,
    first_name: data.firstName,
    last_name: data.lastName,
    custom_fields: {
      [customFields.source]: data.metadata.source,
      [customFields.interest_category]: data.metadata.interestCategory,
      [customFields.device_type]: data.metadata.deviceType,
      [customFields.language]: data.metadata.language,
      [customFields.app_version]: data.metadata.appVersion,
      [customFields.signup_date]: data.metadata.signupDate,
    },
  };

  await sgClient.request({
    method: 'PUT',
    url: '/v3/marketing/contacts',
    body: {
      list_ids: [process.env.SENDGRID_LIST_ID],
      contacts: [contact],
    },
  });
}
```

### 5. 백엔드 구현 예시 (Python/Flask)

```python
# api/subscribe.py
import os
from sendgrid import SendGridAPIClient
from flask import Flask, request, jsonify

app = Flask(__name__)

sg = SendGridAPIClient(os.environ.get('SENDGRID_API_KEY'))

@app.route('/api/subscribe', methods=['POST'])
def subscribe():
    data = request.get_json()
    
    # 연락처 데이터 구성
    contact = {
        "email": data['email'],
        "first_name": data.get('firstName'),
        "last_name": data.get('lastName'),
        "custom_fields": {
            "e1_T": data['metadata']['source'],          # 커스텀 필드 ID
            "e2_T": data['metadata']['interestCategory'],
            "e3_T": data['metadata']['deviceType'],
            "e4_T": data['metadata']['language'],
            "e5_T": data['metadata']['appVersion'],
            "e6_D": data['metadata']['signupDate']       # Date 타입
        }
    }
    
    try:
        response = sg.client.marketing.contacts.put(
            request_body={
                "list_ids": [os.environ.get('SENDGRID_LIST_ID')],
                "contacts": [contact]
            }
        )
        return jsonify({"status": "success", "job_id": response.body.get('job_id')})
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500
```

---

## 스케줄링 서버를 통한 이메일 발송

### 아키텍처 개요

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────┐
│  스케줄러       │────▶│  이메일 워커     │────▶│  SendGrid   │
│  (Cron/Queue)   │     │  (Email Worker)  │     │  API        │
└─────────────────┘     └──────────────────┘     └─────────────┘
        │                        │
        ▼                        ▼
┌─────────────────┐     ┌──────────────────┐
│  작업 큐        │     │  연락처 DB       │
│  (Redis/SQS)    │     │  (PostgreSQL)    │
└─────────────────┘     └──────────────────┘
```

### 방법 1: SendGrid의 예약 발송 기능 사용

SendGrid API에서 `send_at` 파라미터를 사용하여 최대 72시간 내 예약 발송이 가능합니다:

```typescript
// scheduled_email.ts
import sgMail from '@sendgrid/mail';

sgMail.setApiKey(process.env.SENDGRID_API_KEY!);

interface ScheduledEmail {
  to: string;
  subject: string;
  html: string;
  sendAt: Date; // 발송 예약 시간
}

async function sendScheduledEmail(email: ScheduledEmail): Promise<void> {
  const sendAtTimestamp = Math.floor(email.sendAt.getTime() / 1000);
  
  const msg = {
    to: email.to,
    from: {
      email: process.env.SENDGRID_FROM_EMAIL!,
      name: process.env.SENDGRID_FROM_NAME!,
    },
    subject: email.subject,
    html: email.html,
    sendAt: sendAtTimestamp, // Unix timestamp
  };

  await sgMail.send(msg);
}

// 사용 예시: 내일 오전 9시에 발송
const tomorrow9AM = new Date();
tomorrow9AM.setDate(tomorrow9AM.getDate() + 1);
tomorrow9AM.setHours(9, 0, 0, 0);

await sendScheduledEmail({
  to: 'user@example.com',
  subject: '안녕하세요!',
  html: '<h1>뉴스레터</h1><p>최신 소식을 전해드립니다.</p>',
  sendAt: tomorrow9AM,
});
```

### 방법 2: 자체 스케줄링 서버 구축 (Node.js + node-cron)

```typescript
// scheduler/email_scheduler.ts
import cron from 'node-cron';
import sgMail from '@sendgrid/mail';
import { getSubscribers, getEmailTemplate } from './db';

sgMail.setApiKey(process.env.SENDGRID_API_KEY!);

interface EmailJob {
  templateId: string;
  listId: string;
  scheduledTime: string; // cron 표현식
}

// 매일 오전 9시에 뉴스레터 발송
cron.schedule('0 9 * * *', async () => {
  console.log('📧 뉴스레터 발송 작업 시작...');
  
  try {
    const subscribers = await getSubscribers({ 
      listId: 'newsletter',
      status: 'active' 
    });
    
    const template = await getEmailTemplate('weekly-newsletter');
    
    // 배치 처리 (1000명씩)
    const batchSize = 1000;
    for (let i = 0; i < subscribers.length; i += batchSize) {
      const batch = subscribers.slice(i, i + batchSize);
      
      const personalizations = batch.map(sub => ({
        to: sub.email,
        dynamicTemplateData: {
          first_name: sub.firstName || '구독자',
          unsubscribe_url: `https://example.com/unsubscribe?token=${sub.unsubscribeToken}`,
        },
      }));

      await sgMail.send({
        from: {
          email: process.env.SENDGRID_FROM_EMAIL!,
          name: process.env.SENDGRID_FROM_NAME!,
        },
        templateId: template.sendgridTemplateId,
        personalizations,
      });

      console.log(`✅ ${i + batch.length}/${subscribers.length} 발송 완료`);
      
      // Rate limiting (100 emails/sec)
      await new Promise(resolve => setTimeout(resolve, 1000));
    }
    
    console.log('🎉 뉴스레터 발송 완료!');
  } catch (error) {
    console.error('❌ 뉴스레터 발송 실패:', error);
    // 알림 전송 (Slack, Discord 등)
  }
}, {
  timezone: 'Asia/Seoul'
});

console.log('📅 이메일 스케줄러 시작됨');
```

### 방법 3: 메시지 큐를 활용한 분산 처리 (Bull + Redis)

```typescript
// queues/email_queue.ts
import Queue from 'bull';
import sgMail from '@sendgrid/mail';

sgMail.setApiKey(process.env.SENDGRID_API_KEY!);

interface EmailJobData {
  to: string;
  templateId: string;
  dynamicData: Record<string, any>;
  scheduledFor?: Date;
}

// 이메일 큐 생성
const emailQueue = new Queue<EmailJobData>('email-queue', {
  redis: {
    host: process.env.REDIS_HOST,
    port: parseInt(process.env.REDIS_PORT || '6379'),
  },
  defaultJobOptions: {
    attempts: 3,
    backoff: {
      type: 'exponential',
      delay: 5000,
    },
    removeOnComplete: true,
  },
});

// 워커 처리
emailQueue.process(async (job) => {
  const { to, templateId, dynamicData } = job.data;
  
  await sgMail.send({
    to,
    from: {
      email: process.env.SENDGRID_FROM_EMAIL!,
      name: process.env.SENDGRID_FROM_NAME!,
    },
    templateId,
    dynamicTemplateData: dynamicData,
  });

  return { sent: true, to };
});

// 이메일 예약 함수
export async function scheduleEmail(data: EmailJobData): Promise<string> {
  const delay = data.scheduledFor 
    ? data.scheduledFor.getTime() - Date.now() 
    : 0;

  const job = await emailQueue.add(data, {
    delay: Math.max(0, delay),
  });

  return job.id.toString();
}

// 대량 이메일 예약 함수
export async function scheduleBulkEmails(
  emails: EmailJobData[],
  options?: { startDelay?: number; intervalMs?: number }
): Promise<string[]> {
  const { startDelay = 0, intervalMs = 100 } = options || {};
  const jobIds: string[] = [];

  for (let i = 0; i < emails.length; i++) {
    const job = await emailQueue.add(emails[i], {
      delay: startDelay + (i * intervalMs),
    });
    jobIds.push(job.id.toString());
  }

  return jobIds;
}

// 이벤트 리스너
emailQueue.on('completed', (job, result) => {
  console.log(`✅ 이메일 발송 완료: ${result.to}`);
});

emailQueue.on('failed', (job, err) => {
  console.error(`❌ 이메일 발송 실패: ${job.data.to}`, err);
});
```

### 방법 4: Python + Celery를 활용한 스케줄링

```python
# tasks/email_tasks.py
from celery import Celery
from celery.schedules import crontab
import sendgrid
from sendgrid.helpers.mail import Mail, To, From
import os

app = Celery('tasks', broker=os.environ.get('CELERY_BROKER_URL'))

sg = sendgrid.SendGridAPIClient(api_key=os.environ.get('SENDGRID_API_KEY'))

# 정기 스케줄 설정
app.conf.beat_schedule = {
    'send-weekly-newsletter': {
        'task': 'tasks.email_tasks.send_newsletter',
        'schedule': crontab(hour=9, minute=0, day_of_week=1),  # 매주 월요일 9시
        'args': ('newsletter',),
    },
    'send-monthly-report': {
        'task': 'tasks.email_tasks.send_newsletter',
        'schedule': crontab(hour=10, minute=0, day_of_month=1),  # 매월 1일 10시
        'args': ('monthly-report',),
    },
}

@app.task(bind=True, max_retries=3)
def send_single_email(self, to_email: str, subject: str, html_content: str):
    """단일 이메일 발송"""
    try:
        message = Mail(
            from_email=From(os.environ.get('SENDGRID_FROM_EMAIL'), os.environ.get('SENDGRID_FROM_NAME')),
            to_emails=To(to_email),
            subject=subject,
            html_content=html_content
        )
        response = sg.send(message)
        return {'status': 'sent', 'status_code': response.status_code}
    except Exception as e:
        self.retry(exc=e, countdown=60)

@app.task
def send_newsletter(template_name: str):
    """뉴스레터 발송"""
    from database import get_active_subscribers, get_template
    
    subscribers = get_active_subscribers()
    template = get_template(template_name)
    
    for subscriber in subscribers:
        # 각 구독자에게 개별 태스크로 발송 (병렬 처리)
        send_single_email.delay(
            to_email=subscriber['email'],
            subject=template['subject'],
            html_content=template['render'](subscriber)
        )

@app.task
def send_scheduled_campaign(campaign_id: str, scheduled_time: str):
    """예약된 캠페인 발송"""
    from database import get_campaign, get_campaign_recipients
    
    campaign = get_campaign(campaign_id)
    recipients = get_campaign_recipients(campaign_id)
    
    for recipient in recipients:
        send_single_email.delay(
            to_email=recipient['email'],
            subject=campaign['subject'],
            html_content=campaign['render'](recipient)
        )
```

---

## 보안 및 인증 설정

### 1. 도메인 인증 (Domain Authentication)

SendGrid 대시보드에서 도메인 인증을 설정합니다:

```
Settings → Sender Authentication → Authenticate Your Domain
```

필요한 DNS 레코드:
- **CNAME 레코드**: em1234.yourdomain.com → sendgrid.net
- **CNAME 레코드**: s1._domainkey.yourdomain.com → s1.domainkey.u1234.wl.sendgrid.net
- **CNAME 레코드**: s2._domainkey.yourdomain.com → s2.domainkey.u1234.wl.sendgrid.net

### 2. Link Branding

클릭 추적 링크에 커스텀 도메인 사용:

```
links.yourdomain.com → sendgrid.net
```

### 3. API 키 보안

```typescript
// API 키 권한을 최소한으로 설정
// 예: 이메일 발송만 필요한 경우

// ❌ 잘못된 방법: Full Access 키 사용
// ✅ 올바른 방법: Restricted Access 키 사용
//    - Mail Send: Full Access
//    - Marketing: 연락처 추가만 허용
```

### 4. Webhook 보안

```typescript
// webhook_handler.ts
import crypto from 'crypto';

function verifyWebhookSignature(
  payload: string,
  signature: string,
  timestamp: string,
  publicKey: string
): boolean {
  const timestampPayload = timestamp + payload;
  const decodedSignature = Buffer.from(signature, 'base64');
  
  const verifier = crypto.createVerify('sha256');
  verifier.update(timestampPayload);
  
  return verifier.verify(publicKey, decodedSignature);
}
```

---

## 베스트 프랙티스

### 1. 이중 옵트인 (Double Opt-in)

```typescript
// 1. 초기 구독 신청
async function requestSubscription(email: string): Promise<void> {
  const token = generateSecureToken();
  
  await saveSubscriptionRequest({
    email,
    token,
    status: 'pending',
    createdAt: new Date(),
  });

  await sendConfirmationEmail(email, token);
}

// 2. 확인 이메일 발송
async function sendConfirmationEmail(email: string, token: string): Promise<void> {
  await sgMail.send({
    to: email,
    from: process.env.SENDGRID_FROM_EMAIL!,
    subject: '이메일 구독 확인',
    html: `
      <h1>구독을 확인해주세요</h1>
      <p>아래 버튼을 클릭하여 구독을 완료하세요:</p>
      <a href="https://example.com/confirm?token=${token}">구독 확인하기</a>
    `,
  });
}

// 3. 구독 확인 처리
async function confirmSubscription(token: string): Promise<void> {
  const request = await findSubscriptionRequest(token);
  
  if (!request || request.status !== 'pending') {
    throw new Error('Invalid or expired token');
  }

  // SendGrid에 연락처 추가
  await addContactToSendGrid(request.email);
  
  // 상태 업데이트
  await updateSubscriptionStatus(token, 'confirmed');
}
```

### 2. 구독 취소 처리

```typescript
// 모든 이메일에 구독 취소 링크 포함
const unsubscribeUrl = `https://example.com/unsubscribe?token=${subscriber.unsubscribeToken}`;

// SendGrid 글로벌 구독 취소 사용
// 이메일 푸터에 자동으로 추가됨
```

### 3. 바운스 및 스팸 신고 처리

```typescript
// SendGrid Event Webhook 설정
// POST /webhooks/sendgrid

interface SendGridEvent {
  event: 'bounce' | 'spam_report' | 'unsubscribe' | 'open' | 'click';
  email: string;
  timestamp: number;
  reason?: string;
}

async function handleSendGridWebhook(events: SendGridEvent[]): Promise<void> {
  for (const event of events) {
    switch (event.event) {
      case 'bounce':
        await markEmailAsBounced(event.email, event.reason);
        break;
      case 'spam_report':
        await unsubscribeEmail(event.email, 'spam_report');
        break;
      case 'unsubscribe':
        await unsubscribeEmail(event.email, 'manual');
        break;
    }
  }
}
```

### 4. Rate Limiting 준수

```typescript
// SendGrid API 제한사항
// - 이메일 발송: 100 emails/second
// - API 호출: 600 requests/minute

import Bottleneck from 'bottleneck';

const limiter = new Bottleneck({
  minTime: 100, // 100ms 간격 (10 requests/second)
  maxConcurrent: 10,
});

async function sendEmailWithRateLimit(email: EmailData): Promise<void> {
  await limiter.schedule(() => sgMail.send(email));
}
```

### 5. 이메일 추적 및 분석

```typescript
// SendGrid 대시보드에서 확인 가능한 메트릭스
interface EmailMetrics {
  delivered: number;     // 전달됨
  opened: number;        // 열람
  clicked: number;       // 클릭
  bounced: number;       // 바운스
  spamReported: number;  // 스팸 신고
  unsubscribed: number;  // 구독 취소
}

// Webhook으로 실시간 이벤트 수집
async function trackEmailEvent(event: SendGridEvent): Promise<void> {
  await analytics.track({
    userId: event.email,
    event: `Email ${event.event}`,
    properties: {
      timestamp: event.timestamp,
      campaignId: event.sg_message_id,
    },
  });
}
```

---

## 참고 자료

- [SendGrid 공식 문서](https://docs.sendgrid.com/)
- [SendGrid Marketing Contacts API](https://docs.sendgrid.com/api-reference/contacts/add-or-update-a-contact)
- [SendGrid Mail Send API](https://docs.sendgrid.com/api-reference/mail-send/mail-send)
- [SendGrid Event Webhook](https://docs.sendgrid.com/for-developers/tracking-events/event)

