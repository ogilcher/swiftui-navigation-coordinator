//
//  AppScreen.swift
//  SwiftUI-AppCoordinator-Demo
//
//  Created by Oliver Gilcher on 3/13/26.
//

import Foundation

// MARK: - AppScreen

/// Represents every navigable destination in the application.
///
/// `AppScreen` serves as the canonical route type for the app's coordinator-based
/// navigation system. Each case maps to a feature domain, while the associated
/// path enum defines the concrete destination within that domain.
///
/// Centralizing navigation into a single route type improves consistency,
/// keeps navigation state type-safe, and prevents routing logic from becoming
/// scattered across the view hierarchy.
///
/// Example:
/// ```swift
/// coordinator.push(.pet(.details))
/// coordinator.push(.care(.appointments))
/// ```
enum AppScreen: Hashable, Sendable {
    case core(CorePath)
    case settings(SettingsPath)
    case pet(PetPath)
}

// MARK: - CorePath

/// Defines destinations that belong to the app's primary/root flow.
///
/// Use `CorePath` for foundational screens that act as major entry points
/// into the application experience.
enum CorePath: Hashable, Sendable {
    /// The application's primary landing screen.
    case home
}

// MARK: - SettingsPath

/// Defines destinations within the settings flow.
///
/// These routes represent configuration and account-management screens
/// that are typically accessed from a settings dashboard.
enum SettingsPath: Hashable, Sendable {
    /// The main settings landing screen.
    case dashboard

    /// The personalization and appearance configuration screen.
    case personalization

    /// The account and security management screen.
    case security
}

// MARK: - PetPath

/// Defines destinations within the pet-management flow.
///
/// These routes represent screens related to viewing and managing
/// pet-specific information.
enum PetPath: Hashable, Sendable {
    /// The main pet dashboard.
    case dashboard

    /// The pet details screen.
    case details(UUID)

    /// The pet editing screen.
    case edit(UUID)
}
