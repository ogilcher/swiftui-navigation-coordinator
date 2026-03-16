# Navigation Architecture

This project demonstrates a **coordinator-based navigation architecture** designed to
centralize navigation state and simplify deep navigation flows in SwiftUI applications.

The architecture separates navigation state, routing logic, and screen rendering
into clearly defined responsibilities.

---

## High-Level Architecture

```mermaid
flowchart TD
    A[ContentView] -->|owns| B[AppCoordinator]
    A -->|creates| C[NavigationStack]

    B -->|controls navigation state| C
    C -->|requests destination for AppScreen| D[NavigationRouter]

    D --> E[Core Routes]
    D --> F[Pet Routes]
    D --> G[Settings Routes]

    E --> H[HomeScreen]
    F --> I[PetDashboard]
    F --> J[PetDetails]
    F --> K[PetEdit]
    G --> L[SettingsDashboard]
    G --> M[SettingsSecurity]

    H -->|push / pop / goToRoot| B
    I -->|push| B
    J -->|push| B
    K -->|update pet| B
    L -->|push| B
    M -->|pop| B
```

---

## Component Responsibilities

### ContentView

`ContentView` is responsible for:

- owning the `AppCoordinator`
- creating the `NavigationStack`
- bootstrapping the application session
- injecting the coordinator into the SwiftUI environment

Example:

```swift
NavigationStack(path: $coordinator.path)
```

---

### AppCoordinator

The `AppCoordinator` acts as the **single source of truth for navigation state**.

It manages:

- the root screen
- the navigation stack
- route transitions
- session bootstrap logic
- shared demo data

Example navigation action:

```swift
coordinator.push(.pet(.details(petId)))
```

---

### NavigationRouter

The `NavigationRouter` is responsible for converting routes into SwiftUI views.

Example:

```swift
case .pet(.details(let petId)):
    return AnyView(PetDetails(petId: petId))
```

This keeps view construction separate from navigation logic.

---

### Screens

Screens focus only on:

- rendering UI
- sending navigation intent to the coordinator
- displaying data

Example:

```swift
coordinator.push(.pet(.edit(pet.id)))
```

---

## Navigation Flow

The following sequence illustrates how navigation occurs when a user interacts with the UI.

```mermaid
sequenceDiagram
    participant User
    participant Screen
    participant AppCoordinator
    participant NavigationStack
    participant NavigationRouter

    User->>Screen: Tap navigation button
    Screen->>AppCoordinator: push(.pet(.details(petId)))
    AppCoordinator->>NavigationStack: Update path
    NavigationStack->>NavigationRouter: Request destination view
    NavigationRouter-->>NavigationStack: Return PetDetails view
```

---

## Data Editing Flow

The edit flow demonstrates how screens can safely modify domain data
without directly mutating shared state during form editing.

```mermaid
sequenceDiagram
    participant PetEdit
    participant AppCoordinator

    PetEdit->>AppCoordinator: Request pet by ID
    AppCoordinator-->>PetEdit: Return Pet

    PetEdit->>PetEdit: Create local draft state

    PetEdit->>AppCoordinator: Submit updated Pet
    AppCoordinator->>AppCoordinator: Update pets array
```

---

## Benefits of This Architecture

This approach provides several advantages:

- **Centralized navigation state**
- **Type-safe routing**
- **Predictable navigation flows**
- **Separation of concerns**
- **Easier debugging**
- **Better scalability as applications grow**

By keeping navigation logic within a coordinator, SwiftUI screens remain
focused on UI concerns rather than routing decisions.

