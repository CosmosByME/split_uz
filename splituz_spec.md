# SplitUZ — App Specification
> Bill splitting app built for Uzbekistan

---

## Problem

When a group of friends go out, one person pays for everything and asks others to transfer their share. Friends forget, pay the wrong amount, or ignore requests. This creates friction and damages relationships.

Existing solutions (Splitwise, Tricount) do not integrate with Uzbek payment infrastructure (Payme, Click, Humo, Uzcard) and have no Uzbek or Russian language support.

---

## Solution

A bill splitting app built specifically for Uzbekistan — UZS-first, Uzbek/Russian native, with Telegram bot notifications and direct Payme/Click payment deep links.

---

## Target Users

- Young adults in Uzbekistan (18–30)
- Friend groups who regularly split costs (cafés, restaurants, trips, shared purchases)
- Both smartphone-native and Telegram-heavy users

---

## Core Concepts

| Term | Definition |
|---|---|
| **Paymen** | The person who paid the bill and created the split |
| **Debtor** | A friend who owes money in a split |
| **Split** | A single shared expense divided among a group |
| **Bot** | The Telegram bot that handles notifications and payment prompts |

---

## Authentication

- Phone number login via **Firebase Phone Auth** (SMS OTP)
- Free up to 10,000 verifications/month — sufficient for v1
- After login, user is prompted to start the Telegram bot via a one-tap deep link

---

## User Flows

### 1. Paymen Creates a Split

```
Paymen opens app
→ Taps "New Split"
→ Enters bill title (e.g. "Café dinner") and total amount in UZS
→ Adds friends:
    → Friends with app: selected from contacts / search by phone
    → Friends without app: entered manually by phone number
        → App detects they are not registered
        → Shows dialog: "Some friends don't use SplitUZ.
          Share this link with them."
        → Generates parameterized bot link:
          t.me/splituzbot?start=splitId_userId
→ App calculates equal share per person
  (custom splits: v2)
→ Split is created and saved
```

---

### 2. Registered Friend Notification

```
Split created
→ Bot messages registered friend on Telegram:
  "Akbar paid 400,000 UZS for Café dinner.
   Your share: 100,000 UZS"
  [Pay via Payme] [Pay via Click] [I Paid]
```

---

### 3. Unregistered Friend Onboarding

```
Paymen shares parameterized link with unregistered friend
→ Friend taps link → Telegram opens → bot starts automatically
→ Bot receives splitId + userId from deep link parameter
→ Bot immediately shows:
  "Akbar paid 400,000 UZS for Café dinner.
   Your share: 100,000 UZS"
  [Pay via Payme] [Pay via Click] [I Paid]
→ No registration required
→ Optional: "Install SplitUZ to track all your debts" shown at bottom
```

---

### 4. Payment & Confirmation Loop

```
Friend taps [I Paid]
→ Bot messages Paymen:
  "Jasur says he paid 100,000 UZS. Verify?"
  [Yes, confirmed ✅] [No, not paid ❌]

If Paymen taps Yes:
→ Debt marked as settled in app
→ Friend's in-app widget updates
→ Bot confirms to friend: "Payment verified ✅"

If Paymen taps No:
→ Bot notifies friend: "Payment not confirmed yet.
  Please complete your transfer."
→ Reminder schedule starts
```

---

### 5. Reminder Schedule

```
If friend does not respond:
→ Reminder at 24 hours
→ Reminder at 72 hours
→ Final reminder at 7 days
→ After 7 days: stops, debt remains open in app
```

---

## In-App Debt Widget

Persistent card visible on home screen for all registered users.

```
┌─────────────────────────────────┐
│  💸 You owe                     │
│  Akbar — 100,000 UZS            │
│  [Pay via Payme] [Pay via Click]│
├─────────────────────────────────│
│  ✅ Owed to you                 │
│  Timur — 50,000 UZS (pending)  │
└─────────────────────────────────┘
```

- Updates in real time when debts are settled
- Tapping a debt opens the full split detail

---

## Payment Integration

Payment happens **outside the app** via deep links. SplitUZ does not process or hold money.

| Gateway | Deep Link Behavior |
|---|---|
| **Payme** | Opens Payme app with amount pre-filled |
| **Click** | Opens Click app with amount pre-filled |

Confirmation is **trust-based with social verification:**
- Friend taps "I Paid" (self-report)
- Paymen verifies manually (Yes/No)
- No merchant account or webhook required for v1

---

## Tech Stack

| Layer | Technology |
|---|---|
| Mobile App | Flutter (BLoC, Clean Architecture) |
| Auth | Firebase Phone Auth |
| Database | Firebase Firestore |
| Notifications | Firebase Cloud Messaging |
| Telegram Bot | Node.js or Python (hosted on a VPS or Railway) |
| Deep Links | Parameterized t.me links (`?start=splitId_userId`) |

---

## Localization

- Uzbek 🇺🇿
- Russian 🇷🇺
- Currency: UZS (Uzbekistani Som) — primary
- No other currencies in v1

---

## Monetization

- **v1:** Free, no ads
- **v2:** Freemium model — advanced features behind paywall
  (custom split ratios, expense history export, group analytics)
- **Ads:** Minimal, non-intrusive — considered only if organic growth warrants it

---

## V1 Scope (Ship This Only)

| Feature | Status |
|---|---|
| Phone auth (Firebase) | ✅ In scope |
| Create split | ✅ In scope |
| Equal split calculation | ✅ In scope |
| Bot notifications | ✅ In scope |
| Payme / Click deep links | ✅ In scope |
| I Paid → Verify flow | ✅ In scope |
| Reminder schedule | ✅ In scope |
| In-app debt widget | ✅ In scope |
| Unregistered friend bot onboarding | ✅ In scope |
| Custom split ratios | ❌ V2 |
| Receipt scanning | ❌ V2 |
| In-app payment processing | ❌ Never (regulatory complexity) |
| Multi-currency | ❌ V2 |
| Group expense history export | ❌ V2 |

---

## Firestore Data Model

> Key principle: Users keyed by uid with phone as an indexed field. Debtor statuses live in a subcollection under each Bill to avoid write conflicts when multiple debtors update simultaneously.

```
Users/{uid}
  - phone: string          ← indexed for search
  - name: string
  - telegramId: string?    ← nullable until user links Telegram
  - createdAt: timestamp

Bills/{billId}
  - title: string
  - totalAmount: number
  - currency: "UZS"
  - createdBy: uid
  - createdAt: timestamp

  Debtors/{uid or telegramId}
    - amount: number
    - status: "pending" | "claimed" | "verified"
    - claimedAt: timestamp?
    - verifiedAt: timestamp?

UserProfile/{uid}
  - displayName: string
  - friends: uid[]
  - splitHistory:
      - iPaid: billId[]
      - paidForMe: billId[]
```

### Why not Users + separate Profiles collection?

Two documents per user means every update touches two Firestore writes and risks inconsistency. A single `Users` document keyed by uid with phone as an indexed field handles both lookup speed and profile data cleanly.

### Phone → Telegram ID resolution

When an unregistered friend opens the bot via parameterized deep link for the first time, the bot immediately writes:

```
phone number → Telegram ID
```

into their `Users` document. This means on any future split, the Paymen only needs to enter a phone number — the bot can message the friend directly without generating a new link.

---

## Resolved Questions

| Question | Resolution |
|---|---|
| Bot hosting | Railway via GitHub Student Pro — free tier, always-on, sufficient for v1 |
| Firestore structure | Single Users collection (uid key, phone indexed), Bills with Debtors subcollection, UserProfile separate |
| Non-app friend identity | Anchored by phone number. Telegram ID written to Firestore on first bot interaction and merged automatically |
| Paymen as simultaneous debtor | Supported naturally — uid appears as `createdBy` in one Bill and inside `Debtors` of another independently |

---

*Document version: 1.1 — Open questions resolved, data model added*
