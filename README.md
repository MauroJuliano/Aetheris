# Aetheris

Aetheris is a SwiftUI demo app built for portfolio review.

It simulates a banking experience with separate feature modules, shared design tokens, and a network layer built around endpoints and a core service. The app does not talk to a live backend. Responses are modeled in code so each flow can be exercised end to end.

## What is inside

- Authentication and registration
- Onboarding after sign up
- Home dashboard
- Card home, virtual card, card lock, invoice, transaction history, and transaction details
- Beneficiary list and beneficiary details
- Send money and request money flows
- Profile and notifications
- Reusable design system components

## Architecture

The app is split into modules:

- `Core` handles the HTTP client, endpoint abstraction, and demo service.
- `AetherisDesignSystem` contains shared colors, spacing, typography, buttons, cards, skeletons, and other UI pieces.
- `AetherisAuthentication`, `AERegistration`, `AetherisHome`, `AetherisCards`, `AetherisTransfers`, `Account`, `AetherisNotifications`, and `AetherisInsights` hold the feature flows.

Each feature usually follows the same structure:

- `Screen` or `View`
- `ViewModel`
- `Service`
- `Factory` or coordinator
- local models and small UI components

This keeps navigation, data loading, and screen composition separated.

## Data flow

Most screens load data through a service that uses `HasCoreService`.

The service calls an endpoint, and the endpoint also provides mock response data. That makes the app behave like it is connected to a backend while keeping the whole project self-contained.

## App flow

The app starts with a splash screen, then goes through authentication. From there it can reach registration, onboarding, and the main tab experience.

Inside the main app, the home screen routes into cards, transfers, account, and supporting detail screens.

## Running the project

1. Open `Aetheris.xcodeproj` in Xcode.
2. Select the `Aetheris` app target.
3. Run on an iPhone simulator.

## Tests

The repository includes unit tests for the main feature modules and the core networking layer.

Run them from Xcode or with `xcodebuild` using the existing test scheme.

## Notes

This project is meant to demonstrate structure, navigation, UI composition, and testable feature boundaries. It is not intended for production use.
