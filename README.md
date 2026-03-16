# SwiftUI App Coordinator Navigation Demo

A demonstration of a **coordinator-based navigation architecture for SwiftUI**
designed to support **deep, nested navigation flows** in a predictable and scalable way.

This project showcases how a centralized navigation coordinator can simplify routing
logic in complex SwiftUI applications.

---

## Motivation

SwiftUI provides powerful tools like `NavigationStack`, but as applications grow and navigation
becomes deeper and more interconnected, navigation state can become difficult to manage.

Common issues include:

- Navigation logic scattered across views
- Difficulty coordinating multi-screen flows
- Complicated state management when resetting navigation
- Hard-to-follow deep navigation stacks
- Cross-feature navigation becoming fragile

This demo presents a **coordinator-driven architecture** that centralizes navigation state
and routing decisions.

---

## Project Structure

```
SwiftUI-AppCoordinator-Demo/
├── DemoApp/
│   ├── App/
│   ├── Features/
│   └── Navigation/
├── Docs/
└── README.md
```

---

## Core Concepts

The architecture is built around three primary components.

### AppCoordinator

The `AppCoordinator` is the **single source of truth for navigation state**.

It manages:

- the application's root screen
- the navigation stack
- routing transitions
- session bootstrap logic
- shared application state

Example navigation call from a screen:

```swift
coordinator.push(.pet(.details(pet.id)))
```

---

### AppScreen

`AppScreen` defines the **complete set of navigation routes in the application**.

Routes are grouped by feature domain:

```swift
enum AppScreen {
    case core(CorePath)
    case settings(SettingsPath)
    case pet(PetPath)
}
```

Each feature defines its own route set:

```swift
enum PetPath {
    case dashboard
    case details(UUID)
    case edit(UUID)
}
```

This structure keeps navigation **type-safe and easy to reason about**.

---

### NavigationRouter

`NavigationRouter` converts routes into concrete SwiftUI views.

```swift
NavigationRouter.build(for: screen, coordinator: coordinator)
```

This keeps view construction **separate from navigation logic** and ensures the
coordinator remains focused purely on state management.

---

## Example Navigation Flow

This demo includes a small but realistic pet management feature to demonstrate navigation patterns.

Example flow:

```
Home
  → Pets Dashboard
  → Pet Details
  → Edit Pet
```

This demonstrates **multi-level navigation driven entirely by the coordinator**.

Additional flows include:

```
Home
  → Settings Dashboard
  → Security
```

---

## Editing Data with Navigation

The demo also shows a common real-world pattern for editing domain data.

Screens receive lightweight navigation identifiers:

```swift
.pet(.edit(petId))
```

The edit screen loads the domain object from the coordinator and uses a **local draft state**
during editing.

When the user submits the form, the updated data is committed back to the coordinator.

This keeps editing flows **safe and predictable**.

---

## Architecture Overview

A full architecture explanation and diagram can be found here:

`Docs/architecture.md`

---

## Running the Demo

1. Open the project in **Xcode 16 or later**
2. Build and run the app
3. Navigate through the demo flows:

```
Home → Pets Dashboard → Pet Details → Edit Pet
```

This flow demonstrates how navigation is fully managed by the coordinator.

---

## Project Goals

This demo focuses specifically on:

- centralized navigation architecture
- deep SwiftUI navigation flows
- coordinator-driven routing
- type-safe route definitions
- clean separation between navigation and view construction

It intentionally avoids unnecessary complexity such as networking or persistence
so the navigation architecture remains the primary focus.

---

## Requirements

- Xcode 16+
- Swift 6
- iOS 17+

The project uses:

- SwiftUI
- Observation (`@Observable`)
- NavigationStack

---

## License

MIT License
