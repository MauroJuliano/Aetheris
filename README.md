# Aetheris

Aetheris is a SwiftUI banking app I built for my portfolio.

The idea was to create something closer to a real app instead of a collection of isolated screens. It includes authentication, registration, onboarding, transfers, cards, beneficiaries, notifications, account settings, and a shared design system.

There is no live backend. The app uses mocked responses so the main flows can be tested and explored without any external setup.

## Preview

### Login

The app starts with a simple authentication flow, including validation, loading states, error handling, and password recovery.

<img width="1448" height="1086" alt="AuthenticationFlow" src="https://github.com/user-attachments/assets/bfb9e3c0-4e59-4166-a330-83ba91d99cb3" />

---

### Register Flow

The registration is split into multiple steps, including personal information, address, credentials, and account setup.

<img width="1448" height="1086" alt="Registerflow" src="https://github.com/user-attachments/assets/d84b92cf-5510-4f73-9fbf-e5972142ba73" />

**VIDEO PLACEHOLDER**

A short recording of the complete registration flow works well here.

---

### Onboarding

After creating an account, the user goes through a short onboarding before reaching the main app.

**IMAGE OR VIDEO PLACEHOLDER**

---

### Home

The home screen gives an overview of the account, including balance, recent transactions, quick actions, beneficiaries, and spending information.

**IMAGE PLACEHOLDER**

A full screenshot of the Home screen.

**VIDEO PLACEHOLDER**

A short recording scrolling through the Home screen and opening one or two details.

---

### Cards

The card area includes:

* Card overview
* Available limit
* Current invoice
* Virtual card
* Lock and unlock
* Transaction history

**IMAGE PLACEHOLDER**

A good option here is a single image with 3 or 4 card screens side by side.

---

### Send Money

The transfer flow goes from choosing a beneficiary to entering an amount, confirming the transfer, processing it, and showing the final result.

**VIDEO PLACEHOLDER**

Suggested recording:

`Beneficiary → Amount → Confirmation → Processing → Success`

This is probably one of the best flows to show in the README because it gives a good idea of how navigation and state changes work across the app.

---

### Request Money

The app also includes a flow for requesting money from another user.

**IMAGE OR VIDEO PLACEHOLDER**

---

### Beneficiaries

Users can search for beneficiaries, open their details, see previous transactions, and start a transfer from there.

**IMAGE PLACEHOLDER**

Suggested screenshots:

* Beneficiary list
* Beneficiary details

---

### Transactions

The app includes transaction history and detailed views for regular transactions and subscriptions.

**IMAGE PLACEHOLDER**

Suggested screenshots:

* Transaction history
* Transaction details
* Subscription details

---

### Profile and Notifications

The account area includes profile information, settings, notifications, and feedback screens.

**IMAGE PLACEHOLDER**

---

## Features

The current version includes:

* Authentication
* Password recovery
* Registration
* Onboarding
* Home dashboard
* Balance visibility
* Quick actions
* Spending summary
* Transaction history
* Transaction details
* Subscription details
* Beneficiary search
* Beneficiary details
* Send money
* Request money
* Transfer confirmation
* Processing, success, and error states
* Card overview
* Available card limit
* Current invoice
* Virtual card
* Card lock and unlock
* Notifications
* Profile and settings
* Feedback
* Skeleton loading
* Reusable UI components

## Tech

The project uses:

* Swift
* SwiftUI
* async/await
* XCTest
* MVVM
* Coordinators
* Dependency injection
* NavigationStack
* A shared design system
* A custom networking layer

## Project Structure

The app is split into modules:

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

Each module owns a specific part of the app.

`Core` contains the networking code and shared services.

`AetherisDesignSystem` contains reusable UI components, colors, spacing, typography, buttons, cards, skeletons, and other shared views.

The remaining modules contain the app features.

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

I use this structure mostly to avoid putting navigation, data loading, and UI logic in the same place.

## Data Flow

Most screens load their data through a feature service.

The general flow is:

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

The View displays the current state and handles user interactions.

The ViewModel owns the state and decides what should happen after each action.

The Service handles the data request.

`CoreService` takes care of the shared networking behavior.

For this project, the endpoint returns mocked data instead of calling a real server.

This keeps the app easy to run while still letting me build the screens around asynchronous requests, loading states, errors, and response models.

## Design System

Reusable components live inside `AetherisDesignSystem`.

Some examples are:

* Buttons
* Text fields
* Cards
* Transaction cells
* Beneficiary cells
* Navigation elements
* Skeletons
* Colors
* Typography
* Spacing

**IMAGE PLACEHOLDER**

A small image showing some of the reusable components works well here.

For example:

```text
Button
TextField
Transaction Cell
Beneficiary Cell
Card
Skeleton
```

## Navigation

Navigation is mostly handled outside the views.

Factories and coordinators are used to create screens and connect one flow to another.

For example:

```text
Home
 ↓
Beneficiaries
 ↓
Beneficiary Details
 ↓
Send Money
 ↓
Confirmation
 ↓
Processing
 ↓
Success
```

**VIDEO PLACEHOLDER**

A short recording of this complete flow would fit well here.

## UI States

I tried not to build only the happy path.

Depending on the screen, the app can show:

```text
Loading
Content
Empty
Error
Processing
Success
```

Some examples are:

* Skeleton loading
* Form validation
* Login error
* Empty searches
* Transfer processing
* Transfer failure
* Transfer success

**IMAGE PLACEHOLDER**

A side-by-side image with a few different states would work well here.

For example:

`Loading → Content → Error`

## Networking

Feature modules do not call the HTTP client directly.

Instead, the flow looks more like this:

```text
HomeViewModel
     ↓
HomeService
     ↓
CoreService
     ↓
HomeEndpoint
```

This keeps networking code out of the views and makes it easier to replace a service during tests.

Because this is a portfolio project, the endpoints provide local responses.

That means the project can be cloned and run without API keys, environment variables, or a backend.

## Tests

The project contains unit tests for the main feature modules and the Core networking layer.

Most of the tests cover things such as:

* ViewModel behavior
* Service responses
* State changes
* Success cases
* Error cases

Services can be replaced with mocks during tests.

For example:

```text
ViewModel
 ↓
Mock Service
 ↓
Controlled Response
```

This makes flows like these easier to test:

```text
Loading → Success
Loading → Error

Processing → Success
Processing → Failure
```

**IMAGE PLACEHOLDER**

A screenshot of the Xcode Test Navigator with the tests passing would fit well here.

## Running the Project

1. Clone the repository.

```bash
git clone <repository-url>
```

2. Open:

```text
Aetheris.xcodeproj
```

3. Select the `Aetheris` target.

4. Choose an iPhone simulator.

5. Run the app with:

```text
⌘ + R
```

No backend or API configuration is required.

## Why I Built It

I wanted a portfolio project where I could work on more than just individual SwiftUI screens.

Aetheris gave me room to work on things I normally deal with in larger iOS apps, such as:

* Navigation between multiple features
* Reusable UI
* Async data loading
* Loading and error states
* Services and networking
* Dependency injection
* Unit tests
* Feature separation

It also gave me a project where I could keep improving individual parts without having to rebuild the whole app every time.

## Media I Still Want to Add

Before considering the README finished, these are the main images and videos I would add:

### App Overview

**IMAGE PLACEHOLDER**

One image with 3 or 4 of the strongest screens.

---

### Register Flow

**VIDEO PLACEHOLDER**

Full account creation flow.

---

### Home

**IMAGE PLACEHOLDER**

Full Home screen.

---

### Transfer Flow

**VIDEO PLACEHOLDER**

`Beneficiary → Amount → Confirmation → Processing → Success`

---

### Cards

**IMAGE PLACEHOLDER**

Card Home, Virtual Card, Invoice, and Card Lock.

---

### Design System

**IMAGE PLACEHOLDER**

A few reusable components together.

---

### Different States

**IMAGE PLACEHOLDER**

Loading, Content, Error, and Success states.

---

### Tests

**IMAGE PLACEHOLDER**

XCTest suite running successfully.

## Notes

Aetheris is a demo project.

It does not connect to a real financial institution or process real transactions.

All balances, cards, transactions, beneficiaries, and account information shown in the app are fictional.
