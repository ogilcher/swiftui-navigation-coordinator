//
//  AppCoordinator.swift
//  SwiftUI-AppCoordinator-Demo
//
//  Created by Oliver Gilcher on 3/13/26.
//

import SwiftUI

// MARK: - AppCoordinator

/// Coordinates global navigation and session-driven routing for the application.
///
/// `AppCoordinator` serves as the single source of truth for navigation state,
/// managing both the current root screen and the active navigation stack.
///
/// This object is responsible for:
/// - Bootstrapping the user session
/// - Determining the initial route at launch
/// - Managing stack-based navigation actions
/// - Resetting navigation when major flow changes occur
///
/// The coordinator is intended to be shared throughout the app and injected
/// into the SwiftUI environment so screens can trigger navigation without
/// owning routing logic directly.
@Observable
@MainActor
final class AppCoordinator {

    // MARK: - Navigation State

    /// The root screen currently presented by the application.
    var root: AppScreen = .core(.home)

    /// The active navigation stack presented above the current root.
    var path: [AppScreen] = []

    // MARK: - Session State

    /// Indicates whether the current user is authenticated.
    private var isAuthenticated = false

    /// Prevents session bootstrap from running more than once per lifecycle.
    private var didBootstrap = false
    
    /// Mock user data we use across this demonstration
    var pets: [Pet] = []

    // MARK: - Session Bootstrap

    /// Bootstraps the application session and routes to the appropriate
    /// initial destination.
    ///
    /// In a production implementation, this would typically query an
    /// authentication service, secure storage, or persisted session manager
    /// to determine whether a valid user session exists.
    ///
    /// For this demo, authentication is simulated and the user is routed
    /// directly to the home screen.
    func bootstrapSession() async {
        // Skip full bootstrap when running in SwiftUI previews so preview
        // rendering stays deterministic and independent of session logic.
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            print("[Bootstrap] Running in previews. Skipping session bootstrap.")

            lpUpdateWithoutAnimation {
                resetSession()
                populatePets()
                goToRoot(.core(.home))
            }
            return
        }

        guard !didBootstrap else { return }
        didBootstrap = true

        // In a real application, replace this with a session lookup such as:
        // - Restoring a token from Keychain
        // - Reading persisted auth state
        // - Validating the current session with an auth service
        //
        // For this demo, authentication is intentionally mocked so the
        // navigation flow can begin from the main application experience.
        print("[Bootstrap] Authenticated user found. Routing to home.")
        isAuthenticated = true
        
        populatePets()
        goHome()
    }

    /// Clears the current session state.
    private func resetSession() {
        isAuthenticated = false
        didBootstrap = false
    }
    
    /// Populates the user's "pets" with mock data
    private func populatePets() {
        pets = [
            Pet(id: UUID(), name: "Frank", type: .dog, age: 5, breed: "German Shephered"),
            Pet(id: UUID(), name: "Sansa", type: .cat, age: 2),
            Pet(id: UUID(), name: "Charlie", type: .cat, age: 1)
        ]
    }
}

// MARK: - Navigation

extension AppCoordinator {

    /// Pushes a new screen onto the navigation stack.
    ///
    /// - Parameter screen: The destination to present.
    func push(_ screen: AppScreen) {
        path.append(screen)
    }

    /// Pops the topmost screen from the navigation stack.
    func pop() {
        _ = path.popLast()
    }

    /// Routes the user to the application's home screen.
    func goHome() {
        goToRoot(.core(.home))
    }

    /// Replaces the current root and clears any stacked navigation state.
    ///
    /// - Parameter screen: The new root destination.
    func goToRoot(_ screen: AppScreen) {
        root = screen
        path.removeAll()
    }

    /// Clears the navigation stack and returns to the current root screen.
    func popToRoot() {
        path.removeAll()
    }
}

// MARK: - Pet Helpers

extension AppCoordinator {
    func pet(for id: UUID) -> Pet? {
        pets.first(where: { $0.id == id })
    }
    
    func updatePet(_ updatedPet: Pet) {
        guard let index = pets.firstIndex(where: { $0.id == updatedPet.id }) else { return }
        pets[index] = updatedPet
    }
}

// MARK: - Transaction Helpers

private extension Transaction {

    /// A transaction configuration that disables view animation.
    static var noAnimation: Transaction {
        Transaction(animation: nil)
    }
}

/// Performs state updates without animating the resulting UI changes.
///
/// - Parameter body: The state mutation block to execute.
@MainActor
private func lpUpdateWithoutAnimation(_ body: () -> Void) {
    withTransaction(.noAnimation, body)
}
