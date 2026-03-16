//
//  NavigationRouter.swift
//  SwiftUI-AppCoordinator-Demo
//
//  Created by Oliver Gilcher on 3/13/26.
//

import SwiftUI

// MARK: - NavigationRouter

/// Responsible for translating `AppScreen` routes into concrete SwiftUI views.
///
/// `NavigationRouter` acts as the bridge between the application's navigation
/// state and the actual view hierarchy. Given a route (`AppScreen`), the router
/// constructs and returns the appropriate screen.
///
/// This pattern keeps view construction separate from navigation logic,
/// allowing the `AppCoordinator` to focus purely on managing navigation state
/// while the router handles destination resolution.
///
/// Example:
/// ```swift
/// NavigationRouter.build(for: .pet(.details), coordinator: coordinator)
/// ```
///
/// - Note:
///   `AnyView` is used to erase the concrete view type so all cases can return
///   a single consistent return type (`some View`).
struct NavigationRouter {

    // MARK: - Route Resolution

    /// Builds the destination view for a given navigation route.
    ///
    /// - Parameters:
    ///   - screen: The route representing the destination to display.
    ///   - coordinator: The application's navigation coordinator.
    ///
    /// - Returns: The SwiftUI view corresponding to the provided route.
    static func build(
        for screen: AppScreen,
        coordinator: AppCoordinator
    ) -> some View {

        switch screen {
            
        // MARK: Core Routes
            
        case .core(let route):
            switch route {
            case .home:
                return AnyView(
                    HomeScreen()
                        .navigationBarBackButtonHidden()
                )
            }
            
        // MARK: Settings Routes
            
        case .settings(let route):
            switch route {
            case .dashboard:
                return AnyView(SettingsDashboard())
                
            case .personalization:
                return AnyView(SettingsPersonalization())
                
            case .security:
                return AnyView(SettingsSecurity())
            }
            
            
        // MARK: Pet Management Routes
            
        case .pet(let route):
            switch route {
            case .dashboard:
                return AnyView(PetDashboard())
                
            case .details(let petId):
                return AnyView(PetDetails(petId: petId))
                
            case .edit(let petId):
                return AnyView(PetEdit(petId: petId))
            }
        }
    }
}
