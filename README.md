Aetheris is a SwiftUI banking app I built for my portfolio.

The goal was to create something closer to a real app instead of a collection of isolated screens. It includes authentication, registration, onboarding, transfers, cards, beneficiaries, transactions, notifications, and account settings.

The app does not use a live backend. Responses are mocked locally so the main flows can be explored without any external setup.

Aetheris is available in English, Brazilian Portuguese, and German, with real-time language switching through the app settings.

---

## App Walkthrough

The complete experience—including authentication, registration, transfers, cards, beneficiaries, and account settings—will be available as a single video walkthrough.

**YOUTUBE VIDEO PLACEHOLDER**

---

## Preview

### Authentication

Login, validation, loading, error handling, and password recovery.

<img width="1448" height="1086" alt="AuthenticationFlow" src="https://github.com/user-attachments/assets/bfb9e3c0-4e59-4166-a330-83ba91d99cb3" />

### Registration

A multi-step registration flow covering personal information, address, credentials, and account review.

<img width="1448" height="1086" alt="RegisterFlow" src="https://github.com/user-attachments/assets/d84b92cf-5510-4f73-9fbf-e5972142ba73" />

### Home

Account balance, recent transactions, beneficiaries, quick actions, and spending information.

<img width="1391" height="1131" alt="HomeFlow" src="https://github.com/user-attachments/assets/42ecc25e-5814-4bd5-b5a5-ffec333a542e" />


### Transfers

The transfer flow covers beneficiary selection, amount entry, confirmation, processing, and success/error states.

`Beneficiary → Amount → Confirmation → Processing → Success`

<img width="1445" height="1089" alt="TransferFlow" src="https://github.com/user-attachments/assets/02490ccc-2190-4d30-a829-0b137d7932c8" />


### Cards

Card overview, available limit, invoice, virtual card, lock/unlock, and transaction history.

<img width="1526" height="1030" alt="CardFlow" src="https://github.com/user-attachments/assets/1e306dc4-35e1-43bc-a10a-2dafc18b4b8f" />



### More Screens

Beneficiaries, transaction details, subscriptions, notifications, profile, settings, and request money.

<img width="1535" height="1024" alt="morescreens" src="https://github.com/user-attachments/assets/9c1e119c-e865-47bc-a0db-3495dad95d01" />

---

## Localization

Aetheris supports three languages:

- English
- Brazilian Portuguese
- German

Users can change the app language through Settings. The interface updates immediately without requiring an app restart.

Localization covers authentication, registration, navigation, cards, transfers, beneficiaries, transaction details, notifications, and account settings.

---

## Tech

- Swift
- SwiftUI
- async/await
- XCTest
- MVVM
- Coordinators
- Dependency Injection
- Modular feature structure
- Shared Design System
- Custom networking layer
- Localization (EN, PT-BR, DE)

---

## Architecture

The app is split into feature modules with shared infrastructure.

```text
Aetheris
│
├── Core
├── AetherisDesignSystem
├── AetherisAuthentication
├── AERegistration
├── AetherisHome
├── AetherisCards
├── AetherisTransfers
├── Account
├── AetherisNotifications
└── AetherisInsights
```

Most features follow a similar structure:

```text
Feature
│
├── View
├── ViewModel
├── Service
├── Models
├── Components
└── Factory / Coordinator
```

A typical data request follows:

```text
View
 ↓
ViewModel
 ↓
Service
 ↓
CoreService
 ↓
Endpoint
 ↓
Mock Response
```

This keeps UI, navigation, and data loading separated while still allowing the app to behave around asynchronous loading, success, and error states.

---

## Design System

Reusable components live inside `AetherisDesignSystem`, including buttons, text fields, cards, cells, navigation elements, skeletons, colors, typography, and spacing.

---

## Tests

The project includes unit tests for ViewModels, services, state transitions, success cases, and error cases.

Services can be replaced with mocks to provide controlled responses during tests.

---

## Running the Project

```bash
git clone <repository-url>
```

Open `Aetheris.xcodeproj`, select an iPhone simulator, and run with `⌘ + R`.

No backend or API configuration is required.

---

## Disclaimer

Aetheris is a portfolio project.

It does not connect to a real financial institution or process real transactions. All data shown in the app is fictional.
